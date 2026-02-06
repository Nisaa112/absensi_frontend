import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:aplikasi_absensi/viewmodel/attendance_viewmodel.dart';
import 'package:aplikasi_absensi/viewmodel/schedule_viewmodel.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  bool _isProcessing = false;
  final MobileScannerController cameraController = MobileScannerController();

  dynamic _getActiveSchedule(ScheduleViewModel scheduleVM) {
    try {
      final now = DateTime.now();
      return scheduleVM.schedules.firstWhere((s) {
        final String? jamMulai = s.jamMulai;
        final String? jamSelesai = s.jamSelesai;

        if (jamMulai == null || jamSelesai == null) return false;

        final start = jamMulai.split(':');
        final end = jamSelesai.split(':');
        
        final startTime = DateTime(now.year, now.month, now.day, int.parse(start[0]), int.parse(start[1]));
        final endTime = DateTime(now.year, now.month, now.day, int.parse(end[0]), int.parse(end[1]));
        
        return now.isAfter(startTime) && now.isBefore(endTime);
      });
    } catch (e) {
      return null;
    }
  }

  Future<void> _processScan(String token) async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    final attendanceVM = context.read<AttendanceViewModel>();
    final scheduleVM = context.read<ScheduleViewModel>();

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final activeSchedule = _getActiveSchedule(scheduleVM);
      if (activeSchedule != null && activeSchedule.lokasi != null) {
        double distance = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          double.parse(activeSchedule.lokasi.latitude.toString()),
          double.parse(activeSchedule.lokasi.longitude.toString()),
        );

        double radiusLimit = double.parse(activeSchedule.lokasi.radius.toString());

        if (distance > radiusLimit) {
          throw "Terlalu jauh dari sekolah (${distance.toInt()}m).";
        }
      }

      final result = await attendanceVM.scanQR(
        token, 
        position.latitude, 
        position.longitude
      );

      if (!mounted) return;

      if (result != null) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Absensi Berhasil!"), backgroundColor: Colors.green),
        );
      } else {
        throw attendanceVM.errorMessage ?? "Gagal Absen";
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
      setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QR Absensi"),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0D1B2A),
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (BarcodeCapture capture) {
              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
                _processScan(barcodes.first.rawValue!);
              }
            },
          ),
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange, width: 3),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          if (_isProcessing)
            const Center(child: CircularProgressIndicator(color: Colors.orange)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}