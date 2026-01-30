import 'package:aplikasi_absensi/page/guru_home_page.dart';
import 'package:aplikasi_absensi/page/home_page.dart';
import 'package:aplikasi_absensi/page/login_page.dart'; 
import 'package:aplikasi_absensi/viewmodel/auth_viewmodel.dart';
import 'package:aplikasi_absensi/widgets/custom_navbar.dart';
import 'package:aplikasi_absensi/widgets/guru_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    if (authViewModel.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // if (!authViewModel.isLoggedIn) {
    //   return const WelcomePage();
    // }

    final userRole = authViewModel.userRole?.toLowerCase() ?? '';

    switch (userRole) {
      // case 'admin': 
      //   return const AdminNavbarScreen(); 
        
      case 'guru': 
        return const GuruHomePage(); 

      case 'siswa': 
        return const HomePage(); 

      default:
        return const LoginPage();
    }
  }
}