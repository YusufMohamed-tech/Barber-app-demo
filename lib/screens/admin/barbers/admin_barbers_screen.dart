import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../data/admin_mock_data.dart';
import '../../../models/admin_barber_model.dart';
import '../../../widgets/admin/admin_widgets.dart';
import '../../../widgets/app_header.dart';
import '../../../widgets/app_screen.dart';
import '../../../widgets/gold_button.dart';
import 'admin_barber_details_screen.dart';

class AdminBarbersScreen extends StatefulWidget {
  const AdminBarbersScreen({super.key});

  @override
  State<AdminBarbersScreen> createState() => _AdminBarbersScreenState();
}

class _AdminBarbersScreenState extends State<AdminBarbersScreen> {
  final _filters = const ['الكل', 'نشط', 'غير نشط', 'الأعلى تقييماً'];
  late List<AdminBarberModel> _barbers;
  String _activeFilter = 'الكل';
  String _query = '';

  @override
  void initState() {
    super.initState();
    _barbers = [...AdminMockData.barbers];
  }

  List<AdminBarberModel> get _visibleBarbers {
    var result = _barbers.where((barber) {
      final matchesQuery =
          _query.trim().isEmpty ||
          barber.name.contains(_query.trim()) ||
          barber.specialty.contains(_query.trim());
      final matchesFilter =
          _activeFilter == 'الكل' ||
          (_activeFilter == 'الأعلى تقييماً') ||
          barber.status == _activeFilter;
      return matchesQuery && matchesFilter;
    }).toList();

    if (_activeFilter == 'الأعلى تقييماً') {
      result.sort((a, b) => b.rating.compareTo(a.rating));
    }
    return result;
  }

  Future<void> _openDetails([AdminBarberModel? barber]) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AdminBarberDetailsScreen(barber: barber),
      ),
    );
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
          GoldButton(
            text: 'إضافة حلاق',
            onPressed: () => _openDetails(),
            icon: Icons.person_add_alt_1_rounded,
            height: 48,
          ),
          const SizedBox(height: AppSpacing.lg),
          AdminSearchBar(
            hint: 'ابحث عن حلاق',
            onChanged: (value) => setState(() => _query = value),
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
                return AdminFilterChip(
                  label: filter,
                  isActive: _activeFilter == filter,
                  onTap: () => setState(() => _activeFilter = filter),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _visibleBarbers.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final barber = _visibleBarbers[index];
              return AdminBarberCard(
                barber: barber,
                onTap: () => _openDetails(barber),
                onEdit: () => _openDetails(barber),
              );
            },
          ),
        ],
      ),
    );
  }
}
