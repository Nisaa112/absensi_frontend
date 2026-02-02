import 'package:aplikasi_absensi/db_helper.dart';
import 'package:aplikasi_absensi/model/user_model.dart' as userModel;
import 'package:aplikasi_absensi/service/api_service.dart';
import 'package:flutter/foundation.dart';

class UserViewModel extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  List<userModel.Data> _users = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<userModel.Data> get users => _users;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchUsers() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _users = await _dbHelper.getAllUsers();
      notifyListeners();

      await synchronizeUsers();
    } catch (e) {
      _errorMessage = "Gagal memuat data user: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> synchronizeUsers() async {
    try {
      final List<userModel.Data> apiUsers = await ApiService.fetchUsers();
      
      await _dbHelper.clearUserTable();
      for (var user in apiUsers) {
        await _dbHelper.insertUser(user);
      }
      
      _users = apiUsers;
      notifyListeners();
    } catch (e) {
      print('⚠️ Sync User gagal: $e');
    }
  }

  Future<void> createUser({
    required String name,
    required String serial,
    required String role,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final userRequest = userModel.Data(
        name: name,
        serialNumber: serial,
        role: role,
      );

      final Map<String, dynamic> body = userRequest.toJson();
      body['password'] = password;
      body['password_confirmation'] = password;
      
    } catch (e) {
      _errorMessage = "Gagal membuat user: $e";
      rethrow; 
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteUser(int id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await ApiService.deleteUser(id);
      await _dbHelper.deleteUser(id);

      _users.removeWhere((u) => u.id == id);
    } catch (e) {
      _errorMessage = "Gagal menghapus user: $e";
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}