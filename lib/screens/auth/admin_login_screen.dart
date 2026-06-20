import 'package:flutter/material.dart';

import '../../core/services/local_auth_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/app_header.dart';
import '../../widgets/gold_button.dart';
import '../admin/main/admin_main_shell.dart';
import 'auth_widgets.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = const LocalAuthService();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() => _error = null);
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final valid = await _authService.loginAdmin(
      username: _usernameController.text,
      password: _passwordController.text,
    );
    if (!mounted) return;
    setState(() => _loading = false);

    if (!valid) {
      setState(() => _error = 'بيانات الدخول غير صحيحة');
      return;
    }

    showArabicSnackBar(context, 'تم تسجيل الدخول بنجاح');
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const AdminMainShell()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      showLogo: false,
      child: Column(
        children: [
          const AppHeader(title: 'دخول الأدمن', showBack: true),
          const SizedBox(height: AppSpacing.xl),
          Container(
            width: 112,
            height: 112,
            decoration: BoxDecoration(
              color: AppColors.primaryGold.withValues(alpha: 0.12),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.borderGold),
            ),
            child: const Icon(
              Icons.admin_panel_settings_rounded,
              color: AppColors.primaryGold,
              size: 58,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          AuthCard(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text('لوحة تحكم الصالون', style: AppTextStyles.sectionTitle),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'بيانات الدخول التجريبية: admin / 1234',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primaryGold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AuthTextField(
                    controller: _usernameController,
                    label: 'اسم المستخدم',
                    icon: Icons.person_rounded,
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                        ? 'اسم المستخدم مطلوب'
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
                  if (_error != null) ...[
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      _error!,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.caption.copyWith(
                        color: const Color(0xFFFF8A80),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.xl),
                  GoldButton(
                    text: 'دخول لوحة التحكم',
                    onPressed: _login,
                    isLoading: _loading,
                    icon: Icons.dashboard_rounded,
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
