import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../models/barber_model.dart';
import '../../models/service_model.dart';
import '../../widgets/app_header.dart';
import '../../widgets/booking_step_indicator.dart';
import '../../widgets/gold_button.dart';
import 'booking_success_screen.dart';

class BookingConfirmScreen extends StatefulWidget {
  const BookingConfirmScreen({
    super.key,
    required this.service,
    required this.barber,
    required this.dateLabel,
    required this.time,
  });

  final ServiceModel service;
  final BarberModel barber;
  final String dateLabel;
  final String time;

  @override
  State<BookingConfirmScreen> createState() => _BookingConfirmScreenState();
}

class _BookingConfirmScreenState extends State<BookingConfirmScreen> {
  static const _steps = ['الخدمة', 'الحلاق', 'الوقت', 'التأكيد'];
  static const _payments = ['الدفع في المحل', 'بطاقة بنكية', 'محفظة إلكترونية'];
  String _selectedPayment = 'الدفع في المحل';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              const AppHeader(title: 'حجز موعد', showBack: true),
              const SizedBox(height: AppSpacing.md),
              const BookingStepIndicator(currentStep: 3, steps: _steps),
              const SizedBox(height: AppSpacing.xl),
              Text('تأكيد الحجز', style: AppTextStyles.sectionTitle),
              const SizedBox(height: AppSpacing.md),
              _SummaryCard(
                rows: [
                  ('الخدمة', widget.service.name),
                  ('الحلاق', widget.barber.name),
                  ('التاريخ', widget.dateLabel),
                  ('الوقت', widget.time),
                  ('المدة', widget.service.duration),
                  ('السعر', widget.service.formattedPrice),
                ],
              ),
              const SizedBox(height: AppSpacing.xxl),
              Text('طريقة الدفع', style: AppTextStyles.sectionTitle),
              const SizedBox(height: AppSpacing.md),
              ..._payments.map(
                (payment) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _PaymentOption(
                    label: payment,
                    isSelected: _selectedPayment == payment,
                    onTap: () => setState(() => _selectedPayment = payment),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              TextField(
                minLines: 3,
                maxLines: 4,
                textAlign: TextAlign.right,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textPrimary,
                ),
                decoration: const InputDecoration(
                  hintText: 'اكتب ملاحظاتك للحلاق إن وجدت',
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 18),
          decoration: BoxDecoration(
            color: AppColors.background,
            border: Border(
              top: BorderSide(color: AppColors.divider.withValues(alpha: 0.7)),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    'الإجمالي:',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    widget.service.formattedPrice,
                    style: AppTextStyles.sectionTitle.copyWith(
                      color: AppColors.primaryGold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              GoldButton(
                text: 'تأكيد الحجز',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BookingSuccessScreen(
                        service: widget.service,
                        barber: widget.barber,
                        dateLabel: widget.dateLabel,
                        time: widget.time,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.rows});

  final List<(String, String)> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderGold),
      ),
      child: Column(
        children: rows
            .map(
              (row) => Padding(
                padding: EdgeInsets.only(bottom: row == rows.last ? 0 : 12),
                child: Row(
                  children: [
                    Text(
                      '${row.$1}:',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        row.$2,
                        textAlign: TextAlign.left,
                        style: AppTextStyles.body.copyWith(
                          color: row.$1 == 'السعر'
                              ? AppColors.primaryGold
                              : AppColors.textPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _PaymentOption extends StatelessWidget {
  const _PaymentOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.card2 : AppColors.card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? AppColors.primaryGold : AppColors.divider,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.check_circle_rounded
                  : Icons.radio_button_unchecked_rounded,
              color: isSelected ? AppColors.primaryGold : AppColors.mutedText,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                textAlign: TextAlign.right,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
