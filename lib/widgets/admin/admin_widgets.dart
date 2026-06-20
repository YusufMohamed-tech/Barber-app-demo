import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../models/admin_barber_model.dart';
import '../../models/admin_booking_model.dart';
import '../../models/admin_client_model.dart';
import '../../models/admin_service_model.dart';

class AdminStatCard extends StatelessWidget {
  const AdminStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.color = AppColors.primaryGold,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: color, size: 21),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      value,
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      style: AppTextStyles.sectionTitle.copyWith(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            title,
            textAlign: TextAlign.right,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class AdminActionButton extends StatelessWidget {
  const AdminActionButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.filled = false,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        decoration: BoxDecoration(
          color: filled
              ? AppColors.primaryGold
              : AppColors.primaryGold.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderGold),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: filled ? AppColors.background : AppColors.primaryGold,
              size: 19,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.caption.copyWith(
                  color: filled ? AppColors.background : AppColors.primaryGold,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminSearchBar extends StatelessWidget {
  const AdminSearchBar({super.key, required this.hint, this.onChanged});

  final String hint;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      textAlign: TextAlign.right,
      style: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: AppColors.primaryGold,
        ),
      ),
    );
  }
}

class AdminFilterChip extends StatelessWidget {
  const AdminFilterChip({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryGold : AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive ? AppColors.primaryGold : AppColors.divider,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: isActive ? AppColors.background : AppColors.textSecondary,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

enum StatusType { confirmed, completed, cancelled, active, inactive, neutral }

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.label, this.statusType});

  final String label;
  final StatusType? statusType;

  @override
  Widget build(BuildContext context) {
    final type = statusType ?? _typeFromLabel(label);
    final color = switch (type) {
      StatusType.confirmed || StatusType.active => AppColors.successGreen,
      StatusType.cancelled || StatusType.inactive => AppColors.dangerRed,
      StatusType.completed || StatusType.neutral => AppColors.mutedText,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.20),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: type == StatusType.completed
              ? AppColors.textSecondary
              : Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: 11,
        ),
      ),
    );
  }

  StatusType _typeFromLabel(String label) {
    switch (label) {
      case 'مؤكد':
        return StatusType.confirmed;
      case 'منتهي':
        return StatusType.completed;
      case 'ملغي':
        return StatusType.cancelled;
      case 'نشط':
        return StatusType.active;
      case 'غير نشط':
        return StatusType.inactive;
      default:
        return StatusType.neutral;
    }
  }
}

class AdminBarberCard extends StatelessWidget {
  const AdminBarberCard({
    super.key,
    required this.barber,
    required this.onTap,
    this.onEdit,
  });

  final AdminBarberModel barber;
  final VoidCallback onTap;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return _AdminCardShell(
      onTap: onTap,
      child: Row(
        children: [
          AdminAvatar(imageUrl: barber.imageUrl, size: 62),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(barber.name, style: AppTextStyles.cardTitle),
                    ),
                    StatusBadge(label: barber.status),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  barber.specialty,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 7),
                Wrap(
                  spacing: 10,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _GoldMeta(
                      icon: Icons.star_rounded,
                      label: barber.rating.toStringAsFixed(1),
                    ),
                    _GoldMeta(icon: Icons.phone_rounded, label: barber.phone),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onEdit ?? onTap,
            icon: const Icon(Icons.edit_rounded, color: AppColors.primaryGold),
          ),
        ],
      ),
    );
  }
}

class AdminServiceCard extends StatelessWidget {
  const AdminServiceCard({
    super.key,
    required this.service,
    required this.onTap,
    this.onEdit,
  });

  final AdminServiceModel service;
  final VoidCallback onTap;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return _AdminCardShell(
      onTap: onTap,
      child: Row(
        children: [
          AdminImage(imageUrl: service.imageUrl, size: 72),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.cardTitle,
                ),
                const SizedBox(height: 5),
                Text(
                  service.category,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _GoldMeta(
                      icon: Icons.access_time_rounded,
                      label: service.duration,
                    ),
                    const Spacer(),
                    Text(
                      service.formattedPrice,
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
          IconButton(
            onPressed: onEdit ?? onTap,
            icon: const Icon(Icons.edit_rounded, color: AppColors.primaryGold),
          ),
          const Icon(Icons.more_vert_rounded, color: AppColors.mutedText),
        ],
      ),
    );
  }
}

class AdminBookingCard extends StatelessWidget {
  const AdminBookingCard({
    super.key,
    required this.booking,
    required this.onTap,
  });

