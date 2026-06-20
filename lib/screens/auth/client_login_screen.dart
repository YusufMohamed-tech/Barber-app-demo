import 'package:flutter/material.dart';

import '../../core/services/local_auth_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/app_header.dart';
import '../../widgets/gold_button.dart';
import '../main/main_shell.dart';
import 'auth_widgets.dart';
import 'client_register_screen.dart';
import 'forgot_password_screen.dart';

class ClientLoginScreen extends StatefulWidget {
  const ClientLoginScreen({super.key});

  @override
  State<ClientLoginScreen> createState() => _ClientLoginScreenState();
}

class _ClientLoginScreenState extends State<ClientLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = const LocalAuthService();
  bool _loading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await _authService.loginClient(
      name: 'أحمد العتيبي',
      phone: _phoneController.text.trim(),
    );
    if (!mounted) return;
    setState(() => _loading = false);
    showArabicSnackBar(context, 'تم تسجيل الدخول بنجاح');
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
          const AppHeader(title: 'تسجيل دخول العميل', showBack: true),
          const SizedBox(height: AppSpacing.xl),
          const AuthLogo(size: 112),
          const SizedBox(height: AppSpacing.xxl),
          AuthCard(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text('مرحباً بك', style: AppTextStyles.sectionTitle),
                  const SizedBox(height: AppSpacing.sm),
                  Text('سجل دخولك لمتابعة حجوزاتك', style: AppTextStyles.body),
                  const SizedBox(height: AppSpacing.xl),
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ForgotPasswordScreen(),
                        ),
                      ),
                      child: Text(
                        'نسيت كلمة المرور؟',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primaryGold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  GoldButton(
                    text: 'تسجيل الدخول',
                    onPressed: _login,
                    isLoading: _loading,
                    icon: Icons.login_rounded,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextButton(
                    onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const ClientRegisterScreen(),
                      ),
                    ),
                    child: Text(
                      'إنشاء حساب جديد',
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
