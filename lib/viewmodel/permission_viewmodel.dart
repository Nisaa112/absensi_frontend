import 'package:flutter/material.dart';
import 'package:aplikasi_absensi/service/api_service.dart';
// import 'package:aplikasi_absensi/model/apply_permission_model.dart'; // Aktifkan jika dibutuhkan
import 'package:image_picker/image_picker.dart'; // Gunakan XFile

class PermissionViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> submitPermission({
    required String jenis,
    required String alasan,
    required int validatorId,
    required XFile file, // DIUBAH: Gunakan XFile, bukan File
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      final res = await ApiService.applyPermission(
        jenisIzin: jenis,
        alasan: alasan,
        validatorId: validatorId,
        imageFile: file, // DIUBAH: Sesuaikan nama variabel dari parameter
      );
      return res != null;
    } catch (e) {
      debugPrint("Error di PermissionViewModel: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> validateIzin(int id, String status) async {
    _isLoading = true;
    notifyListeners();
    try {
      await ApiService.validatePermission(id, status);
    } catch (e) {
      debugPrint("Error Validate: $e");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}