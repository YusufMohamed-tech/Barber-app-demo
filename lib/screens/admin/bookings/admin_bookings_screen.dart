import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../data/admin_mock_data.dart';
import '../../../models/admin_booking_model.dart';
import '../../../widgets/admin/admin_widgets.dart';
import '../../../widgets/app_header.dart';
import '../../../widgets/app_screen.dart';
import 'admin_booking_details_screen.dart';

class AdminBookingsScreen extends StatefulWidget {
  const AdminBookingsScreen({super.key});

  @override
  State<AdminBookingsScreen> createState() => _AdminBookingsScreenState();
}

class _AdminBookingsScreenState extends State<AdminBookingsScreen> {
  final _filters = const ['الكل', 'مؤكد', 'منتهي', 'ملغي'];
  late List<AdminBookingModel> _bookings;
  String _activeFilter = 'الكل';
  String _query = '';

  @override
  void initState() {
    super.initState();
    _bookings = [...AdminMockData.bookings];
  }

  List<AdminBookingModel> get _visibleBookings {
    return _bookings.where((booking) {
      final query = _query.trim();
      final matchesQuery =
          query.isEmpty ||
          booking.clientName.contains(query) ||
          booking.serviceName.contains(query) ||
          booking.barberName.contains(query);
      final matchesFilter =
          _activeFilter == 'الكل' || booking.status == _activeFilter;
      return matchesQuery && matchesFilter;
    }).toList();
  }

  Future<void> _openDetails(AdminBookingModel booking) async {
    final updated = await Navigator.of(context).push<AdminBookingModel>(
      MaterialPageRoute(
        builder: (_) => AdminBookingDetailsScreen(booking: booking),
      ),
    );
    if (updated == null) return;
    setState(() {
      final index = _bookings.indexWhere((item) => item.id == updated.id);
      if (index != -1) _bookings[index] = updated;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      scrollable: true,
      bottomPadding: 112,
      child: Column(
        children: [
          const AppHeader(title: 'الحجوزات'),
          const SizedBox(height: AppSpacing.lg),
          AdminSearchBar(
            hint: 'ابحث عن حجز',
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
            itemCount: _visibleBookings.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final booking = _visibleBookings[index];
              return AdminBookingCard(
                booking: booking,
                onTap: () => _openDetails(booking),
              );
            },
          ),
        ],
      ),
    );
  }
}
