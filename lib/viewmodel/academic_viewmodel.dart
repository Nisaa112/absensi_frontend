import 'package:flutter/material.dart';
import 'package:aplikasi_absensi/service/api_service.dart';
import 'package:aplikasi_absensi/model/academic_model.dart';
import 'package:aplikasi_absensi/model/myschedule_model.dart';

class AcademicViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  academicModel? _academic;
  academicModel? get academic => _academic;

  myscheduleModel? _mySchedule;
  myscheduleModel? get mySchedule => _mySchedule;

  Future<void> loadDashboardData() async {
    _isLoading = true;
    notifyListeners();
    try {
      _academic = await ApiService.fetchAcademic();
      _mySchedule = await ApiService.fetchMySchedule();
    } catch (e) {
      debugPrint("Error Academic: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}