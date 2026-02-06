// lib/page/history_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aplikasi_absensi/viewmodel/attendance_viewmodel.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<AttendanceViewModel>().fetchHistory());
  }

  IconData _getIcon(String status) {
    switch (status.toLowerCase()) {
      case 'hadir': return Icons.person_add;
      case 'sakit': 
      case 'izin': return Icons.healing_outlined;
      case 'alpa': return Icons.cancel_outlined;
      case 'dispen': return Icons.mail_outline;
      default: return Icons.history;
    }
  }

  @override
  Widget build(BuildContext context) {
    final attendanceVM = context.watch<AttendanceViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Riwayat Kehadiran", 
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false, 
      ),
      body: attendanceVM.isLoading
          ? const Center(child: CircularProgressIndicator())
          : attendanceVM.historyList.isEmpty
              ? const Center(child: Text("Belum ada data riwayat"))
              : RefreshIndicator(
                  onRefresh: () => attendanceVM.fetchHistory(),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: attendanceVM.historyList.length,
                    separatorBuilder: (context, index) => const Divider(height: 30),
                    itemBuilder: (context, index) {
                      final item = attendanceVM.historyList[index];
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Icon(_getIcon(item.status), size: 28, color: Colors.black)
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${item.status[0].toUpperCase()}${item.status.substring(1)} Mapel ${item.namaMapel}",
                                  style: const TextStyle(
                                    fontSize: 16, 
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2D3142)
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.tanggal, 
                                  style: TextStyle(color: Colors.grey[500], fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            item.waktu, 
                            style: TextStyle(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        ],
                      );
                    },
                  ),
                ),
    );
  }
}