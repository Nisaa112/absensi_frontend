import 'dart:async';
import 'package:aplikasi_absensi/viewmodel/attendance_viewmodel.dart';
import 'package:aplikasi_absensi/viewmodel/auth_viewmodel.dart';
import 'package:aplikasi_absensi/viewmodel/schedule_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GuruHomePage extends StatefulWidget {
  const GuruHomePage({super.key});

  @override
  State<GuruHomePage> createState() => _GuruHomePageState();
}

class _GuruHomePageState extends State<GuruHomePage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ScheduleViewModel>().fetchMySchedule();
    });

    // Jalankan timer untuk merefresh UI setiap 1 menit agar pengecekan jam selalu update
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Hentikan timer saat halaman ditutup
    super.dispose();
  }

  // --- LOGIKA FILTER WAKTU ---
  bool _isCurrentSchedule(String? jamMulai, String? jamSelesai) {
    if (jamMulai == null || jamSelesai == null) return false;

    try {
      final now = DateTime.now();
      
      // Asumsi format API adalah "HH:mm:ss" atau "HH:mm" (contoh: "07:30:00")
      final startParts = jamMulai.split(':');
      final endParts = jamSelesai.split(':');

      final startTime = DateTime(now.year, now.month, now.day, int.parse(startParts[0]), int.parse(startParts[1]));
      final endTime = DateTime(now.year, now.month, now.day, int.parse(endParts[0]), int.parse(endParts[1]));

      // Jadwal aktif jika waktu sekarang berada di antara jam mulai dan jam selesai
      return now.isAfter(startTime) && now.isBefore(endTime);
    } catch (e) {
      return false;
    }
  }

  void _showQrCodeModal(BuildContext context, String token) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 50, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
              const SizedBox(height: 20),
              const Text("QR Sesi Absensi", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text("Minta siswa untuk melakukan scan", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 30),
              QrImageView(
                data: token,
                version: QrVersions.auto,
                size: 250.0,
                eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: Color(0xFF135D66)),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF135D66),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text("Tutup Sesi", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authVM = context.watch<AuthViewModel>();
    final scheduleVM = context.watch<ScheduleViewModel>();
    final attendanceVM = context.watch<AttendanceViewModel>();
    final schedules = scheduleVM.schedules;

    // CARI JADWAL YANG SEDANG BERLANGSUNG SAAT INI
    dynamic activeSchedule;
    try {
      activeSchedule = schedules.firstWhere(
        (s) => _isCurrentSchedule(s.jamMulai, s.jamSelesai),
      );
    } catch (e) {
      activeSchedule = null;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => await scheduleVM.fetchMySchedule(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Profil
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundColor: Color(0xFFE0E0E0),
                      child: Icon(Icons.person, color: Colors.grey),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(authVM.userName ?? "Nama Guru", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        Text("NIP: ${authVM.userSerial ?? '-'}", style: const TextStyle(color: Colors.grey)),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 25),

                // Summary Cards
                Row(
                  children: [
                    _buildSummaryCard("${schedules.length} Kelas\nHari ini", const Color(0xFF135D66), Icons.class_outlined),
                    const SizedBox(width: 15),
                    _buildSummaryCard("0 Perizinan\nbaru", Colors.orange, Icons.assignment_late_outlined),
                  ],
                ),
                const SizedBox(height: 30),

                // Bagian Jadwal Saat Ini (Dinamis)
                const Text("JADWAL SAAT INI", 
                  style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2, color: Color(0xFF135D66), fontSize: 12)),
                const SizedBox(height: 10),

                if (scheduleVM.isLoading)
                  const Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator()))
                else if (activeSchedule != null)
                  _buildTeachingCard(activeSchedule, attendanceVM)
                else
                  _buildNoScheduleCard(),

                const SizedBox(height: 30),
                
                // Bagian Perizinan
                const Text("Perizinan Baru", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 10),
                const Text("Belum ada perizinan masuk.", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNoScheduleCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: const [
          Icon(Icons.timer_off_outlined, color: Colors.grey, size: 50),
          SizedBox(height: 15),
          Text("Tidak Ada Jadwal Mengajar", 
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
          Text("Saat ini Anda sedang tidak dalam jam mengajar.", 
            textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, Color color, IconData icon) {
    return Expanded(
      child: Container(
        height: 110,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            Positioned(bottom: -5, right: -5, child: Icon(icon, color: Colors.white.withOpacity(0.2), size: 60)),
          ],
        ),
      ),
    );
  }

  Widget _buildTeachingCard(dynamic jadwal, AttendanceViewModel attendanceVM) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 5))],
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(jadwal.kelas?.namaKelas ?? "-", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: Colors.orange.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: const Text("Sedang Berlangsung", style: TextStyle(color: Colors.orange, fontSize: 10, fontWeight: FontWeight.bold)),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.book_outlined, size: 16, color: Colors.grey),
              const SizedBox(width: 5),
              Text("Mapel: ${jadwal.mapel?.namaMapel ?? '-'}"),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.access_time, size: 16, color: Colors.grey),
              const SizedBox(width: 5),
              Text("Waktu: ${jadwal.jamMulai ?? '-'} - ${jadwal.jamSelesai ?? '-'}"),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: attendanceVM.isLoading ? null : () async {
                await attendanceVM.createSession(jadwal.id!);
                if (attendanceVM.sessionData?.tokenQr != null) {
                  if (!mounted) return;
                  _showQrCodeModal(context, attendanceVM.sessionData!.tokenQr!);
                }
              },
              icon: attendanceVM.isLoading 
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                : const Icon(Icons.qr_code_scanner, color: Colors.white, size: 24),
              label: Text(attendanceVM.isLoading ? "Membuka Sesi..." : "BUKA SESI ABSENSI", 
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 0,
              ),
            ),
          )
        ],
      ),
    );
  }
}