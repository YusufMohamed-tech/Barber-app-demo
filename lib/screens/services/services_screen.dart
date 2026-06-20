import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/mock_data.dart';
import '../../models/service_model.dart';
import '../../widgets/app_header.dart';
import '../../widgets/app_screen.dart';
import '../../widgets/category_chip.dart';
import '../../widgets/service_card.dart';
import '../booking/booking_service_screen.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final _categories = const [
    'كل الخدمات',
    'الشعر',
    'اللحية',
    'البشرة',
    'إضافات',
  ];
  String _activeCategory = 'كل الخدمات';

  List<ServiceModel> get _services {
    if (_activeCategory == 'كل الخدمات') return MockData.services;
    return MockData.services
        .where((service) => service.category == _activeCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      scrollable: true,
      bottomPadding: 112,
      child: Column(
        children: [
          AppHeader(
            title: 'الخدمات',
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search_rounded,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: 42,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: _categories.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, index) {
                final category = _categories[index];
                return CategoryChip(
                  label: category,
                  isActive: _activeCategory == category,
                  onTap: () => setState(() => _activeCategory = category),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          ListView.separated(
            itemCount: _services.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final service = _services[index];
              return ServiceCard(
                service: service,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        BookingServiceScreen(initialService: service),
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
