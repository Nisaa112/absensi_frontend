import 'package:flutter/material.dart';
import 'package:aplikasi_absensi/service/api_service.dart';
import 'package:aplikasi_absensi/model/academic_model.dart';

class ReportViewModel extends ChangeNotifier {
  bool _isLoading = false;
  List<DaftarKelas> _listKelas = [];
  List<DaftarMapel> _listMapel = [];
  TahunAktif? _tahunAktif;

  int? selectedTahunId;
  int? selectedKelasId;
  int? selectedMapelId;

  bool get isLoading => _isLoading;
  List<DaftarKelas> get listKelas => _listKelas;
  List<DaftarMapel> get listMapel => _listMapel;
  TahunAktif? get tahunAktif => _tahunAktif;

  Future<void> loadDropdownData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final academicData = await ApiService.fetchAcademic();
      if (academicData != null) {
        _listKelas = academicData.daftarKelas ?? [];
        _listMapel = academicData.daftarMapel ?? [];
        _tahunAktif = academicData.tahunAktif;
        
        if (_tahunAktif != null) {
          selectedTahunId = _tahunAktif!.id;
        }
      }
    } catch (e) {
      debugPrint("Error loading dropdown data: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> processDownload(BuildContext context) async {
    if (selectedKelasId == null || selectedTahunId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pilih Tahun Ajaran dan Kelas terlebih dahulu!")),
      );
      return;
    }

    try {
      await ApiService.downloadReport(
        selectedTahunId.toString(), 
        selectedKelasId.toString()
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal mengunduh laporan: $e")),
      );
    }
  }
}