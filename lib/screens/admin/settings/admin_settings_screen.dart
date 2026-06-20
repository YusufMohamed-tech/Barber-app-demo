import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/services/local_auth_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../widgets/app_header.dart';
import '../../../widgets/app_screen.dart';
import '../../../widgets/gold_button.dart';
import '../../auth/role_selection_screen.dart';
import '../clients/admin_clients_screen.dart';

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    await const LocalAuthService().logout();
    if (!context.mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      scrollable: true,
      bottomPadding: 112,
      child: Column(
        children: [
          const AppHeader(title: 'الإعدادات'),
          const SizedBox(height: AppSpacing.lg),
          const _LogoCard(),
          const SizedBox(height: AppSpacing.lg),
          const _SalonInfoCard(),
          const SizedBox(height: AppSpacing.lg),
          _SettingsList(
            onClientsTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const AdminClientsScreen()),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          GoldButton(
            text: 'تسجيل الخروج',
            onPressed: () => _logout(context),
            variant: GoldButtonVariant.danger,
            icon: Icons.logout_rounded,
          ),
        ],
      ),
    );
  }
}

class _LogoCard extends StatelessWidget {
  const _LogoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.borderGold),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              AppAssets.appLogo,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('صالون الحلاقة', style: AppTextStyles.sectionTitle),
                const SizedBox(height: 4),
                Text('إعدادات النظام', style: AppTextStyles.body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SalonInfoCard extends StatelessWidget {
  const _SalonInfoCard();

  @override
  Widget build(BuildContext context) {
    const rows = [
      ('اسم الصالون', 'صالون الحلاقة'),
      ('رقم الهاتف', '010 0000 0000'),
      ('العنوان', 'مدينة نصر، القاهرة'),
      ('مواعيد العمل', '10 صباحاً - 10 مساءً'),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: rows
            .map(
              (row) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Text(
                      row.$1,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const Spacer(),
                    Flexible(
                      child: Text(
                        row.$2,
                        textAlign: TextAlign.left,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _SettingsList extends StatelessWidget {
  const _SettingsList({required this.onClientsTap});

  final VoidCallback onClientsTap;

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.storefront_rounded, 'معلومات الصالون', null),
      (Icons.people_alt_rounded, 'إدارة المستخدمين', onClientsTap),
      (Icons.local_offer_rounded, 'التصنيفات والعروض', null),
      (Icons.payments_rounded, 'طرق الدفع', null),
      (Icons.notifications_rounded, 'الإشعارات', null),
      (Icons.backup_rounded, 'النسخ الاحتياطي', null),
      (Icons.tune_rounded, 'الإعدادات العامة', null),
      (Icons.language_rounded, 'اللغة', null),
      (Icons.info_outline_rounded, 'عن التطبيق', null),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];
          return InkWell(
            onTap: item.$3,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                  child: Row(
                    children: [
                      Icon(item.$1, color: AppColors.primaryGold, size: 21),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          item.$2,
                          textAlign: TextAlign.right,
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.mutedText,
                        size: 15,
                      ),
                    ],
                  ),
                ),
                if (index != items.length - 1)
                  const Divider(
                    height: 1,
                    color: AppColors.divider,
                    indent: 14,
                    endIndent: 14,
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
