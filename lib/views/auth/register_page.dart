import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../models/auth_models.dart';
import '../../utils/validators.dart';

class RegisterPage extends StatefulWidget {
  final AuthController controller;
  const RegisterPage({super.key, required this.controller});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _acceptedTerms = false;
  bool _termsError = false;

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() async {
    setState(() => _termsError = !_acceptedTerms);
    if (_formKey.currentState!.validate() && _acceptedTerms) {
      final req = RegisterRequest(
        fullName: _nameController.text.trim(),
        academicId: _idController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        acceptedTerms: _acceptedTerms,
      );
      final success = await widget.controller.register(req);
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم إنشاء الحساب بنجاح! سجل دخولك الآن'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إنشاء حساب جديد'),
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
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'الاسم الكامل',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: FormValidators.validateFullName,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _idController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'الرقم الأكاديمي (9-10 أرقام)',
                    prefixIcon: Icon(Icons.badge_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: FormValidators.validateAcademicId,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'البريد الجامعي',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: FormValidators.validateUniversityEmail,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'كلمة المرور (≥ 8 محارف، حرف كبير، رقم)',
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
                    labelText: 'تأكيد كلمة المرور',
                    prefixIcon: Icon(Icons.lock_reset),
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => FormValidators.validateConfirmPassword(v, _passwordController.text),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Checkbox(
                      value: _acceptedTerms,
                      onChanged: (val) => setState(() {
                        _acceptedTerms = val ?? false;
                        _termsError = !_acceptedTerms;
                      }),
                    ),
                    const Expanded(
                      child: Text('أوافق على اللوائح والشروط الأكاديمية'),
                    ),
                  ],
                ),
                if (_termsError)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'يجب الموافقة على الشروط أولاً للمتابعة',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 20),
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
                      child: const Text('تسجيل الحساب', style: TextStyle(fontSize: 16)),
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