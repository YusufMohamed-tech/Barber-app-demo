import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/mock_data.dart';
import '../../models/appointment_model.dart';
import '../../widgets/app_header.dart';
import '../../widgets/app_screen.dart';
import '../../widgets/appointment_card.dart';
import '../../widgets/empty_state.dart';
import '../booking/booking_service_screen.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final _tabs = const ['القادمة', 'المنتهية', 'الملغية'];
  int _selectedTab = 0;

  List<AppointmentModel> get _appointments {
    switch (_selectedTab) {
      case 1:
        return MockData.pastAppointments;
      case 2:
        return MockData.cancelledAppointments;
      default:
        return MockData.upcomingAppointments;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appointments = _appointments;

    return AppScreen(
      scrollable: true,
      bottomPadding: 112,
      child: Column(
        children: [
          const AppHeader(title: 'حجوزاتي'),
          const SizedBox(height: AppSpacing.lg),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.secondaryBackground,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.divider),
            ),
            child: Row(
              children: List.generate(_tabs.length, (index) {
                return Expanded(
                  child: _AppointmentTab(
                    label: _tabs[index],
                    selected: _selectedTab == index,
                    onTap: () => setState(() => _selectedTab = index),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          if (appointments.isEmpty)
            EmptyState(
              icon: Icons.calendar_month_rounded,
              title: 'لا توجد حجوزات حالياً',
              description: 'اختر خدمة وحلاقك المفضل واحجز موعدك القادم.',
              buttonText: 'احجز الآن',
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const BookingServiceScreen()),
              ),
            )
          else
            ListView.separated(
              itemCount: appointments.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, index) {
                return AppointmentCard(
                  appointment: appointments[index],
                  showActions: _selectedTab == 0,
                );
              },
            ),
        ],
      ),
    );
  }
}

class _AppointmentTab extends StatelessWidget {
  const _AppointmentTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryGold : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: selected ? AppColors.background : AppColors.textSecondary,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
