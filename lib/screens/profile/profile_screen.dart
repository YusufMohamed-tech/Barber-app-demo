import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';
import '../../core/services/local_auth_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/app_header.dart';
import '../../widgets/app_screen.dart';
import '../../widgets/barber_card.dart';
import '../../widgets/gold_button.dart';
import '../auth/role_selection_screen.dart';
import '../notifications/notifications_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
          const AppHeader(title: 'الملف الشخصي'),
          const SizedBox(height: AppSpacing.lg),
          const _ProfileCard(),
          const SizedBox(height: AppSpacing.lg),
          const _StatsRow(),
          const SizedBox(height: AppSpacing.xl),
          _MenuList(
            onNotificationsTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const NotificationsScreen()),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          GoldButton(
            text: 'تسجيل الخروج',
            onPressed: () => _logout(context),
            variant: GoldButtonVariant.danger,
          ),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

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
          const BarberAvatar(imageUrl: AppAssets.profileAvatar, radius: 38),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'أحمد العتيبي',
                  textAlign: TextAlign.right,
                  style: AppTextStyles.sectionTitle,
                ),
                const SizedBox(height: 4),
                Text(
                  '+20 100 123 4567',
                  textAlign: TextAlign.right,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryGold.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: AppColors.borderGold),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.workspace_premium_rounded,
                        color: AppColors.primaryGold,
                        size: 15,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'عضو ذهبي',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primaryGold,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
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

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    const stats = [('الحجوزات', '12'), ('النقاط', '240'), ('التقييمات', '5')];

    return Row(
      children: stats
          .map(
            (stat) => Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Column(
                  children: [
                    Text(
                      stat.$2,
                      style: AppTextStyles.sectionTitle.copyWith(
                        color: AppColors.primaryGold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(stat.$1, style: AppTextStyles.caption),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _MenuList extends StatelessWidget {
  const _MenuList({required this.onNotificationsTap});

  final VoidCallback onNotificationsTap;

  @override
  Widget build(BuildContext context) {
    final items = [
      _MenuItemData(Icons.person_outline_rounded, 'بياناتي الشخصية'),
      _MenuItemData(
        Icons.notifications_none_rounded,
        'الإشعارات',
        onTap: onNotificationsTap,
      ),
      _MenuItemData(Icons.credit_card_rounded, 'وسائل الدفع'),
      _MenuItemData(Icons.location_on_outlined, 'العناوين'),
      _MenuItemData(Icons.favorite_border_rounded, 'المفضلة'),
      _MenuItemData(Icons.language_rounded, 'اللغة', value: 'العربية'),
      _MenuItemData(Icons.support_agent_rounded, 'الدعم والمساعدة'),
      _MenuItemData(Icons.privacy_tip_outlined, 'سياسة الخصوصية'),
      _MenuItemData(Icons.info_outline_rounded, 'عن التطبيق'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          return _ProfileMenuItem(
            item: items[index],
            showDivider: index != items.length - 1,
          );
        }),
      ),
    );
  }
}

class _MenuItemData {
  const _MenuItemData(this.icon, this.label, {this.value, this.onTap});

  final IconData icon;
  final String label;
  final String? value;
  final VoidCallback? onTap;
}

class _ProfileMenuItem extends StatelessWidget {
  const _ProfileMenuItem({required this.item, required this.showDivider});

  final _MenuItemData item;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              children: [
                Icon(item.icon, color: AppColors.primaryGold, size: 21),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    item.label,
                    textAlign: TextAlign.right,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (item.value != null) ...[
                  Text(
                    item.value!,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                ],
                const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.mutedText,
                  size: 15,
                ),
              ],
            ),
          ),
          if (showDivider)
            const Divider(
              height: 1,
              thickness: 1,
              color: AppColors.divider,
              indent: 14,
              endIndent: 14,
            ),
        ],
      ),
    );
  }
}
