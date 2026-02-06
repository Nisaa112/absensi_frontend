import 'package:aplikasi_absensi/page/home_page.dart';
import 'package:aplikasi_absensi/page/perizinan_page.dart';
import 'package:aplikasi_absensi/page/history_page.dart';
import 'package:aplikasi_absensi/page/profile_page.dart';
import 'package:aplikasi_absensi/page/scan_page.dart';
import 'package:flutter/material.dart';

class SiswaMainScreen extends StatefulWidget {
  const SiswaMainScreen({super.key});

  @override
  State<SiswaMainScreen> createState() => _SiswaMainScreenState();
}

class _SiswaMainScreenState extends State<SiswaMainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),      // Index 0
    const PerizinanPage(), // Index 1
    const HistoryPage(),   // Index 2
    const ProfilePage(),   // Index 3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScanPage()),
          );
        },
        backgroundColor: const Color(0xFF0D1B2A),
        shape: const CircleBorder(),
        child: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 30),
      ),

      bottomNavigationBar: _buildNavbar(),
    );
  }

  Widget _buildNavbar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), 
            blurRadius: 10, 
            offset: const Offset(0, -2)
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
          color: const Color(0xFF0D1B2A),
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavItem(Icons.home, 0),
              _buildNavItem(Icons.assignment_ind_outlined, 1),
              
              const SizedBox(width: 40), 
              
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
      onPressed: () => setState(() => _selectedIndex = index),
    );
  }
}