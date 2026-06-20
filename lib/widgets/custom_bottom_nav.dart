import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

class BottomNavItem {
  const BottomNavItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const items = <BottomNavItem>[
    BottomNavItem(icon: Icons.home_rounded, label: 'الرئيسية'),
    BottomNavItem(icon: Icons.content_cut_rounded, label: 'الخدمات'),
    BottomNavItem(icon: Icons.person_rounded, label: 'الحلاقون'),
    BottomNavItem(icon: Icons.calendar_month_rounded, label: 'الحجوزات'),
    BottomNavItem(icon: Icons.grid_view_rounded, label: 'المزيد'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 78,
        margin: const EdgeInsets.fromLTRB(14, 0, 14, 10),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.secondaryBackground,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.divider),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.38),
              blurRadius: 24,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        child: Row(
          children: List.generate(items.length, (index) {
            final item = items[index];
            final active = currentIndex == index;
            return Expanded(
              child: InkWell(
                onTap: () => onTap(index),
                borderRadius: BorderRadius.circular(18),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: active
                        ? AppColors.primaryGold.withValues(alpha: 0.12)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        item.icon,
                        size: 22,
                        color: active
                            ? AppColors.primaryGold
                            : AppColors.mutedText,
                      ),
                      const SizedBox(height: 3),
                      FittedBox(
                        child: Text(
                          item.label,
                          style: AppTextStyles.caption.copyWith(
                            color: active
                                ? AppColors.primaryGold
                                : AppColors.mutedText,
                            fontWeight: active
                                ? FontWeight.w900
                                : FontWeight.w600,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
