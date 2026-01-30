import 'dart:convert';
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
            },
        ).timeout(const Duration(seconds: 15));

        if (response.statusCode == 200) {
            return true; 
        }
        return false;
    } catch (e) {
        print('❌ Error saat verifikasi token: $e');
        return false;
    }
  }

  Future<loginModel> login(String serial, String password) async { 
    final url = Uri.parse('$_baseUrl/login');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'serial_number': serial,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 30));

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = loginModel.fromJson(responseBody);
        
        if (data.authorization?.token != null && data.user != null) {
          await TokenStorage.saveUserSession(
            token: data.authorization!.token!,
            id: data.user!.id!,
            name: data.user!.name,
            serialNumber: data.user!.serialNumber!,
            role: data.user!.role!,
          );
        }
        
        return data;
      } else {
        throw Exception(responseBody['message'] ?? 'Gagal login');
      }
    } catch (e) {
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
        );
      } catch (e) {
        print('Warning: Gagal memanggil API logout ke server.');
      }
    }
    await TokenStorage.clearAll();
  }
}