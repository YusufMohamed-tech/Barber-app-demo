import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/app_header.dart';
import '../../widgets/gold_button.dart';
import 'auth_widgets.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();
    return AuthScaffold(
      showLogo: false,
      child: Column(
        children: [
          const AppHeader(title: 'استعادة كلمة المرور', showBack: true),
          const SizedBox(height: AppSpacing.xxl),
          AuthCard(
            child: Column(
              children: [
                Text('نسيت كلمة المرور؟', style: AppTextStyles.sectionTitle),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'أدخل رقم هاتفك وسنجهز شاشة استعادة تجريبية.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body,
                ),
                const SizedBox(height: AppSpacing.xl),
                AuthTextField(
                  controller: phoneController,
                  label: 'رقم الهاتف',
                  icon: Icons.phone_rounded,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: AppSpacing.xl),
                GoldButton(
                  text: 'متابعة',
                  onPressed: () => showArabicSnackBar(
                    context,
                    'تم إرسال طلب الاستعادة تجريبياً',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
