import 'package:aplikasi_absensi/page/guru_home_page.dart';
import 'package:aplikasi_absensi/page/home_page.dart';
import 'package:aplikasi_absensi/viewmodel/auth_viewmodel.dart'; // Pastikan import ini ada
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 1. Tambahkan Controller & State Loading
  final TextEditingController _serialController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordObscured = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _serialController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // 2. Logika Login Sesuai Role
  Future<void> _handleLogin() async {
    if (_serialController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nomor Serial dan Password tidak boleh kosong.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    final bool success = await authViewModel.login(
      _serialController.text.trim(), 
      _passwordController.text.trim(),
    );
    
    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (success) {
      // Ambil role dari ViewModel, paksa ke lowercase untuk keamanan pengecekan
      final String userRole = (authViewModel.userRole ?? 'siswa').toLowerCase(); 

      Widget targetPage;

      if (userRole == 'guru') {
        targetPage = const GuruHomePage(); 
      } else {
        targetPage = const HomePage(); // Default untuk siswa
      }

      // Navigasi: Hapus history login agar tidak bisa di-back
      Navigator.pushAndRemoveUntil(
        context, 
        MaterialPageRoute(builder: (context) => targetPage),
        (route) => false
      );
      
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authViewModel.errorMessage ?? 'Terjadi kesalahan.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Center(
                child: Image.asset(
                  'assets/gambar1.png',
                  height: 250,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 100),
                ),
              ),
              const SizedBox(height: 30),

              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D1B2A),
                ),
              ),
              const Text(
                "Please Sign In to continue",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),

              const Text(
                "Serial Number",
                style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF1B263B)),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _serialController, // Tambahkan controller
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter your serial number",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFF135D66), width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF1B263B)),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController, // Tambahkan controller
                obscureText: _isPasswordObscured, 
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () => setState(() => _isPasswordObscured = !_isPasswordObscured),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFF135D66), width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleLogin, // Pasang fungsi login
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF135D66),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: _isLoading 
                    ? const SizedBox(
                        height: 24, 
                        width: 24, 
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                      )
                    : const Text(
                        "Login",
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}