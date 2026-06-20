import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_text_styles.dart';
import '../models/appointment_model.dart';
import 'gold_button.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.appointment,
    this.showActions = false,
  });

  final AppointmentModel appointment;
  final bool showActions;

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(appointment.status);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DateBox(date: appointment.date),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            appointment.serviceName,
                            textAlign: TextAlign.right,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.cardTitle,
                          ),
                        ),
                        _StatusPill(
                          label: appointment.status,
                          color: statusColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      appointment.barberName,
                      textAlign: TextAlign.right,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          size: 16,
                          color: AppColors.mutedText,
                        ),
                        const SizedBox(width: 5),
                        Text(appointment.time, style: AppTextStyles.caption),
                        const Spacer(),
                        Text(
                          appointment.formattedPrice,
                          style: AppTextStyles.cardTitle.copyWith(
                            color: AppColors.primaryGold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (showActions) ...[
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: GoldButton(
                    text: 'إعادة الجدولة',
                    onPressed: () {},
                    variant: GoldButtonVariant.outlined,
                    height: 42,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: GoldButton(
                    text: 'إلغاء',
                    onPressed: () {},
                    variant: GoldButtonVariant.danger,
                    height: 42,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'مؤكد':
        return AppColors.successGreen;
      case 'ملغي':
        return AppColors.dangerRed;
      default:
        return AppColors.mutedText;
    }
  }
}

class _DateBox extends StatelessWidget {
  const _DateBox({required this.date});

  final String date;

  @override
  Widget build(BuildContext context) {
    final parts = date.split(' ');
    return Container(
      width: 66,
      height: 72,
      decoration: BoxDecoration(
        color: AppColors.card2,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderGold),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            parts.first,
            style: AppTextStyles.screenTitle.copyWith(fontSize: 22),
          ),
          Text(
            parts.length > 1 ? parts.last : '',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: label == 'منتهي' ? AppColors.textSecondary : Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 11,
        ),
      ),
    );
  }
}
