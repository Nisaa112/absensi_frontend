import 'dart:convert';
import 'package:aplikasi_absensi/model/user_model.dart' as userModel;
import 'package:aplikasi_absensi/utils/token_storage.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://cod-active-bluejay.ngrok-free.app/api';

  static Future<Map<String, String>> _getHeaders() async {
    final token = await TokenStorage.getToken();
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'ngrok-skip-browser-warning': 'true',
    };
  }

  static Future<dynamic> get(String endpoint) async {
    final headers = await _getHeaders();
    final request = http.get(Uri.parse('$baseUrl/$endpoint'), headers: headers);
    return _handleApiRequest(request, 'mengambil', endpoint);
  }

  static Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final headers = await _getHeaders();
    final request = http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: headers,
      body: jsonEncode(body),
    );
    return _handleApiRequest(request, 'mengirim', endpoint);
  }

  static Future<dynamic> _handleApiRequest(
      Future<http.Response> request, String operationType, String endpoint) async {
    try {
      final response = await request.timeout(const Duration(seconds: 15));
      print("📤 DEBUG $endpoint [${response.statusCode}]: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isEmpty) return null;
        final decoded = jsonDecode(response.body);

        if (decoded is Map && decoded.containsKey('data')) {
          return decoded['data'];
        }
        return decoded; 
      } else {
        throw Exception('Gagal $operationType $endpoint. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error $operationType $endpoint: $e');
    }
  }

  // --------------------------------------------------------------------------
  // --- USER SERVICE ---
  // --------------------------------------------------------------------------

  static Future<List<userModel.Data>> fetchUsers() async {
    final result = await get('user');
    
    if (result is List) {
      return result.map((json) => userModel.Data.fromJson(json)).toList();
    }
    return [];
  }

  static Future<userModel.Data?> createUser(userModel.Data user) async {
    final result = await post('user', user.toJson());
    
    if (result != null) {
      return userModel.Data.fromJson(result);
    }
    return null;
  }

  static Future<void> updateUser(userModel.Data user) async {
    final headers = await _getHeaders();
    final endpoint = 'user/${user.id}';
    
    final request = http.put(
      Uri.parse('$baseUrl/$endpoint'),
      headers: headers,
      body: jsonEncode(user.toJson()),
    );

    await _handleApiRequest(request, 'mengupdate', endpoint);
  }

  static Future<void> deleteUser(int id) async {
    final headers = await _getHeaders();
    final endpoint = 'user/$id';

    final request = http.delete(
      Uri.parse('$baseUrl/$endpoint'),
      headers: headers,
    );

    await _handleApiRequest(request, 'menghapus', endpoint);
  }
}