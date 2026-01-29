import 'package:aplikasi_absensi/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Riwayat Kehadiran",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          _buildHistoryItem(
            icon: Icons.person_add_rounded,
            title: "Hadir Mapel Matematika",
            date: "1/28/2026",
            time: "07.10",
          ),
          _buildHistoryItem(
            icon: Icons.personal_video_rounded, // Ikon mendekati gambar sakit/perban
            title: "Izin Sakit Mapel PAB",
            date: "2/28/2026",
            time: "07.10",
          ),
          _buildHistoryItem(
            icon: Icons.cancel_rounded,
            title: "Alpa Mapel Konsentrasi RPL",
            date: "3/28/2026",
            time: "07.10",
          ),
          _buildHistoryItem(
            icon: Icons.email_rounded,
            title: "Dispen Mapel B Indonesia",
            date: "4/28/2026",
            time: "07.10",
          ),
        ],
      ),
      // Gunakan navbar reusable kita dengan currentIndex 2
      bottomNavigationBar: const CustomNavbar(currentIndex: 2, showFabSpace: false),
    );
  }

  Widget _buildHistoryItem({
    required IconData icon,
    required String title,
    required String date,
    required String time,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            children: [
              // Icon Section
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.black, size: 28),
              ),
              const SizedBox(width: 15),
              // Text Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
              // Time Section
              Text(
                time,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ),
        const Divider(thickness: 1, height: 1), // Garis pemisah sesuai gambar
      ],
    );
  }
}