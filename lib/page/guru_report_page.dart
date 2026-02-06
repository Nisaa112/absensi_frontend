import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aplikasi_absensi/viewmodel/report_viewmodel.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReportViewModel>().loadDropdownData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final reportVM = context.watch<ReportViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "Laporan Kehadiran",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: reportVM.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Center(child: Text("Overview", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
                  const SizedBox(height: 15),
                  
                  // Grafik Dummy Sederhana (CustomPainter)
                  SizedBox(
                    width: double.infinity,
                    height: 150,
                    child: CustomPaint(painter: SimpleLineChartPainter()),
                  ),
                  
                  const SizedBox(height: 30),
                  const Center(child: Text("Export Data", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
                  const SizedBox(height: 20),

                  // Box Container (Style Perizinan Page)
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        _buildLabel("Tahun Ajaran"),
                        _buildDropdown<int>(
                          hint: "Pilih Tahun",
                          value: reportVM.selectedTahunId,
                          items: reportVM.tahunAktif != null 
                            ? [DropdownMenuItem(value: reportVM.tahunAktif!.id, child: Text(reportVM.tahunAktif!.tahun ?? ""))]
                            : [],
                          onChanged: (val) => setState(() => reportVM.selectedTahunId = val),
                        ),

                        _buildLabel("Kelas"),
                        _buildDropdown<int>(
                          hint: "Pilih Kelas",
                          value: reportVM.selectedKelasId,
                          items: reportVM.listKelas.map((k) {
                            return DropdownMenuItem(value: k.id, child: Text(k.namaKelas ?? ""));
                          }).toList(),
                          onChanged: (val) => setState(() => reportVM.selectedKelasId = val),
                        ),

                        _buildLabel("Mata Pelajaran (Opsional)"),
                        _buildDropdown<int>(
                          hint: "Semua Mapel",
                          value: reportVM.selectedMapelId,
                          items: reportVM.listMapel.map((m) {
                            return DropdownMenuItem(value: m.id, child: Text(m.namaMapel ?? ""));
                          }).toList(),
                          onChanged: (val) => setState(() => reportVM.selectedMapelId = val),
                        ),

                        const SizedBox(height: 20),

                        // Tombol Orange Sesuai Gambar
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () => reportVM.processDownload(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                            child: const Text(
                              "Export Data",
                              style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
    );
  }

  Widget _buildLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, bottom: 8),
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _buildDropdown<T>({
    required String hint,
    required T? value,
    required List<DropdownMenuItem<T>> items,
    required Function(T?) onChanged,
  }) {
    return Column(
      children: [
        DropdownButtonFormField<T>(
          value: value,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          ),
          hint: Text(hint),
          items: items,
          onChanged: onChanged,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

class SimpleLineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.8);
    path.lineTo(size.width * 0.2, size.height * 0.6);
    path.lineTo(size.width * 0.4, size.height * 0.65);
    path.lineTo(size.width * 0.6, size.height * 0.3);
    path.lineTo(size.width * 0.8, size.height * 0.2);
    path.lineTo(size.width * 0.9, size.height * 0.7);
    path.lineTo(size.width, size.height * 0.6);

    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}