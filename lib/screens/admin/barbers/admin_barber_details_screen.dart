import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/admin_mock_data.dart';
import '../../../models/admin_barber_model.dart';
import '../../../widgets/admin/admin_widgets.dart';
import '../../../widgets/app_header.dart';
import '../../../widgets/app_screen.dart';
import '../../../widgets/gold_button.dart';
import '../../auth/auth_widgets.dart';

class AdminBarberDetailsScreen extends StatefulWidget {
  const AdminBarberDetailsScreen({super.key, this.barber});

  final AdminBarberModel? barber;

  @override
  State<AdminBarberDetailsScreen> createState() =>
      _AdminBarberDetailsScreenState();
}

class _AdminBarberDetailsScreenState extends State<AdminBarberDetailsScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _specialtyController;
  late final TextEditingController _phoneController;
  late final TextEditingController _ratingController;
  late final TextEditingController _bioController;
  late bool _active;

  AdminBarberModel get _barber => widget.barber ?? AdminMockData.barbers.first;

  @override
  void initState() {
    super.initState();
    final barber = widget.barber;
    _nameController = TextEditingController(text: barber?.name ?? '');
    _specialtyController = TextEditingController(text: barber?.specialty ?? '');
    _phoneController = TextEditingController(text: barber?.phone ?? '');
    _ratingController = TextEditingController(
      text: barber?.rating.toStringAsFixed(1) ?? '4.8',
    );
    _bioController = TextEditingController(
      text:
          barber?.bio ??
          'خبير حلاقة بخبرة تزيد عن 6 سنوات في جميع أنواع الحلاقة الكلاسيكية والحديثة.',
    );
    _active = barber?.isActive ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _specialtyController.dispose();
    _phoneController.dispose();
    _ratingController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _save() {
    showArabicSnackBar(context, 'تم حفظ التغييرات بنجاح');
  }

  Future<void> _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.card,
        title: Text('حذف الحلاق', style: AppTextStyles.sectionTitle),
        content: Text(
          'هل أنت متأكد من حذف هذا الحلاق؟',
          style: AppTextStyles.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'حذف',
              style: TextStyle(color: AppColors.dangerRed),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      showArabicSnackBar(context, 'تم حذف الحلاق بنجاح');
      Navigator.of(context).maybePop();
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
            const AppHeader(title: 'تفاصيل الحلاق', showBack: true),
            const SizedBox(height: AppSpacing.lg),
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                AdminAvatar(imageUrl: _barber.imageUrl, size: 106),
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppColors.primaryGold,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.background, width: 2),
                  ),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    color: AppColors.background,
                    size: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              _nameController.text.isEmpty ? 'حلاق جديد' : _nameController.text,
              style: AppTextStyles.sectionTitle,
            ),
            const SizedBox(height: AppSpacing.xl),
            _DetailsCard(
              children: [
                _AdminField(controller: _nameController, label: 'الاسم'),
                _AdminField(controller: _specialtyController, label: 'التخصص'),
                _AdminField(
                  controller: _phoneController,
                  label: 'رقم الهاتف',
                  keyboardType: TextInputType.phone,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.card2,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'الحالة',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        _active ? 'نشط' : 'غير نشط',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Switch(
                        value: _active,
                        activeThumbColor: AppColors.primaryGold,
                        onChanged: (value) => setState(() => _active = value),
                      ),
                    ],
                  ),
                ),
                _AdminField(
                  controller: _ratingController,
                  label: 'التقييم',
                  keyboardType: TextInputType.number,
                ),
                _RatingPreview(
                  value: double.tryParse(_ratingController.text) ?? 4.8,
                ),
                _AdminField(
                  controller: _bioController,
                  label: 'نبذة',
                  maxLines: 4,
                ),
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
                  text: 'حفظ التغييرات',
                  onPressed: _save,
                  icon: Icons.save_rounded,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: GoldButton(
                  text: 'حذف الحلاق',
                  onPressed: _confirmDelete,
                  variant: GoldButtonVariant.danger,
                  icon: Icons.delete_rounded,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailsCard extends StatelessWidget {
  const _DetailsCard({required this.children});

  final List<Widget> children;

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
        children: List.generate(children.length, (index) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: index == children.length - 1 ? 0 : 12,
            ),
            child: children[index],
          );
        }),
      ),
    );
  }
}

class _AdminField extends StatelessWidget {
  const _AdminField({
    required this.controller,
    required this.label,
    this.maxLines = 1,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String label;
  final int maxLines;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textAlign: TextAlign.right,
      style: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
      decoration: InputDecoration(labelText: label),
    );
  }
}

class _RatingPreview extends StatelessWidget {
  const _RatingPreview({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'التقييم',
          style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
        ),
        const Spacer(),
        ...List.generate(
          5,
          (index) => Icon(
            index < value.round()
                ? Icons.star_rounded
                : Icons.star_border_rounded,
            color: AppColors.primaryGold,
            size: 22,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value.toStringAsFixed(1),
          style: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
        ),
      ],
    );
  }
}
