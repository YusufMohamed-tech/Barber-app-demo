import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_text_styles.dart';
import '../models/barber_model.dart';
import 'gold_button.dart';

class BarberCard extends StatelessWidget {
  const BarberCard({
    super.key,
    required this.barber,
    this.isSelected = false,
    this.onTap,
    this.showBookButton = false,
    this.compact = false,
  });

  final BarberModel barber;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool showBookButton;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return _CompactBarberCard(barber: barber, onTap: onTap);
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.card2 : AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppColors.primaryGold : AppColors.divider,
          width: isSelected ? 1.2 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BarberAvatar(imageUrl: barber.imageUrl, radius: 34),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        barber.name,
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.cardTitle,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        barber.specialty,
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 10,
                        runSpacing: 6,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          _Rating(rating: barber.rating),
                          Text(barber.reviews, style: AppTextStyles.caption),
                          _StatusBadge(status: barber.status),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                if (showBookButton)
                  SizedBox(
                    width: 92,
                    child: GoldButton(
                      text: 'احجز معه',
                      onPressed: onTap,
                      height: 38,
                    ),
                  )
                else
                  Icon(
                    isSelected
                        ? Icons.check_circle_rounded
                        : Icons.radio_button_unchecked_rounded,
                    color: isSelected
                        ? AppColors.primaryGold
                        : AppColors.mutedText,
                    size: 24,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CompactBarberCard extends StatelessWidget {
  const _CompactBarberCard({required this.barber, required this.onTap});

  final BarberModel barber;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 126,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.divider),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BarberAvatar(imageUrl: barber.imageUrl, radius: 30),
                const SizedBox(height: 8),
                Text(
                  barber.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                _Rating(rating: barber.rating),
                const SizedBox(height: 2),
                Text(
                  barber.specialty,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.caption.copyWith(fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BarberAvatar extends StatelessWidget {
  const BarberAvatar({super.key, required this.imageUrl, this.radius = 30});

  final String imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        color: AppColors.primaryGold,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
          placeholder: (context, url) => _AvatarFallback(size: radius * 2),
          errorWidget: (context, url, error) =>
              _AvatarFallback(size: radius * 2),
        ),
      ),
    );
  }
}

class _AvatarFallback extends StatelessWidget {
  const _AvatarFallback({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: AppColors.card2,
      child: const Icon(Icons.person_rounded, color: AppColors.primaryGold),
    );
  }
}

class _Rating extends StatelessWidget {
  const _Rating({required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star_rounded, size: 15, color: AppColors.primaryGold),
        const SizedBox(width: 3),
        Text(
          rating.toStringAsFixed(1),
          style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final isBusy = status == 'مشغول';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isBusy
            ? AppColors.dangerRed.withValues(alpha: 0.18)
            : AppColors.successGreen.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: AppTextStyles.caption.copyWith(
          color: isBusy ? const Color(0xFFFF9084) : const Color(0xFF83D8A8),
          fontWeight: FontWeight.w800,
          fontSize: 11,
        ),
      ),
    );
  }
}
