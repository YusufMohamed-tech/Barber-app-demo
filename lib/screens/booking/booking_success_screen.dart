import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../models/barber_model.dart';
import '../../models/service_model.dart';
import '../../widgets/gold_button.dart';
import '../main/main_shell.dart';

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({
    super.key,
    required this.service,
    required this.barber,
    required this.dateLabel,
    required this.time,
  });

  final ServiceModel service;
  final BarberModel barber;
  final String dateLabel;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 36, 24, 24),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 118,
                height: 118,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [AppColors.lightGold, AppColors.primaryGold],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryGold.withValues(alpha: 0.28),
                      blurRadius: 34,
                      offset: const Offset(0, 14),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: AppColors.background,
                  size: 62,
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              Text(
                'تم تأكيد الحجز',
                textAlign: TextAlign.center,
                style: AppTextStyles.largeTitle.copyWith(fontSize: 28),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'تم حجز موعدك بنجاح، سنذكرك قبل الموعد.',
                textAlign: TextAlign.center,
                style: AppTextStyles.body,
              ),
              const SizedBox(height: AppSpacing.xxl),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: AppColors.borderGold),
                ),
                child: Column(
                  children: [
                    Text(
                      service.name,
                      style: AppTextStyles.sectionTitle.copyWith(
                        color: AppColors.primaryGold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      barber.name,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$dateLabel - $time',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GoldButton(
                text: 'عرض حجوزاتي',
                icon: Icons.calendar_month_rounded,
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const MainShell(initialIndex: 3),
                    ),
                    (_) => false,
                  );
                },
              ),
              const SizedBox(height: AppSpacing.md),
              GoldButton(
                text: 'العودة للرئيسية',
                variant: GoldButtonVariant.outlined,
                icon: Icons.home_rounded,
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const MainShell()),
                    (_) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