  final AdminBookingModel booking;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _AdminCardShell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(booking.clientName, style: AppTextStyles.cardTitle),
              ),
              StatusBadge(label: booking.status),
              const SizedBox(width: 6),
              const Icon(Icons.more_vert_rounded, color: AppColors.mutedText),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            booking.serviceName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              _GoldMeta(icon: Icons.person_rounded, label: booking.barberName),
              _GoldMeta(
                icon: Icons.calendar_month_rounded,
                label: booking.date,
              ),
              _GoldMeta(icon: Icons.access_time_rounded, label: booking.time),
            ],
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              booking.formattedPrice,
              style: AppTextStyles.cardTitle.copyWith(
                color: AppColors.primaryGold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AdminClientCard extends StatelessWidget {
  const AdminClientCard({super.key, required this.client, required this.onTap});

  final AdminClientModel client;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _AdminCardShell(
      onTap: onTap,
      child: Row(
        children: [
          AdminAvatar(imageUrl: client.imageUrl, size: 56),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(client.name, style: AppTextStyles.cardTitle),
                const SizedBox(height: 4),
                Text(
                  client.phone,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryGold.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.borderGold),
            ),
            child: Column(
              children: [
                Text(
                  '${client.bookingsCount}',
                  style: AppTextStyles.cardTitle.copyWith(
                    color: AppColors.primaryGold,
                  ),
                ),
                Text(
                  'حجز',
                  style: AppTextStyles.caption.copyWith(fontSize: 10),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          const Icon(Icons.more_vert_rounded, color: AppColors.mutedText),
        ],
      ),
    );
  }
}

class AdminChartCard extends StatelessWidget {
  const AdminChartCard({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.cardTitle),
          const SizedBox(height: AppSpacing.lg),
          child,
        ],
      ),
    );
  }
}

class AdminBarChart extends StatelessWidget {
  const AdminBarChart({
    super.key,
    required this.labels,
    required this.values,
    this.height = 150,
  });

  final List<String> labels;
  final List<int> values;
  final double height;

  @override
  Widget build(BuildContext context) {
    final maxValue = values.reduce((a, b) => a > b ? a : b);
    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(values.length, (index) {
          final ratio = values[index] / maxValue;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 240),
                        height: (height - 38) * ratio,
                        width: 18,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.lightGold,
                              AppColors.primaryGold,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  FittedBox(
                    child: Text(
                      labels[index],
                      style: AppTextStyles.caption.copyWith(fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class AdminAvatar extends StatelessWidget {
  const AdminAvatar({super.key, required this.imageUrl, this.size = 58});

  final String imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        color: AppColors.primaryGold,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          errorWidget: (_, _, _) =>
              const _FallbackIcon(icon: Icons.person_rounded),
          placeholder: (_, _) =>
              const _FallbackIcon(icon: Icons.person_rounded),
        ),
      ),
    );
  }
}

class AdminImage extends StatelessWidget {
  const AdminImage({super.key, required this.imageUrl, this.size = 70});

  final String imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorWidget: (_, _, _) =>
            const _FallbackIcon(icon: Icons.content_cut_rounded),
        placeholder: (_, _) =>
            const _FallbackIcon(icon: Icons.content_cut_rounded),
      ),
    );
  }
}

class AdminBottomNav extends StatelessWidget {
  const AdminBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const items = [
    (Icons.dashboard_rounded, 'لوحة التحكم'),
    (Icons.people_alt_rounded, 'الحلاقون'),
    (Icons.content_cut_rounded, 'الخدمات'),
    (Icons.calendar_month_rounded, 'الحجوزات'),
    (Icons.bar_chart_rounded, 'التقارير'),
    (Icons.settings_rounded, 'الإعدادات'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 78,
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
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
            final active = currentIndex == index;
            return Expanded(
              child: InkWell(
                onTap: () => onTap(index),
                borderRadius: BorderRadius.circular(17),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 2,
                  ),
                  decoration: BoxDecoration(
                    color: active
                        ? AppColors.primaryGold.withValues(alpha: 0.12)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        items[index].$1,
                        color: active
                            ? AppColors.primaryGold
                            : AppColors.mutedText,
                        size: 21,
                      ),
                      const SizedBox(height: 3),
                      FittedBox(
                        child: Text(
                          items[index].$2,
                          style: AppTextStyles.caption.copyWith(
                            color: active
                                ? AppColors.primaryGold
                                : AppColors.mutedText,
                            fontWeight: active
                                ? FontWeight.w900
                                : FontWeight.w600,
                            fontSize: 10,
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

class _AdminCardShell extends StatelessWidget {
  const _AdminCardShell({required this.child, required this.onTap});

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.divider),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _GoldMeta extends StatelessWidget {
  const _GoldMeta({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.primaryGold, size: 15),
        const SizedBox(width: 4),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _FallbackIcon extends StatelessWidget {
  const _FallbackIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.card2,
      child: Icon(icon, color: AppColors.primaryGold),
    );
  }
}
