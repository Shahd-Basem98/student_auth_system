import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/validators.dart';

class ResetPasswordPage extends StatefulWidget {
  final AuthController controller;
  const ResetPasswordPage({super.key, required this.controller});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final success = await widget.controller.resetPassword(
        _otpController.text.trim(),
        _passwordController.text,
      );
      if (success && mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (dialogCtx) => AlertDialog(
            title: const Text('تم بنجاح'),
            content: const Text('تم تحديث كلمة المرور الخاصة بك بنجاح. يمكنك الآن تسجيل الدخول.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogCtx);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text('التوجه لتسجيل الدخول'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعيين كلمة المرور الجديدة'),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: const InputDecoration(
                    labelText: 'رمز التحقق (OTP)',
                    hintText: 'أدخل 6 أرقام',
                    prefixIcon: Icon(Icons.pin),
                    border: OutlineInputBorder(),
                  ),
                  validator: FormValidators.validateOtp,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'كلمة المرور الجديدة',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: FormValidators.validatePassword,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'تأكيد كلمة المرور الجديدة',
                    prefixIcon: Icon(Icons.lock_reset),
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => FormValidators.validateConfirmPassword(v, _passwordController.text),
                ),
                const SizedBox(height: 24),
                ListenableBuilder(
                  listenable: widget.controller,
                  builder: (context, _) {
                    return widget.controller.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('تحديث كلمة المرور', style: TextStyle(fontSize: 16)),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}