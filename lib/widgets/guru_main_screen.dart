import 'package:aplikasi_absensi/page/guru_home_page.dart';
import 'package:aplikasi_absensi/page/history_page.dart';
import 'package:aplikasi_absensi/page/profile_page.dart';
import 'package:flutter/material.dart';

class GuruMainScreen extends StatefulWidget {
  const GuruMainScreen({super.key});

  @override
  State<GuruMainScreen> createState() => _GuruMainScreenState();
}

class _GuruMainScreenState extends State<GuruMainScreen> {
  int _selectedIndex = 0;

  // Daftar halaman yang akan ditampilkan
  final List<Widget> _pages = [
    const GuruHomePage(),
    const Center(child: Text("Halaman Absensi (Belum Dibuat)")), // Index 1
    const HistoryPage(),                                     // Index 2
    const ProfilePage(),                                     // Index 3
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Menggunakan IndexedStack agar data di halaman tidak hilang saat pindah tab
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
        child: BottomAppBar(
          height: 70,
          color: const Color(0xFF0D1B2A), // Warna gelap asli Anda
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavItem(Icons.home, 0),
              _buildNavItem(Icons.assignment_ind_outlined, 1),
              _buildNavItem(Icons.history, 2),
              _buildNavItem(Icons.person_outline, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return IconButton(
      icon: Icon(
        icon,
        color: _selectedIndex == index ? Colors.orange : Colors.white,
      ),
      onPressed: () => _onItemTapped(index),
    );
  }
}