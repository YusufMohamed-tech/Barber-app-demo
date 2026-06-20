import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    required this.title,
    this.showBack = false,
    this.onBack,
    this.actions = const [],
  });

  final String title;
  final bool showBack;
  final VoidCallback? onBack;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: Row(
        children: [
          if (showBack)
            _HeaderIcon(
              icon: Icons.arrow_forward_rounded,
              onTap: onBack ?? () => Navigator.of(context).maybePop(),
            )
          else
            const SizedBox(width: 42),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.screenTitle,
            ),
          ),
          if (actions.isNotEmpty)
            Row(mainAxisSize: MainAxisSize.min, children: actions)
          else
            const SizedBox(width: 42),
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
