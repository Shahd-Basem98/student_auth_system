import '../models/auth_models.dart';

// العقد التجريدي للعمليات المطلوبة
abstract class AuthRepository {
  Future<UserModel> login(LoginRequest request);
  Future<void> register(RegisterRequest request);
  Future<void> sendPasswordResetCode(String identifier);
  Future<void> resetPassword({
    required String otp,
    required String newPassword,
  });
}

// التطبيق الفعلي مع محاكاة الاتصال بالشبكة (Future.delayed)
class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<UserModel> login(LoginRequest request) async {
    await Future.delayed(const Duration(seconds: 2));
    return UserModel(
      academicId: '2024110097',
      fullName: 'شهد باسم الميتمي',
      email: request.identifier.contains('@') ? request.identifier : 'student@univ.edu.ye',
    );
  }

  @override
  Future<void> register(RegisterRequest request) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future<void> sendPasswordResetCode(String identifier) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> resetPassword({required String otp, required String newPassword}) async {
    await Future.delayed(const Duration(seconds: 2));
  }
}