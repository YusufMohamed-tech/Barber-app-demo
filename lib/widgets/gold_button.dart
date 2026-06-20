import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

enum GoldButtonVariant { filled, outlined, danger }

class GoldButton extends StatelessWidget {
  const GoldButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = GoldButtonVariant.filled,
    this.isLoading = false,
    this.disabled = false,
    this.height = 54,
    this.icon,
  });

  final String text;
  final VoidCallback? onPressed;
  final GoldButtonVariant variant;
  final bool isLoading;
  final bool disabled;
  final double height;
  final IconData? icon;

  bool get _enabled => onPressed != null && !disabled && !isLoading;

  @override
  Widget build(BuildContext context) {
    final isFilled = variant == GoldButtonVariant.filled;
    final isDanger = variant == GoldButtonVariant.danger;
    final textColor = isFilled
        ? AppColors.background
        : isDanger
        ? AppColors.textPrimary
        : AppColors.primaryGold;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 180),
      opacity: _enabled ? 1 : 0.55,
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: isFilled
                ? const LinearGradient(
                    colors: [AppColors.lightGold, AppColors.primaryGold],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  )
                : null,
            color: isDanger
                ? AppColors.dangerRed.withValues(alpha: 0.34)
                : isFilled
                ? null
                : Colors.transparent,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isDanger ? AppColors.dangerRed : AppColors.borderGold,
            ),
            boxShadow: isFilled
                ? [
                    BoxShadow(
                      color: AppColors.primaryGold.withValues(alpha: 0.22),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(18),
            child: InkWell(
              onTap: _enabled ? onPressed : null,
              borderRadius: BorderRadius.circular(18),
              child: Center(
                child: isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(textColor),
                        ),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (icon != null) ...[
                            Icon(icon, color: textColor, size: 19),
                            const SizedBox(width: 8),
                          ],
                          Text(
                            text,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.button.copyWith(
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
