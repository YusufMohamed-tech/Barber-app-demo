import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_text_styles.dart';
import 'gold_button.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.description,
    this.buttonText,
    this.onPressed,
  });

  final IconData icon;
  final String title;
  final String? description;
  final String? buttonText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 42),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: AppColors.primaryGold.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.borderGold),
              ),
              child: Icon(icon, color: AppColors.primaryGold, size: 34),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.sectionTitle,
            ),
            if (description != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                description!,
                textAlign: TextAlign.center,
                style: AppTextStyles.body,
              ),
            ],
            if (buttonText != null) ...[
              const SizedBox(height: AppSpacing.xl),
              GoldButton(text: buttonText!, onPressed: onPressed),
            ],
          ],
        ),
      ),
    );
  }
}
