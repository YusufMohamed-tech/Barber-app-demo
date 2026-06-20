import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/mock_data.dart';
import '../../widgets/app_screen.dart';
import '../../widgets/barber_card.dart';
import '../../widgets/gold_button.dart';
import '../../widgets/section_header.dart';
import '../../widgets/service_card.dart';
import '../booking/booking_service_screen.dart';
import '../notifications/notifications_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onTabSelected});

  final ValueChanged<int> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      scrollable: true,
      bottomPadding: 112,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HomeHeader(
            onNotificationsTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const NotificationsScreen()),
              );
            },
          ),
          const SizedBox(height: AppSpacing.xl),
          _HeroOfferCard(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const BookingServiceScreen()),
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          SectionHeader(
            title: 'خدمات مميزة',
            actionText: 'عرض الكل',
            onActionTap: () => onTabSelected(1),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 126,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: 4,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.md),
              itemBuilder: (context, index) {
                final service = MockData.services[index];
                return ServiceCard(
                  service: service,
                  compact: true,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          BookingServiceScreen(initialService: service),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          SectionHeader(
            title: 'أفضل الحلاقين',
            actionText: 'عرض الكل',
            onActionTap: () => onTabSelected(2),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 172,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: 3,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.md),
              itemBuilder: (context, index) {
                final barber = MockData.barbers[index];
                return BarberCard(
                  barber: barber,
                  compact: true,
                  onTap: () => onTabSelected(2),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          _WeeklyOfferCard(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const BookingServiceScreen()),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({required this.onNotificationsTap});

  final VoidCallback onNotificationsTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _IconTile(icon: Icons.menu_rounded, onTap: () {}),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'مرحباً أحمد 👋',
                textAlign: TextAlign.right,
                style: AppTextStyles.sectionTitle,
              ),
              const SizedBox(height: 2),
              Text(
                'جاهز لإطلالة جديدة اليوم؟',
                textAlign: TextAlign.right,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.location_on_rounded,
                    color: AppColors.primaryGold,
                    size: 15,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'فرع مدينة نصر',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primaryGold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        _IconTile(
          icon: Icons.notifications_none_rounded,
          onTap: onNotificationsTap,
        ),
      ],
    );
  }
}

class _IconTile extends StatelessWidget {
  const _IconTile({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
        ),
        child: Icon(icon, color: AppColors.textPrimary, size: 22),
      ),
    );
  }
}

class _HeroOfferCard extends StatelessWidget {
  const _HeroOfferCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 154,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.borderGold),
        gradient: const LinearGradient(
          colors: [AppColors.card2, AppColors.secondaryBackground],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: 152,
            child: CachedNetworkImage(
              imageUrl: AppAssets.heroHaircut,
              fit: BoxFit.cover,
              color: Colors.black.withValues(alpha: 0.18),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    AppColors.card.withValues(alpha: 0.9),
                  ],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 142, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'خصم 20%',
                  textAlign: TextAlign.right,
                  style: AppTextStyles.largeTitle.copyWith(
                    color: AppColors.lightGold,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'على جميع خدمات الحلاقة',
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 104,
                  child: GoldButton(
                    text: 'احجز الآن',
                    onPressed: onTap,
                    height: 36,
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

class _WeeklyOfferCard extends StatelessWidget {
  const _WeeklyOfferCard({required this.onTap});

  final VoidCallback onTap;

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
          Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              color: AppColors.primaryGold.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.spa_rounded,
              color: AppColors.primaryGold,
              size: 36,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'عرض الأسبوع',
                  textAlign: TextAlign.right,
                  style: AppTextStyles.cardTitle.copyWith(
                    color: AppColors.primaryGold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'تنظيف بشرة مجاناً مع أي خدمة حلاقة',
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 112,
                  child: GoldButton(
                    text: 'استفد الآن',
                    onPressed: onTap,
                    height: 38,
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
