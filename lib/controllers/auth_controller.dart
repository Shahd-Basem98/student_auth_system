import 'package:flutter/material.dart';
import '../models/auth_models.dart';
import '../repositories/auth_repository.dart';

class AuthController extends ChangeNotifier {
  final AuthRepository _repository;

  AuthController({required AuthRepository repository}) : _repository = repository;

  bool _isLoading = false;
  String? _errorMessage;
  UserModel? _currentUser;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  UserModel? get currentUser => _currentUser;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // تسجيل الدخول
  Future<bool> login(LoginRequest request) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      _currentUser = await _repository.login(request);
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = 'فشل تسجيل الدخول، يرجى المحاولة لاحقاً';
      _setLoading(false);
      return false;
    }
  }

  // إنشاء حساب جديد
  Future<bool> register(RegisterRequest request) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      await _repository.register(request);
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = 'فشل إنشاء الحساب';
      _setLoading(false);
      return false;
    }
  }

  // إرسال كود استعادة كلمة المرور
  Future<bool> sendPasswordResetCode(String identifier) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      await _repository.sendPasswordResetCode(identifier);
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = 'فشل إرسال رمز التحقق';
      _setLoading(false);
      return false;
    }
  }

  // تعيين كلمة المرور الجديدة عبر OTP
  Future<bool> resetPassword(String otp, String newPassword) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      await _repository.resetPassword(otp: otp, newPassword: newPassword);
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = 'فشل تحديث كلمة المرور';
      _setLoading(false);
      return false;
    }
  }
}