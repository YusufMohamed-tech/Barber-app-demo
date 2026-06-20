import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/gold_button.dart';
import 'admin_login_screen.dart';
import 'auth_widgets.dart';
import 'client_login_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Column(
        children: [
          Text(
            'اختر نوع الدخول',
            textAlign: TextAlign.center,
            style: AppTextStyles.largeTitle.copyWith(fontSize: 28),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'ادخل كتجربة عميل أو افتح لوحة إدارة الصالون',
            textAlign: TextAlign.center,
            style: AppTextStyles.body,
          ),
          const SizedBox(height: AppSpacing.xxl),
          _RoleCard(
            icon: Icons.person_rounded,
            title: 'دخول العميل',
            subtitle: 'احجز موعدك وتابع حجوزاتك بسهولة',
            buttonText: 'متابعة كعميل',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ClientLoginScreen()),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _RoleCard(
            icon: Icons.admin_panel_settings_rounded,
            title: 'دخول الأدمن',
            subtitle: 'إدارة الحلاقين، الخدمات، الحجوزات والتقارير',
            buttonText: 'متابعة كأدمن',
            onTap: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const AdminLoginScreen())),
          ),
          const SizedBox(height: AppSpacing.xxxl),
          Text(
            'صالون الحلاقة - تجربة فاخرة لإدارة الحجوزات',
            textAlign: TextAlign.center,
            style: AppTextStyles.caption.copyWith(color: AppColors.mutedText),
          ),
        ],
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AuthCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: AppColors.primaryGold.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.borderGold),
                ),
                child: Icon(icon, color: AppColors.primaryGold, size: 30),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.right,
                      style: AppTextStyles.sectionTitle,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      textAlign: TextAlign.right,
                      style: AppTextStyles.body,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          GoldButton(
            text: buttonText,
            onPressed: onTap,
            icon: Icons.arrow_back_rounded,
          ),
        ],
      ),
    );
  }
}
