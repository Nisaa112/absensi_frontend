import 'dart:convert';
import 'package:aplikasi_absensi/device_helper.dart';
import 'package:aplikasi_absensi/model/login_model.dart'; 
import 'package:aplikasi_absensi/utils/token_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl = 'https://cod-active-bluejay.ngrok-free.app/api';

  Future<bool> verifyToken(String token) async {
    final url = Uri.parse('$_baseUrl/profile'); 
    
    try {
        final response = await http.get(
            url,
            headers: {
                'Authorization': 'Bearer $token',
                'Accept': 'application/json',
                'Content-Type': 'application/json',
                'ngrok-skip-browser-warning': 'true', // Tambahan untuk ngrok
            },
        ).timeout(const Duration(seconds: 15));

        return response.statusCode == 200;
    } catch (e) {
        print('❌ Error saat verifikasi token: $e');
        return false;
    }
  }

  Future<loginModel> login(String serial, String password) async { 
    final url = Uri.parse('$_baseUrl/login');

    try {
      // PERHATIAN: Jika error Unsupported Operation muncul di sini, 
      // cek file device_helper.dart dan pastikan ada pengecekan kIsWeb.
      String autoDeviceId;
      try {
        autoDeviceId = await DeviceHelper.getDeviceId();
      } catch (e) {
        print('⚠️ Gagal mengambil Device ID, menggunakan fallback: $e');
        autoDeviceId = 'unknown_device';
      }

      print('🚀 Melakukan login untuk: $serial ke $_baseUrl');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'serial_number': serial,
          'password': password,
          'device_id': autoDeviceId, 
        }),
      ).timeout(const Duration(seconds: 30));

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return loginModel.fromJson(responseBody);
      } else {
        throw Exception(responseBody['message'] ?? 'Gagal login (Status: ${response.statusCode})');
      }
    } catch (e) {
      print('❌ Error di AuthService Login: $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    final token = await TokenStorage.getToken();
    
    if (token != null) {
      try {
        await http.post(
          Uri.parse('$_baseUrl/logout'),
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ).timeout(const Duration(seconds: 5));
      } catch (e) {
        print('Warning: Gagal memanggil API logout ke server.');
      }
    }
    await TokenStorage.clearAll();
  }
}