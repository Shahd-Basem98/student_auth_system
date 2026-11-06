// نموذج بيانات الطالب بعد تسجيل الدخول بنجاح
class UserModel {
  final String academicId;
  final String fullName;
  final String email;

  UserModel({
    required this.academicId,
    required this.fullName,
    required this.email,
  });
}

// نموذج بيانات طلب تسجيل الدخول
class LoginRequest {
  final String identifier;
  final String password;
  final bool rememberMe;

  LoginRequest({
    required this.identifier,
    required this.password,
    required this.rememberMe,
  });
}

// نموذج بيانات طلب إنشاء الحساب
class RegisterRequest {
  final String fullName;
  final String academicId;
  final String email;
  final String password;
  final bool acceptedTerms;

  RegisterRequest({
    required this.fullName,
    required this.academicId,
    required this.email,
    required this.password,
    required this.acceptedTerms,
  });
}