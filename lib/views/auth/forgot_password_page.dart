import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/validators.dart';
import 'reset_password_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  final AuthController controller;
  const ForgotPasswordPage({super.key, required this.controller});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();

  @override
  void dispose() {
    _identifierController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final success = await widget.controller.sendPasswordResetCode(
        _identifierController.text.trim(),
      );
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم إرسال رمز التحقق بنجاح إلى وسيلة التواصل الخاصة بك'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ResetPasswordPage(controller: widget.controller),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('استعادة كلمة المرور'),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Card(
                  color: Color(0xFFF0F4FF),
                  elevation: 0,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.indigo),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'أدخل رقمك الأكاديمي أو بريدك المسجل لإرسال رمز تأكيد مكوّن من 6 أرقام لتحديث كلمة المرور.',
                            style: TextStyle(fontSize: 13, height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _identifierController,
                  decoration: const InputDecoration(
                    labelText: 'البريد الإلكتروني أو الرقم الأكاديمي',
                    prefixIcon: Icon(Icons.alternate_email),
                    border: OutlineInputBorder(),
                  ),
                  validator: FormValidators.validateLoginIdentifier,
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
                      child: const Text('إرسال رمز التحقق', style: TextStyle(fontSize: 16)),
                    );
                  },
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('العودة لتسجيل الدخول'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}