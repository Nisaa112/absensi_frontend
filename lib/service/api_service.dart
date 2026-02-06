import 'dart:convert';
// import 'dart:io';
import 'package:aplikasi_absensi/model/academic_model.dart';
import 'package:aplikasi_absensi/model/apply_permission_model.dart';
import 'package:aplikasi_absensi/model/attendance_scan_model.dart';
import 'package:aplikasi_absensi/model/attendance_session_model.dart';
import 'package:aplikasi_absensi/model/guru_model.dart';
import 'package:aplikasi_absensi/model/history_model.dart';
import 'package:aplikasi_absensi/model/jadwal_model.dart';
import 'package:aplikasi_absensi/model/kelas_model.dart';
import 'package:aplikasi_absensi/model/mapel_model.dart';
import 'package:aplikasi_absensi/model/myschedule_model.dart';
import 'package:aplikasi_absensi/model/report_filter_model.dart';
import 'package:aplikasi_absensi/model/siswa_,model.dart' show siswaModel;
import 'package:aplikasi_absensi/model/user_model.dart' as userModel;
import 'package:aplikasi_absensi/model/validate_permission_model.dart';
import 'package:aplikasi_absensi/utils/token_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';

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

  // --------------------------------------------------------------------------
  // --- ACADEMIC & SCHEDULE ---
  // --------------------------------------------------------------------------

  static Future<academicModel?> fetchAcademic() async {
    final token = await TokenStorage.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/academic'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'ngrok-skip-browser-warning': 'true',
      },
    );

    if (response.statusCode == 200) {
      return academicModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal mengambil data akademik');
    }
  }

  static Future<myscheduleModel?> fetchMySchedule() async {
    final token = await TokenStorage.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/schedule/mine'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'ngrok-skip-browser-warning': 'true',
      },
    );

    if (response.statusCode == 200) {
      return myscheduleModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal mengambil jadwal');
    }
  }

  // --------------------------------------------------------------------------
  // --- ATTENDANCE (SESSION & SCAN) ---
  // --------------------------------------------------------------------------

  static Future<attendancesessionModel?> createAttendanceSession(int jadwalId) async {
    final token = await TokenStorage.getToken();
    final result = await _handleApiRequest(
      http.post(
        Uri.parse('$baseUrl/attendance/session'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'jadwal_id': jadwalId}),
      ),
      'membuat sesi',
      'attendance',
    );

    if (result != null) {
      return attendancesessionModel.fromJson(result);
    }
    return null;
  }

  static Future<attendancescanModel?> scanQR(String tokenQr, double lat, double lng) async {
    final token = await TokenStorage.getToken();
    final result = await _handleApiRequest(
      http.post(
        Uri.parse('$baseUrl/attendance/scan'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'token_qr': tokenQr,
          'lat_siswa': lat,
          'long_siswa': lng,
        }),
      ),
      'melakukan scan',
      'attendance',
    );

    if (result != null) {
      return attendancescanModel.fromJson(result);
    }
    return null;
  }

  // --------------------------------------------------------------------------
  // --- PERMISSION (APPLY & VALIDATE) ---
  // --------------------------------------------------------------------------

  static Future<applypermissionModel?> applyPermission({
    required String jenisIzin,
    required String alasan,
    required int validatorId,
    required XFile imageFile, 
  }) async {
    final token = await TokenStorage.getToken();
    final uri = Uri.parse('$baseUrl/permission/apply');

    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    request.fields['jenis_izin'] = jenisIzin;
    request.fields['alasan'] = alasan;
    request.fields['validator_id'] = validatorId.toString();

    // Multipart untuk XFile (Support Web & Mobile)
    var bytes = await imageFile.readAsBytes();
    var multipartFile = http.MultipartFile.fromBytes(
      'bukti',
      bytes,
      filename: imageFile.name,
    );
    
    request.files.add(multipartFile);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return applypermissionModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal mengajukan izin: ${response.body}');
    }
  }

  static Future<validatepermissionModel?> validatePermission(int id, String status) async {
    final token = await TokenStorage.getToken();
    final result = await _handleApiRequest(
      http.put(
        Uri.parse('$baseUrl/permission/validate/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'status': status}),
      ),
      'memvalidasi',
      'izin',
    );

    if (result != null) {
      return validatepermissionModel.fromJson(result);
    }
    return null;
  }

  // --------------------------------------------------------------------------
  // --- MASTER DATA CRUD (KELAS, MAPEL, GURU, SISWA, JADWAL) ---
  // --------------------------------------------------------------------------

  static Future<List<kelasModel>> fetchKelas() async {
    final token = await TokenStorage.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/kelas'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((json) => kelasModel.fromJson(json)).toList();
    }
    return [];
  }

  static Future<List<guruModel>> fetchGuru() async {
    final token = await TokenStorage.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/guru'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((json) => guruModel.fromJson(json)).toList();
    }
    return [];
  }
  static Future<List<guruModel>> fetchPerizinan() async {
    final token = await TokenStorage.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/perizinan'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((json) => guruModel.fromJson(json)).toList();
    }
    return [];
  }

  static Future<List<siswaModel>> fetchSiswa() async {
    final token = await TokenStorage.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/siswa'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((json) => siswaModel.fromJson(json)).toList();
    }
    return [];
  }

  static Future<List<mapelModel>> fetchMapel() async {
    final token = await TokenStorage.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/mapel'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((json) => mapelModel.fromJson(json)).toList();
    }
    return [];
  }

  static Future<List<jadwalModel>> fetchJadwal() async {
    final token = await TokenStorage.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/jadwal'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((json) => jadwalModel.fromJson(json)).toList();
    }
    return [];
  }

  static Future<List<HistoryModel>> fetchRiwayat() async {
    final token = await TokenStorage.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/absensi/riwayat'),
      headers: {
        'Authorization': 'Bearer $token', 
        'Accept': 'application/json',
        'ngrok-skip-browser-warning': 'true',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> data = body['data'] ?? [];
      return data.map((json) => HistoryModel.fromJson(json)).toList();
    } else {
      throw Exception('Gagal mengambil riwayat: ${response.statusCode}');
    }
  }

  static Future<List<dynamic>> fetchReportGuru(String tahunId, String kelasId) async {
    final token = await TokenStorage.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/api/report-guru?tahun_ajaran_id=$tahunId&kelas_id=$kelasId'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    throw 'Gagal mengambil data laporan';
  }

  static Future<void> downloadReport(String tahunId, String kelasId) async {
    final token = await TokenStorage.getToken(); 
    final url = Uri.parse(
      '$baseUrl/api/report-guru/export?tahun_ajaran_id=$tahunId&kelas_id=$kelasId&token=$token'
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Tidak dapat membuka link download';
    }
  }

}