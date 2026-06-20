import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

class BookingStepIndicator extends StatelessWidget {
  const BookingStepIndicator({
    super.key,
    required this.currentStep,
    required this.steps,
  });

  final int currentStep;
  final List<String> steps;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: List.generate(steps.length, (index) {
          final active = index == currentStep;
          final completed = index < currentStep;
          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: active || completed
                              ? AppColors.primaryGold
                              : AppColors.card2,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: active || completed
                                ? AppColors.primaryGold
                                : AppColors.divider,
                          ),
                        ),
                        child: Center(
                          child: completed
                              ? const Icon(
                                  Icons.check_rounded,
                                  color: AppColors.background,
                                  size: 18,
                                )
                              : Text(
                                  '${index + 1}',
                                  style: AppTextStyles.caption.copyWith(
                                    color: active
                                        ? AppColors.background
                                        : AppColors.textSecondary,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      FittedBox(
                        child: Text(
                          steps[index],
                          style: AppTextStyles.caption.copyWith(
                            color: active || completed
                                ? AppColors.primaryGold
                                : AppColors.mutedText,
                            fontWeight: active
                                ? FontWeight.w900
                                : FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (index != steps.length - 1)
                  Container(
                    width: 16,
                    height: 1,
                    color: completed
                        ? AppColors.primaryGold
                        : AppColors.divider,
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
