import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/mock_data.dart';
import '../../models/barber_model.dart';
import '../../widgets/app_header.dart';
import '../../widgets/app_screen.dart';
import '../../widgets/barber_card.dart';
import '../../widgets/category_chip.dart';
import '../booking/booking_barber_screen.dart';

class BarbersScreen extends StatefulWidget {
  const BarbersScreen({super.key});

  @override
  State<BarbersScreen> createState() => _BarbersScreenState();
}

class _BarbersScreenState extends State<BarbersScreen> {
  final _filters = const [
    'الكل',
    'الأعلى تقييماً',
    'الشعر',
    'اللحية',
    'البشرة',
  ];
  String _activeFilter = 'الكل';

  List<BarberModel> get _barbers {
    final barbers = [...MockData.barbers];
    if (_activeFilter == 'الأعلى تقييماً') {
      barbers.sort((a, b) => b.rating.compareTo(a.rating));
    }
    return barbers;
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      scrollable: true,
      bottomPadding: 112,
      child: Column(
        children: [
          const AppHeader(title: 'الحلاقون'),
          const SizedBox(height: AppSpacing.lg),
          TextField(
            textAlign: TextAlign.right,
            style: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
            decoration: const InputDecoration(
              hintText: 'ابحث عن حلاق',
              prefixIcon: Icon(
                Icons.search_rounded,
                color: AppColors.primaryGold,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: 42,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: _filters.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, index) {
                final filter = _filters[index];
                return CategoryChip(
                  label: filter,
                  isActive: _activeFilter == filter,
                  onTap: () => setState(() => _activeFilter = filter),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          ListView.separated(
            itemCount: _barbers.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final barber = _barbers[index];
              return BarberCard(
                barber: barber,
                showBookButton: true,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BookingBarberScreen(initialBarber: barber),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
