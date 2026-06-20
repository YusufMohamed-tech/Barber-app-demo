import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../widgets/admin/admin_widgets.dart';
import '../../../widgets/app_header.dart';
import '../../../widgets/app_screen.dart';

class AdminReportsScreen extends StatefulWidget {
  const AdminReportsScreen({super.key});

  @override
  State<AdminReportsScreen> createState() => _AdminReportsScreenState();
}

class _AdminReportsScreenState extends State<AdminReportsScreen> {
  final _filters = const [
    'هذا الأسبوع',
    'هذا الشهر',
    'آخر 7 أيام',
    'آخر 30 يوم',
  ];
  String _activeFilter = 'هذا الأسبوع';

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      scrollable: true,
      bottomPadding: 112,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppHeader(title: 'التقارير'),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: 42,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: _filters.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, index) {
                final filter = _filters[index];
                return AdminFilterChip(
                  label: filter,
                  isActive: _activeFilter == filter,
                  onTap: () => setState(() => _activeFilter = filter),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          const _RevenueCard(),
          const SizedBox(height: AppSpacing.xl),
          const AdminChartCard(
            title: 'الإيرادات اليومية',
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
              values: [10000, 14000, 12000, 18000, 11000, 16000, 15000],
              height: 160,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          _RankedListCard(
            title: 'الخدمات الأكثر طلباً',
            rows: const [
              ('حلاقة + لحية', '120 خدمة'),
              ('حلاقة حديثة', '98 خدمة'),
              ('حلاقة كلاسيكية', '85 خدمة'),
              ('تنظيف بشرة', '62 خدمة'),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          _RankedListCard(
            title: 'أداء الحلاقين',
            rows: const [
              ('أحمد المصري', '45 حجز'),
              ('محمد محمود', '38 حجز'),
              ('علي رضا', '31 حجز'),
            ],
          ),
        ],
      ),
    );
  }
}

class _RevenueCard extends StatelessWidget {
  const _RevenueCard();

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
            AppColors.card2.withValues(alpha: 0.96),
            AppColors.card.withValues(alpha: 0.96),
          ],
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AppColors.primaryGold.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.borderGold),
            ),
            child: const Icon(
              Icons.account_balance_wallet_rounded,
              color: AppColors.primaryGold,
              size: 30,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('إجمالي الإيرادات', style: AppTextStyles.body),
                const SizedBox(height: 4),
                Text(
                  '58,450 جنيه',
                  style: AppTextStyles.largeTitle.copyWith(fontSize: 28),
                ),
              ],
            ),
          ),
          Text(
            '+12.5%',
            style: AppTextStyles.cardTitle.copyWith(
              color: const Color(0xFF83D8A8),
            ),
          ),
        ],
      ),
    );
  }
}

class _RankedListCard extends StatelessWidget {
  const _RankedListCard({required this.title, required this.rows});

  final String title;
  final List<(String, String)> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.cardTitle),
          const SizedBox(height: AppSpacing.lg),
          ...List.generate(rows.length, (index) {
            final row = rows[index];
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == rows.length - 1 ? 0 : 12,
              ),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGold.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.borderGold),
                    ),
                    child: Text(
                      '${index + 1}',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primaryGold,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      row.$1,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  Text(
                    row.$2,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primaryGold,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
