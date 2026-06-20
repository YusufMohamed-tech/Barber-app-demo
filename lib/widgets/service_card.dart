import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_text_styles.dart';
import '../models/service_model.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.service,
    this.isSelected = false,
    this.onTap,
    this.compact = false,
  });

  final ServiceModel service;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return _CompactServiceCard(service: service, onTap: onTap);
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.24),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                _ServiceImage(imageUrl: service.imageUrl),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              service.name,
                              textAlign: TextAlign.right,
                              style: AppTextStyles.cardTitle,
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.check_circle_rounded,
                              color: AppColors.primaryGold,
                              size: 21,
                            ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        service.description,
                        textAlign: TextAlign.right,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 16,
                            color: AppColors.textSecondary.withValues(
                              alpha: 0.82,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(service.duration, style: AppTextStyles.caption),
                          const Spacer(),
                          Text(
                            service.formattedPrice,
                            style: AppTextStyles.cardTitle.copyWith(
                              color: AppColors.primaryGold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 14,
                            color: AppColors.primaryGold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CompactServiceCard extends StatelessWidget {
  const _CompactServiceCard({required this.service, required this.onTap});

  final ServiceModel service;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 94,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.divider),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.primaryGold.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.borderGold),
                  ),
                  child: Icon(
                    _serviceIcon(service.id),
                    color: AppColors.primaryGold,
                    size: 23,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  service.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _serviceIcon(String id) {
    switch (id) {
      case 'beard':
        return Icons.face_retouching_natural_rounded;
      case 'facial':
        return Icons.spa_rounded;
      case 'haircare':
        return Icons.water_drop_outlined;
      case 'dye':
        return Icons.palette_outlined;
      case 'groom':
        return Icons.workspace_premium_rounded;
      default:
        return Icons.content_cut_rounded;
    }
  }
}

class _ServiceImage extends StatelessWidget {
  const _ServiceImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: 92,
        height: 92,
        fit: BoxFit.cover,
        placeholder: (context, url) => const _ImagePlaceholder(),
        errorWidget: (context, url, error) => const _ImagePlaceholder(),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      height: 92,
      color: AppColors.card2,
      child: const Icon(
        Icons.content_cut_rounded,
        color: AppColors.primaryGold,
      ),
    );
  }
}
