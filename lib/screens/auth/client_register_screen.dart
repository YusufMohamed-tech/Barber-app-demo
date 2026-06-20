import 'package:flutter/material.dart';

import '../../core/services/local_auth_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/app_header.dart';
import '../../widgets/gold_button.dart';
import '../main/main_shell.dart';
import 'auth_widgets.dart';
import 'client_login_screen.dart';

class ClientRegisterScreen extends StatefulWidget {
  const ClientRegisterScreen({super.key});

  @override
  State<ClientRegisterScreen> createState() => _ClientRegisterScreenState();
}

class _ClientRegisterScreenState extends State<ClientRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _authService = const LocalAuthService();
  bool _loading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await _authService.registerClient(
      name: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      password: _passwordController.text,
    );
    if (!mounted) return;
    setState(() => _loading = false);
    showArabicSnackBar(context, 'تم إنشاء الحساب بنجاح');
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MainShell()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      showLogo: false,
      child: Column(
        children: [
          const AppHeader(title: 'إنشاء حساب عميل', showBack: true),
          const SizedBox(height: AppSpacing.xl),
          const AuthLogo(size: 104),
          const SizedBox(height: AppSpacing.xxl),
          AuthCard(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AuthTextField(
                    controller: _nameController,
                    label: 'الاسم الكامل',
                    icon: Icons.person_rounded,
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                        ? 'الاسم مطلوب'
                        : null,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AuthTextField(
                    controller: _phoneController,
                    label: 'رقم الهاتف',
                    icon: Icons.phone_rounded,
                    keyboardType: TextInputType.phone,
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                        ? 'رقم الهاتف مطلوب'
                        : null,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AuthTextField(
                    controller: _passwordController,
                    label: 'كلمة المرور',
                    icon: Icons.lock_rounded,
                    isPassword: true,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'كلمة المرور مطلوبة'
                        : null,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AuthTextField(
                    controller: _confirmController,
                    label: 'تأكيد كلمة المرور',
                    icon: Icons.lock_reset_rounded,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'تأكيد كلمة المرور مطلوب';
                      }
                      if (value != _passwordController.text) {
                        return 'كلمتا المرور غير متطابقتين';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  GoldButton(
                    text: 'إنشاء حساب',
                    onPressed: _register,
                    isLoading: _loading,
                    icon: Icons.person_add_alt_1_rounded,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextButton(
                    onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const ClientLoginScreen(),
                      ),
                    ),
                    child: Text(
                      'لديك حساب بالفعل؟ تسجيل الدخول',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.primaryGold,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
