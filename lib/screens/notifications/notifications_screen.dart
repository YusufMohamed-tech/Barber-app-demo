import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/app_header.dart';
import '../../widgets/app_screen.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = const [
      _NotificationData(
        title: 'تم تأكيد حجزك',
        body: 'موعدك مع أحمد مسعود يوم السبت الساعة 04:00 م',
        time: 'منذ 5 دقائق',
        icon: Icons.check_circle_outline_rounded,
      ),
      _NotificationData(
        title: 'عرض جديد',
        body: 'احصل على خصم 20% على باكدج العريس هذا الأسبوع',
        time: 'اليوم',
        icon: Icons.local_offer_outlined,
      ),
      _NotificationData(
        title: 'تذكير بالموعد',
        body: 'متبقي ساعتين على موعدك القادم',
        time: 'أمس',
        icon: Icons.alarm_rounded,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: AppScreen(
        scrollable: true,
        child: Column(
          children: [
            const AppHeader(title: 'الإشعارات', showBack: true),
            const SizedBox(height: AppSpacing.lg),
            ListView.separated(
              itemCount: notifications.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, index) {
                return _NotificationCard(data: notifications[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationData {
  const _NotificationData({
    required this.title,
    required this.body,
    required this.time,
    required this.icon,
  });

  final String title;
  final String body;
  final String time;
  final IconData icon;
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.data});

  final _NotificationData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.primaryGold.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: AppColors.borderGold),
            ),
            child: Icon(data.icon, color: AppColors.primaryGold, size: 23),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  textAlign: TextAlign.right,
                  style: AppTextStyles.cardTitle,
                ),
                const SizedBox(height: 6),
                Text(
                  data.body,
                  textAlign: TextAlign.right,
                  style: AppTextStyles.body,
                ),
                const SizedBox(height: 8),
                Text(
                  data.time,
                  textAlign: TextAlign.right,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primaryGold,
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
