import 'package:aplikasi_absensi/service/auth_service.dart';
import 'package:aplikasi_absensi/utils/token_storage.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _userName;
  String? get userName => _userName;
  
  String? _userSerial; 
  String? get userSerial => _userSerial;
  
  String? _userRole; 
  String? get userRole => _userRole;

  int? _userId;
  int? get userId => _userId;

  String? _token;
  String? get token => _token;

  AuthViewModel() {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    _isLoading = true;
    notifyListeners();

    _token = await TokenStorage.getToken();

    if (_token != null && _token!.isNotEmpty) {
      print('⏳ Token lokal ditemukan. Memvalidasi ke server...');
      
      final isTokenValid = await _authService.verifyToken(_token!);
      
      if (isTokenValid) {
        _userId = await TokenStorage.getUserId();
        _userName = await TokenStorage.getUserName();
        _userSerial = await TokenStorage.getUserSerialNumber();
        _userRole = await TokenStorage.getUserRole();
        _isLoggedIn = true;
        print('✅ Sesi valid untuk user: $_userName (Role: $_userRole)');
      } else {
        print('⚠️ Token tidak valid. Sesi dihapus.');
        await TokenStorage.clearAll();
        _resetLocalState();
      }
    } else {
      _isLoggedIn = false;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> login(String serial, String password) async { 
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final loginData = await _authService.login(serial, password);
      
      final user = loginData.user; 
      final token = loginData.authorization?.token;

      if (user == null || token == null) {
        throw Exception("Data user atau token tidak ditemukan");
      }

      await TokenStorage.saveUserSession(
        token: token,
        id: user.id!,
        name: user.name,
        serialNumber: user.serialNumber!,
        role: user.role!,
      ); 

      _isLoggedIn = true;
      _token = token;
      _userId = user.id;
      _userName = user.name;
      _userSerial = user.serialNumber; 
      _userRole = user.role; 

      _isLoading = false;
      notifyListeners();
      return true; 
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> logout(BuildContext context) async {
    await _authService.logout(); 
    _resetLocalState();
    
    print("🔴 Pengguna berhasil logout.");
    notifyListeners();

    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  void _resetLocalState() {
    _isLoggedIn = false;
    _token = null;
    _userId = null;
    _userName = null;
    _userSerial = null;
    _userRole = null;
  }
}