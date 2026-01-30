import 'package:aplikasi_absensi/widgets/guru_navbar.dart';
import 'package:flutter/material.dart';

class GuruHomePage extends StatelessWidget {
  const GuruHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(radius: 25, backgroundColor: Color(0xFFE0E0E0)),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Kim Seungmin", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text("NIP: 0081239239", style: TextStyle(color: Colors.grey)),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 25),

              Row(
                children: [
                  _buildSummaryCard(
                    "3 Kelas\nHari ini", 
                    const Color(0xFF135D66), 
                    Icons.class_outlined, 
                  ),
                  const SizedBox(width: 15),
                  _buildSummaryCard(
                    "5 Perizinan\nbaru", 
                    Colors.orange, 
                    Icons.assignment_late_outlined, 
                  ),
                ],
              ),
              const SizedBox(height: 25),

              const Text("Jadwal Hari Ini:", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF135D66))),
              const SizedBox(height: 10),
              _buildTeachingCard(),

              const SizedBox(height: 25),

              const Text("Perizinan Baru", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 15),
              _buildPermissionItem("Annisa Aulia XII PPLG-RPL 2", "Jenis: Sakit"),
              _buildPermissionItem("Seungmin XII PPLG-RPL 2", "Jenis: Izin"),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const GuruNavbar(currentIndex: 0),
    );
  }

  Widget _buildSummaryCard(String title, Color color, IconData icon) {
    return Expanded(
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: color, 
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white, 
                  fontSize: 22, 
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Icon(
                icon,
                color: Colors.white.withOpacity(0.3),
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeachingCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("XII PPLG-RPL 1", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange)),
          const SizedBox(height: 5),
          const Text("Mapel: Matematika"),
          const Text("Lokasi: Kelas XII PPLG-RPL 1"),
          const Text("Waktu: 13.00-15.10"),
          const SizedBox(height: 10),
          Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.green, size: 16),
              SizedBox(width: 5),
              Text("Terdeteksi GPS", style: TextStyle(color: Colors.green, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
              },
              icon: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 28),
              label: const Text(
                "Buka Sesi Absensi", 
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 18, 
                  fontWeight: FontWeight.bold
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 62), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 0, 
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPermissionItem(String name, String type) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(type, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              minimumSize: const Size(60, 30),
            ),
            child: const Text("Detail", style: TextStyle(fontSize: 12, color: Colors.white)),
          )
        ],
      ),
    );
  }
}