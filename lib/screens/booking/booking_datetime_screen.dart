import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../models/barber_model.dart';
import '../../models/service_model.dart';
import '../../widgets/app_header.dart';
import '../../widgets/booking_step_indicator.dart';
import '../../widgets/gold_button.dart';
import 'booking_confirm_screen.dart';

class BookingDateTimeScreen extends StatefulWidget {
  const BookingDateTimeScreen({
    super.key,
    required this.service,
    required this.barber,
  });

  final ServiceModel service;
  final BarberModel barber;

  @override
  State<BookingDateTimeScreen> createState() => _BookingDateTimeScreenState();
}

class _BookingDateTimeScreenState extends State<BookingDateTimeScreen> {
  static const _steps = ['الخدمة', 'الحلاق', 'الوقت', 'التأكيد'];
  static const _dates = [
    _BookingDateOption(
      label: 'اليوم',
      dayNumber: '20',
      month: 'يونيو',
      fullLabel: 'السبت، 20 يونيو',
    ),
    _BookingDateOption(
      label: 'غداً',
      dayNumber: '21',
      month: 'يونيو',
      fullLabel: 'الأحد، 21 يونيو',
    ),
    _BookingDateOption(
      label: 'الأحد',
      dayNumber: '22',
      month: 'يونيو',
      fullLabel: 'الأحد، 22 يونيو',
    ),
    _BookingDateOption(
      label: 'الإثنين',
      dayNumber: '23',
      month: 'يونيو',
      fullLabel: 'الإثنين، 23 يونيو',
    ),
    _BookingDateOption(
      label: 'الثلاثاء',
      dayNumber: '24',
      month: 'يونيو',
      fullLabel: 'الثلاثاء، 24 يونيو',
    ),
  ];
  static const _times = [
    _TimeSlot(label: '10:00 ص'),
    _TimeSlot(label: '11:00 ص'),
    _TimeSlot(label: '12:00 م', disabled: true),
    _TimeSlot(label: '01:00 م'),
    _TimeSlot(label: '03:00 م'),
    _TimeSlot(label: '04:00 م'),
    _TimeSlot(label: '05:30 م'),
    _TimeSlot(label: '07:00 م'),
  ];

  int _selectedDateIndex = 0;
  String _selectedTime = '04:00 م';

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
              const BookingStepIndicator(currentStep: 2, steps: _steps),
              const SizedBox(height: AppSpacing.xl),
              Text(
                'اختر التاريخ والوقت',
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              SizedBox(
                height: 104,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _dates.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(width: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final option = _dates[index];
                    return _DateCard(
                      option: option,
                      isSelected: _selectedDateIndex == index,
                      onTap: () => setState(() => _selectedDateIndex = index),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              Text('الأوقات المتاحة', style: AppTextStyles.sectionTitle),
              const SizedBox(height: AppSpacing.md),
              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _times.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 2.35,
                  ),
                  itemBuilder: (context, index) {
                    final slot = _times[index];
                    return _TimeChip(
                      label: slot.label,
                      isSelected: _selectedTime == slot.label,
                      disabled: slot.disabled,
                      onTap: () => setState(() => _selectedTime = slot.label),
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
                  builder: (_) => BookingConfirmScreen(
                    service: widget.service,
                    barber: widget.barber,
                    dateLabel: _dates[_selectedDateIndex].fullLabel,
                    time: _selectedTime,
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

class _BookingDateOption {
  const _BookingDateOption({
    required this.label,
    required this.dayNumber,
    required this.month,
    required this.fullLabel,
  });

  final String label;
  final String dayNumber;
  final String month;
  final String fullLabel;
}

class _TimeSlot {
  const _TimeSlot({required this.label, this.disabled = false});

  final String label;
  final bool disabled;
}

class _DateCard extends StatelessWidget {
  const _DateCard({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  final _BookingDateOption option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 86,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryGold : AppColors.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primaryGold : AppColors.divider,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              option.label,
              style: AppTextStyles.caption.copyWith(
                color: isSelected
                    ? AppColors.background
                    : AppColors.textSecondary,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              option.dayNumber,
              style: AppTextStyles.screenTitle.copyWith(
                color: isSelected
                    ? AppColors.background
                    : AppColors.textPrimary,
              ),
            ),
            Text(
              option.month,
              style: AppTextStyles.caption.copyWith(
                color: isSelected ? AppColors.background : AppColors.mutedText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeChip extends StatelessWidget {
  const _TimeChip({
    required this.label,
    required this.isSelected,
    required this.disabled,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final bool disabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = disabled
        ? AppColors.card2.withValues(alpha: 0.55)
        : isSelected
        ? AppColors.primaryGold
        : AppColors.card;
    final textColor = disabled
        ? AppColors.mutedText
        : isSelected
        ? AppColors.background
        : AppColors.textPrimary;

    return InkWell(
      onTap: disabled ? null : onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primaryGold : AppColors.divider,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.body.copyWith(
            color: textColor,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
