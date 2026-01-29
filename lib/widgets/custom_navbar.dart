import 'package:aplikasi_absensi/page/history_page.dart';
import 'package:aplikasi_absensi/page/home_page.dart';
import 'package:aplikasi_absensi/page/perizinan_page.dart';
import 'package:aplikasi_absensi/page/profile_page.dart';
import 'package:flutter/material.dart';

class CustomNavbar extends StatelessWidget {
  final int currentIndex;
  final bool showFabSpace;

  const CustomNavbar({
    super.key,
    required this.currentIndex,
    this.showFabSpace = true,
  });

  @override
  Widget build(BuildContext context) {
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
          color: const Color(0xFF0D1B2A),
          shape: showFabSpace ? const CircularNotchedRectangle() : null,
          notchMargin: 8,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavItem(context, Icons.home, 0, const HomePage()),
              _buildNavItem(context, Icons.assignment_ind_outlined, 1, const PerizinanPage()),
              
              if (showFabSpace) const SizedBox(width: 40),
              
              _buildNavItem(context, Icons.history, 2, const HistoryPage()),
              _buildNavItem(context, Icons.person_outline, 3, const ProfilePage()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, int index, Widget? destination) {
    return IconButton(
      icon: Icon(
        icon,
        color: currentIndex == index ? Colors.orange : Colors.white,
      ),
      onPressed: () {
        if (currentIndex != index && destination != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        }
      },
    );
  }
}