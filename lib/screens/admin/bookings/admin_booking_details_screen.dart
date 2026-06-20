import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../models/admin_booking_model.dart';
import '../../../widgets/admin/admin_widgets.dart';
import '../../../widgets/app_header.dart';
import '../../../widgets/app_screen.dart';
import '../../../widgets/gold_button.dart';
import '../../auth/auth_widgets.dart';

class AdminBookingDetailsScreen extends StatefulWidget {
  const AdminBookingDetailsScreen({super.key, required this.booking});

  final AdminBookingModel booking;

  @override
  State<AdminBookingDetailsScreen> createState() =>
      _AdminBookingDetailsScreenState();
}

class _AdminBookingDetailsScreenState extends State<AdminBookingDetailsScreen> {
  late AdminBookingModel _booking;

  @override
  void initState() {
    super.initState();
    _booking = widget.booking;
  }

  Future<void> _editBooking() async {
    final updated = await showModalBottomSheet<AdminBookingModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _BookingEditSheet(booking: _booking),
    );
    if (updated == null) return;
    setState(() => _booking = updated);
    if (mounted) showArabicSnackBar(context, 'تم حفظ التغييرات بنجاح');
  }

  Future<void> _cancelBooking() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.card,
        title: Text('إلغاء الحجز', style: AppTextStyles.sectionTitle),
        content: Text('هل تريد إلغاء هذا الحجز؟', style: AppTextStyles.body),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('لا'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'نعم، إلغاء الحجز',
              style: TextStyle(color: AppColors.dangerRed),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      setState(() => _booking = _booking.copyWith(status: 'ملغي'));
      showArabicSnackBar(context, 'تم إلغاء الحجز');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: AppScreen(
        scrollable: true,
        bottomPadding: 118,
        child: Column(
          children: [
            AppHeader(
              title: 'تفاصيل الحجز',
              showBack: true,
              onBack: () => Navigator.of(context).pop(_booking),
            ),
            const SizedBox(height: AppSpacing.lg),
            Align(
              alignment: Alignment.centerLeft,
              child: StatusBadge(label: _booking.status),
            ),
            const SizedBox(height: AppSpacing.md),
            _ClientCard(booking: _booking),
            const SizedBox(height: AppSpacing.lg),
            _DetailsCard(
              rows: [
                ('الخدمة', _booking.serviceName, Icons.content_cut_rounded),
                ('الحلاق', _booking.barberName, Icons.person_rounded),
                ('التاريخ', _booking.date, Icons.calendar_month_rounded),
                ('الوقت', _booking.time, Icons.access_time_rounded),
                ('المدة', _booking.duration, Icons.timelapse_rounded),
                (
                  'السعر',
                  _booking.formattedPrice,
                  Icons.account_balance_wallet_rounded,
                ),
                ('طريقة الدفع', _booking.paymentMethod, Icons.payments_rounded),
                ('ملاحظات', _booking.notes, Icons.edit_note_rounded),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 18),
          color: AppColors.background,
          child: Row(
            children: [
              Expanded(
                child: GoldButton(
                  text: 'تعديل',
                  onPressed: _editBooking,
                  icon: Icons.edit_rounded,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: GoldButton(
                  text: 'إلغاء الحجز',
                  onPressed: _cancelBooking,
                  variant: GoldButtonVariant.danger,
                  icon: Icons.cancel_rounded,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ClientCard extends StatelessWidget {
  const _ClientCard({required this.booking});

  final AdminBookingModel booking;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.borderGold),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AppColors.primaryGold.withValues(alpha: 0.12),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.borderGold),
            ),
            child: const Icon(
              Icons.person_rounded,
              color: AppColors.primaryGold,
              size: 30,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(booking.clientName, style: AppTextStyles.cardTitle),
                const SizedBox(height: 4),
                Text(
                  booking.clientPhone,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.phone_rounded, color: AppColors.primaryGold),
        ],
      ),
    );
  }
}

class _DetailsCard extends StatelessWidget {
  const _DetailsCard({required this.rows});

  final List<(String, String, IconData)> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: List.generate(rows.length, (index) {
          final row = rows[index];
          return Padding(
            padding: EdgeInsets.only(bottom: index == rows.length - 1 ? 0 : 14),
            child: Row(
              children: [
                Icon(row.$3, color: AppColors.primaryGold, size: 20),
                const SizedBox(width: 10),
                Text(
                  '${row.$1}:',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    row.$2,
                    textAlign: TextAlign.left,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _BookingEditSheet extends StatefulWidget {
  const _BookingEditSheet({required this.booking});

  final AdminBookingModel booking;

  @override
  State<_BookingEditSheet> createState() => _BookingEditSheetState();
}

class _BookingEditSheetState extends State<_BookingEditSheet> {
  late String _status;
  late final TextEditingController _timeController;
  late final TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _status = widget.booking.status;
    _timeController = TextEditingController(text: widget.booking.time);
    _notesController = TextEditingController(text: widget.booking.notes);
  }

  @override
  void dispose() {
    _timeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _save() {
    Navigator.of(context).pop(
      widget.booking.copyWith(
        status: _status,
        time: _timeController.text,
        notes: _notesController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        18,
        20,
        MediaQuery.viewInsetsOf(context).bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('تعديل الحجز', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.lg),
          DropdownButtonFormField<String>(
            initialValue: _status,
            dropdownColor: AppColors.card2,
            decoration: const InputDecoration(labelText: 'الحالة'),
            items: const ['مؤكد', 'منتهي', 'ملغي']
                .map(
                  (status) =>
                      DropdownMenuItem(value: status, child: Text(status)),
                )
                .toList(),
            onChanged: (value) => setState(() => _status = value ?? _status),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _timeController,
            textAlign: TextAlign.right,
            style: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
            decoration: const InputDecoration(labelText: 'الوقت'),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _notesController,
            maxLines: 3,
            textAlign: TextAlign.right,
            style: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
            decoration: const InputDecoration(labelText: 'ملاحظات'),
          ),
          const SizedBox(height: AppSpacing.lg),
          GoldButton(text: 'حفظ', onPressed: _save, icon: Icons.save_rounded),
        ],
      ),
    );
  }
}
