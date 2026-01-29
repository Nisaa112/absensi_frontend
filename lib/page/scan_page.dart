import 'package:aplikasi_absensi/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // bottomNavigationBar: const CustomNavbar(currentIndex: -1, showFabSpace: false),
      appBar: AppBar(
        title: const Text("Scan", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Stack(
        children: [
          MobileScanner(
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                debugPrint('Barcode found! ${barcode.rawValue}');
              }
            },
          ),
          
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 4),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),

        //   Align(
        //     alignment: Alignment.bottomCenter,
        //     child: Container(
        //       height: 70,
        //       margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        //       decoration: BoxDecoration(
        //         color: const Color(0xFF0D1B2A),
        //         borderRadius: BorderRadius.circular(30),
        //       ),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceAround,
        //         children: [
        //           IconButton(
        //             icon: const Icon(Icons.home, color: Colors.orange),
        //             onPressed: () => Navigator.pop(context),
        //           ),
        //           const Icon(Icons.assignment_ind, color: Colors.white),
        //           const Icon(Icons.history, color: Colors.white),
        //         ],
        //       ),
        //     ),
        //   )
        ],
      ),
    );
  }
}