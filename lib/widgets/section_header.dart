import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.actionText,
    this.onActionTap,
  });

  final String title;
  final String? actionText;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.right,
            style: AppTextStyles.sectionTitle,
          ),
        ),
        if (actionText != null)
          TextButton(
            onPressed: onActionTap,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primaryGold,
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
            child: Text(
              actionText!,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.primaryGold,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
      ],
    );
  }
}
