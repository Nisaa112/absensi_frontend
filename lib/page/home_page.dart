  import 'package:flutter/material.dart';

  class HomePage extends StatelessWidget {
    const HomePage({super.key});

    @override
    Widget build(BuildContext context) {
      return SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
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
                    children: const [
                      Text(
                        "Annisa Aulia Firdaus",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text("NIS: 0081239239", style: TextStyle(color: Colors.grey)),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 30),

              // Card Jadwal
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Jadwal XII RPL 2 Hari Ini",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(color: Color(0xFF0D1B2A), shape: BoxShape.circle),
                          child: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 15),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildScheduleRow("Senam", "6.30 - 7.10"),
                    _buildScheduleRow("Matematika", "7.10 - 9.10"),
                    _buildScheduleRow("B. Indo", "9.25 - 11.25"),
                    _buildScheduleRow("Konsentrasi Rpl", "12.30 - 14.30"),
                    _buildScheduleRow("BK", "14.30 - 15.10"),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              SizedBox(
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildDateCard("Minggu", "22"),
                    _buildDateCard("Senin", "23"),
                    _buildDateCard("Selasa", "24", isSelected: true),
                    _buildDateCard("Rabu", "25"),
                    _buildDateCard("Kamis", "26"),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              const Text("Rekap Bulanan:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 15),

              // Grid Statistik
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.2,
                children: [
                  _buildStatCard("Total Hadir", "18", Colors.white, Colors.black),
                  _buildStatCard("Total Sakit", "1", const Color(0xFF135D66), Colors.white),
                  _buildStatCard("Total Izin", "2", Colors.orange, Colors.white),
                  _buildStatCard("Total Alpa", "0", Colors.white, Colors.black),
                ],
              ),
              const SizedBox(height: 100), // Ruang ekstra agar tidak tertutup FAB
            ],
          ),
        ),
      );
    }

    // Widget pembantu tetap sama
    Widget _buildScheduleRow(String subject, String time) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(subject, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
            Text(time, style: const TextStyle(color: Colors.white70)),
          ],
        ),
      );
    }

    Widget _buildDateCard(String day, String date, {bool isSelected = false}) {
      return Container(
        width: 70,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE0E0E0) : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(day, style: const TextStyle(fontSize: 12, color: Colors.black54)),
            Text(date, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }

    Widget _buildStatCard(String title, String count, Color bgColor, Color textColor) {
      return Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(count, style: TextStyle(color: textColor, fontSize: 40, fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }
  }