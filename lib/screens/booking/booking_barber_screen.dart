import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/mock_data.dart';
import '../../models/barber_model.dart';
import '../../models/service_model.dart';
import '../../widgets/app_header.dart';
import '../../widgets/barber_card.dart';
import '../../widgets/booking_step_indicator.dart';
import '../../widgets/gold_button.dart';
import 'booking_datetime_screen.dart';

class BookingBarberScreen extends StatefulWidget {
  const BookingBarberScreen({
    super.key,
    this.selectedService,
    this.initialBarber,
  });

  final ServiceModel? selectedService;
  final BarberModel? initialBarber;

  @override
  State<BookingBarberScreen> createState() => _BookingBarberScreenState();
}

class _BookingBarberScreenState extends State<BookingBarberScreen> {
  late BarberModel _selectedBarber;

  static const _steps = ['الخدمة', 'الحلاق', 'الوقت', 'التأكيد'];

  @override
  void initState() {
    super.initState();
    _selectedBarber = widget.initialBarber ?? MockData.barbers.first;
  }

  @override
  Widget build(BuildContext context) {
    final service = widget.selectedService ?? MockData.services.first;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppHeader(title: 'حجز موعد', showBack: true),
              const SizedBox(height: AppSpacing.md),
              const BookingStepIndicator(currentStep: 1, steps: _steps),
              const SizedBox(height: AppSpacing.xl),
              Text(
                'اختر الحلاق',
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 18),
                  itemCount: MockData.barbers.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final barber = MockData.barbers[index];
                    return BarberCard(
                      barber: barber,
                      isSelected: _selectedBarber.id == barber.id,
                      onTap: () => setState(() => _selectedBarber = barber),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 18),
          decoration: BoxDecoration(
            color: AppColors.background,
            border: Border(
              top: BorderSide(color: AppColors.divider.withValues(alpha: 0.7)),
            ),
          ),
          child: GoldButton(
            text: 'التالي',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BookingDateTimeScreen(
                    service: service,
                    barber: _selectedBarber,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
