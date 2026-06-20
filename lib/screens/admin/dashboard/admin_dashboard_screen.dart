import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../widgets/admin/admin_widgets.dart';
import '../../../widgets/app_screen.dart';
import '../../../widgets/section_header.dart';
import '../barbers/admin_barber_details_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key, required this.onTabSelected});

  final ValueChanged<int> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      scrollable: true,
      bottomPadding: 112,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _AdminTopHeader(title: 'لوحة التحكم'),
          const SizedBox(height: AppSpacing.lg),
          const _WelcomeCard(),
          const SizedBox(height: AppSpacing.xxl),
          const SectionHeader(title: 'نظرة عامة'),
          const SizedBox(height: AppSpacing.md),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.28,
            children: const [
              AdminStatCard(
                title: 'إجمالي الحجوزات',
                value: '128',
                icon: Icons.calendar_month_rounded,
              ),
              AdminStatCard(
                title: 'الحلاقون',
                value: '12',
                icon: Icons.people_alt_rounded,
              ),
              AdminStatCard(
                title: 'الخدمات',
                value: '24',
                icon: Icons.content_cut_rounded,
              ),
              AdminStatCard(
                title: 'الإيرادات الشهرية',
                value: '8,450 جنيه',
                icon: Icons.account_balance_wallet_rounded,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxl),
          const AdminChartCard(
            title: 'الحجوزات خلال هذا الأسبوع',
            child: AdminBarChart(
              labels: [
                'السبت',
                'الأحد',
                'الإثنين',
                'الثلاثاء',
                'الأربعاء',
                'الخميس',
                'الجمعة',
              ],
              values: [20, 30, 25, 35, 28, 32, 18],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          const SectionHeader(title: 'الإجراءات السريعة'),
          const SizedBox(height: AppSpacing.md),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.8,
            children: [
              AdminActionButton(
                title: 'إضافة حلاق',
                icon: Icons.person_add_alt_1_rounded,
                filled: true,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const AdminBarberDetailsScreen(),
                  ),
                ),
              ),
              AdminActionButton(
                title: 'إضافة خدمة',
                icon: Icons.add_circle_rounded,
                onTap: () => onTabSelected(2),
              ),
              AdminActionButton(
                title: 'عرض الحجوزات',
                icon: Icons.calendar_month_rounded,
                onTap: () => onTabSelected(3),
              ),
              AdminActionButton(
                title: 'التقارير',
                icon: Icons.bar_chart_rounded,
                onTap: () => onTabSelected(4),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AdminTopHeader extends StatelessWidget {
  const _AdminTopHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: Row(
        children: [
          _HeaderIcon(icon: Icons.menu_rounded, onTap: () {}),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.screenTitle,
            ),
          ),
          _HeaderIcon(icon: Icons.notifications_none_rounded, onTap: () {}),
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.divider),
        ),
        child: Icon(icon, color: AppColors.textPrimary, size: 22),
      ),
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.borderGold),
        gradient: LinearGradient(
          colors: [
            AppColors.card2.withValues(alpha: 0.95),
            AppColors.card.withValues(alpha: 0.95),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 74,
            height: 74,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: AppColors.secondaryBackground,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryGold),
            ),
            child: ClipOval(
              child: Image.asset(AppAssets.appLogo, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'مرحباً بك',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text('مدير النظام', style: AppTextStyles.sectionTitle),
                const SizedBox(height: 4),
                Text(
                  'صالون الحلاقة',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primaryGold,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.admin_panel_settings_rounded,
            color: AppColors.primaryGold,
            size: 34,
          ),
        ],
      ),
    );
  }
}
