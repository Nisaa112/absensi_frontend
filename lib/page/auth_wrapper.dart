import 'package:aplikasi_absensi/page/home_page.dart';
import 'package:aplikasi_absensi/page/login_page.dart';
import 'package:aplikasi_absensi/viewmodel/auth_viewmodel.dart';
import 'package:aplikasi_absensi/widgets/guru_main_screen.dart';
import 'package:aplikasi_absensi/widgets/siswa_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authVM = context.watch<AuthViewModel>();

    if (authVM.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (!authVM.isLoggedIn) {
      return const LoginPage();
    }

    final String role = authVM.userRole?.toLowerCase() ?? '';

    if (role == 'guru') {
      return const GuruMainScreen(); 
    } else if (role == 'siswa') {
      return const Scaffold(
        body: HomePage(),
        bottomNavigationBar: SiswaMainScreen(),
      );
    } else {
      return const Scaffold(
        body: Center(child: Text("Menyiapkan akun...")),
      );
    }
  }
}