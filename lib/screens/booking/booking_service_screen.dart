import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/mock_data.dart';
import '../../models/service_model.dart';
import '../../widgets/app_header.dart';
import '../../widgets/booking_step_indicator.dart';
import '../../widgets/gold_button.dart';
import '../../widgets/service_card.dart';
import 'booking_barber_screen.dart';

class BookingServiceScreen extends StatefulWidget {
  const BookingServiceScreen({super.key, this.initialService});

  final ServiceModel? initialService;

  @override
  State<BookingServiceScreen> createState() => _BookingServiceScreenState();
}

class _BookingServiceScreenState extends State<BookingServiceScreen> {
  late ServiceModel _selectedService;

  static const _steps = ['الخدمة', 'الحلاق', 'الوقت', 'التأكيد'];

  @override
  void initState() {
    super.initState();
    _selectedService = widget.initialService ?? MockData.services.first;
  }

  @override
  Widget build(BuildContext context) {
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
              const BookingStepIndicator(currentStep: 0, steps: _steps),
              const SizedBox(height: AppSpacing.xl),
              Text(
                'اختر الخدمة',
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
                  itemCount: MockData.services.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final service = MockData.services[index];
                    return ServiceCard(
                      service: service,
                      isSelected: _selectedService.id == service.id,
                      onTap: () => setState(() => _selectedService = service),
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
                  builder: (_) =>
                      BookingBarberScreen(selectedService: _selectedService),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
