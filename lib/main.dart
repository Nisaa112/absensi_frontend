import 'package:aplikasi_absensi/page/auth_wrapper.dart';
import 'package:aplikasi_absensi/viewmodel/academic_viewmodel.dart';
import 'package:aplikasi_absensi/viewmodel/attendance_viewmodel.dart';
import 'package:aplikasi_absensi/viewmodel/permission_viewmodel.dart';
import 'package:aplikasi_absensi/viewmodel/report_viewmodel.dart';
import 'package:aplikasi_absensi/viewmodel/schedule_viewmodel.dart';
import 'package:aplikasi_absensi/viewmodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aplikasi_absensi/viewmodel/auth_viewmodel.dart';
import 'package:aplikasi_absensi/page/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => PermissionViewModel()),
        ChangeNotifierProvider(create: (_) => AttendanceViewModel()),
        ChangeNotifierProvider(create: (_) => AcademicViewModel()),
        ChangeNotifierProvider(create: (_) => ScheduleViewModel()),
        ChangeNotifierProvider(create: (_) => ReportViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Attendia: Absensi Siswa',
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthWrapper(),
          '/login': (context) => const LoginPage(),
        },
      ),
    );
  }
}