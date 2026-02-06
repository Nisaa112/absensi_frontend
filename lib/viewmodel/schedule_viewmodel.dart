import 'package:aplikasi_absensi/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_absensi/model/myschedule_model.dart';

class ScheduleViewModel extends ChangeNotifier {
  myscheduleModel? _scheduleModel;
  List<Data> _schedules = [];
  bool _isLoading = false;
  String? _errorMessage;

  myscheduleModel? get scheduleModel => _scheduleModel;
  List<Data> get schedules => _schedules;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchMySchedule() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await ApiService.fetchMySchedule();

      if (result != null) {
        _scheduleModel = result;
        _schedules = result.data ?? [];
      } else {
        _errorMessage = "Data jadwal tidak ditemukan.";
      }
    } catch (e) {
      _errorMessage = e.toString();
      print("❌ Error di ScheduleViewModel: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Data? get firstSchedule => _schedules.isNotEmpty ? _schedules.first : null;

  Future<void> refresh() async {
    await fetchMySchedule();
  }
}