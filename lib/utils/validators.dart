class FormValidators {
  // التحقق من المعرف الأكاديمي أو البريد
  static String? validateLoginIdentifier(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال المعرف الأكاديمي أو البريد';
    }
    if (value.trim().length < 5) {
      return 'المعرف يجب ألا يقل عن 5 خانات';
    }
    return null;
  }

  // التحقق من الاسم الكامل
  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال الاسم الكامل';
    }
    if (value.trim().length < 3) {
      return 'الاسم يجب ألا يقل عن 3 محارف';
    }
    return null;
  }

  // التحقق من الرقم الأكاديمي (أرقام فقط، 9-10 خانات)
  static String? validateAcademicId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال الرقم الأكاديمي';
    }
    final regex = RegExp(r'^[0-9]{9,10}$');
    if (!regex.hasMatch(value.trim())) {
      return 'الرقم الأكاديمي يتكون من 9 إلى 10 أرقام فقط';
    }
    return null;
  }

  // التحقق من البريد الجامعي عبر Regex قياسي
  static String? validateUniversityEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال البريد الإلكتروني';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'صيغة البريد الإلكتروني غير صحيحة';
    }
    return null;
  }

  // التحقق من سياسة أمان كلمة المرور (>= 8 محارف، رقم، حرف كبير)
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال كلمة المرور';
    }
    if (value.length < 8) {
      return 'كلمة المرور يجب ألا تقل عن 8 محارف';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'يجب أن تحتوي على حرف كبير واحد على الأقل (A-Z)';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'يجب أن تحتوي على رقم واحد على الأقل';
    }
    return null;
  }

  // التحقق من تطابق كلمتي المرور
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'يرجى تأكيد كلمة المرور';
    }
    if (value != password) {
      return 'كلمتا المرور غير متطابقتين';
    }
    return null;
  }

  // التحقق من رمز OTP (6 أرقام حصراً)
  static String? validateOtp(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال رمز التحقق';
    }
    final regex = RegExp(r'^[0-9]{6}$');
    if (!regex.hasMatch(value.trim())) {
      return 'رمز التحقق يجب أن يتكون من 6 أرقام';
    }
    return null;
  }
}