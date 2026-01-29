import 'package:aplikasi_absensi/widgets/custom_navbar.dart' show CustomNavbar;
import 'package:flutter/material.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Profil Pengguna",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            Center(
              child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200], 
                  border: Border.all(color: const Color(0xFF135D66), width: 2),
                ),
                child: const Icon(
                  Icons.person,
                  size: 80,
                  color: Color(0xFF135D66),
                ),
              ),
            ),
            
            const SizedBox(height: 40),

            _buildReadOnlyField("NIK", "32898366529008"),
            _buildReadOnlyField("Nama", "Annisa Aulia Firdaus"),
            _buildReadOnlyField(
              "Alamat", 
              "Gg. Bidan Tati Jambudipa Rt04/Rw03 Warungkondang, Cianjur, 43261",
              maxLines: 3,
            ),
            _buildReadOnlyField("No. Telp", "08123455678"),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavbar(currentIndex: 3, showFabSpace: false),
    );
  }

  Widget _buildReadOnlyField(String label, String value, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            readOnly: true,
            maxLines: maxLines,
            controller: TextEditingController(text: value),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF1B263B), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF135D66), width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}