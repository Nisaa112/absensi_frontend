import 'package:aplikasi_absensi/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';

class PerizinanPage extends StatelessWidget {
  const PerizinanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomNavbar(currentIndex: 1, showFabSpace: false),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Perizinan",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            
            const Text("Bukti Gambar", style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(Icons.camera_alt, size: 60, color: Colors.grey[600]),
            ),
            
            const SizedBox(height: 20),

            _buildInputField("Nama Siswa"),
            _buildInputField("Tanggal Izin"),
            _buildInputField("Jenis Izin"),
            _buildInputField("Alasan"),
            _buildInputField("Wali Kelas"),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF135D66),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Kirim",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      
      // bottomNavigationBar: Container(
      //   height: 70,
      //   decoration: const BoxDecoration(
      //     color: Color(0xFF0D1B2A),
      //     borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(25),
      //       topRight: Radius.circular(25),
      //     ),
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //       IconButton(
      //         icon: const Icon(Icons.home, color: Colors.orange),
      //         onPressed: () => Navigator.pop(context), 
      //       ),
      //       IconButton(
      //         icon: const Icon(Icons.assignment_ind, color: Colors.white),
      //         onPressed: () {},
      //       ),
      //       IconButton(
      //         icon: const Icon(Icons.history, color: Colors.white),
      //         onPressed: () {},
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Widget _buildInputField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}