import 'package:flutter/material.dart';
import 'package:aplikasi_absensi/service/api_service.dart';
import 'package:aplikasi_absensi/model/user_model.dart' as userModel;

class UserViewModel extends ChangeNotifier {
  List<userModel.Data> _listUsers = [];
  List<userModel.Data> get listUsers => _listUsers;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> loadUsers() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Jika pakai DB Helper seperti contohmu:
      // _listUsers = await _dbHelper.getAllUsers(); 
      
      final apiUsers = await ApiService.fetchUsers();
      _listUsers = apiUsers;
      _listUsers.sort((a, b) => a.id!.compareTo(b.id!));
    } catch (e) {
      _errorMessage = 'Gagal memuat data User: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createUser(userModel.Data user) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newUser = await ApiService.createUser(user);
      if (newUser != null) {
        _listUsers.add(newUser);
        _listUsers.sort((a, b) => a.id!.compareTo(b.id!));
      }
    } catch (e) {
      _errorMessage = 'Gagal menambah User: $e';
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUser(userModel.Data user) async {
    _isLoading = true;
    notifyListeners();
    try {
      await ApiService.updateUser(user);
      final index = _listUsers.indexWhere((element) => element.id == user.id);
      if (index != -1) {
        _listUsers[index] = user;
      }
    } catch (e) {
      _errorMessage = 'Gagal update User: $e';
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteUser(int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await ApiService.deleteUser(id);
      _listUsers.removeWhere((element) => element.id == id);
    } catch (e) {
      _errorMessage = 'Gagal menghapus User: $e';
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}