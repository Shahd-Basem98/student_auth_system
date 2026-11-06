import 'package:flutter/material.dart';
import 'controllers/auth_controller.dart';
import 'repositories/auth_repository.dart';
import 'views/auth/login_page.dart';

void main() {
  runApp(const UniversityAuthApp());
}

class UniversityAuthApp extends StatefulWidget {
  const UniversityAuthApp({super.key});

  @override
  State<UniversityAuthApp> createState() => _UniversityAuthAppState();
}

class _UniversityAuthAppState extends State<UniversityAuthApp> {
  late final AuthController _authController;

  @override
  void initState() {
    super.initState();
    // حقن المستودع داخل المتحكم (Dependency Injection) بدون أي حزم خارجية
    _authController = AuthController(repository: AuthRepositoryImpl());
  }

  @override
  void dispose() {
    _authController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'نظام المصادقة الأكاديمي',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF702DFF)),
        useMaterial3: true,
      ),
      home: LoginPage(controller: _authController),
    );
  }
}