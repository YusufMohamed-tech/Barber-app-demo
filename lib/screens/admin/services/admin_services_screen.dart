import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/admin_mock_data.dart';
import '../../../models/admin_service_model.dart';
import '../../../widgets/admin/admin_widgets.dart';
import '../../../widgets/app_header.dart';
import '../../../widgets/app_screen.dart';
import '../../../widgets/gold_button.dart';
import '../../auth/auth_widgets.dart';

class AdminServicesScreen extends StatefulWidget {
  const AdminServicesScreen({super.key});

  @override
  State<AdminServicesScreen> createState() => _AdminServicesScreenState();
}

class _AdminServicesScreenState extends State<AdminServicesScreen> {
  final _categories = const ['الكل', 'حلاقة', 'لحية', 'عناية', 'أخرى'];
  late List<AdminServiceModel> _services;
  String _activeCategory = 'الكل';
  String _query = '';

  @override
  void initState() {
    super.initState();
    _services = [...AdminMockData.services];
  }

  List<AdminServiceModel> get _visibleServices {
    return _services.where((service) {
      final query = _query.trim();
      final matchesQuery =
          query.isEmpty ||
          service.name.contains(query) ||
          service.category.contains(query);
      final matchesCategory =
          _activeCategory == 'الكل' || service.category == _activeCategory;
      return matchesQuery && matchesCategory;
    }).toList();
  }

  Future<void> _openForm([AdminServiceModel? service]) async {
    final result = await showModalBottomSheet<AdminServiceModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ServiceFormSheet(service: service),
    );

    if (result == null) return;
    setState(() {
      final index = _services.indexWhere((item) => item.id == result.id);
      if (index == -1) {
        _services.insert(0, result);
      } else {
        _services[index] = result;
      }
    });
    if (mounted) showArabicSnackBar(context, 'تم حفظ الخدمة بنجاح');
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      scrollable: true,
      bottomPadding: 112,
      child: Column(
        children: [
          const AppHeader(title: 'الخدمات'),
          const SizedBox(height: AppSpacing.lg),
          GoldButton(
            text: 'إضافة خدمة',
            onPressed: () => _openForm(),
            icon: Icons.add_circle_rounded,
            height: 48,
          ),
          const SizedBox(height: AppSpacing.lg),
          AdminSearchBar(
            hint: 'ابحث عن خدمة',
            onChanged: (value) => setState(() => _query = value),
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
                return AdminFilterChip(
                  label: category,
                  isActive: _activeCategory == category,
                  onTap: () => setState(() => _activeCategory = category),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _visibleServices.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final service = _visibleServices[index];
              return AdminServiceCard(
                service: service,
                onTap: () => _openForm(service),
                onEdit: () => _openForm(service),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ServiceFormSheet extends StatefulWidget {
  const _ServiceFormSheet({this.service});

  final AdminServiceModel? service;

  @override
  State<_ServiceFormSheet> createState() => _ServiceFormSheetState();
}

class _ServiceFormSheetState extends State<_ServiceFormSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _categoryController;
  late final TextEditingController _priceController;
  late final TextEditingController _durationController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _imageController;

  @override
  void initState() {
    super.initState();
    final service = widget.service;
    _nameController = TextEditingController(text: service?.name ?? '');
    _categoryController = TextEditingController(
      text: service?.category ?? 'حلاقة',
    );
    _priceController = TextEditingController(
      text: service?.price.toString() ?? '',
    );
    _durationController = TextEditingController(text: service?.duration ?? '');
    _descriptionController = TextEditingController(
      text: service?.description ?? '',
    );
    _imageController = TextEditingController(
      text:
          service?.imageUrl ??
          'https://images.unsplash.com/photo-1599351431202-1e0f0137899a?auto=format&fit=crop&w=600&q=85',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    _durationController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _save() {
    final service = AdminServiceModel(
      id:
          widget.service?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim().isEmpty
          ? 'خدمة جديدة'
          : _nameController.text.trim(),
      category: _categoryController.text.trim().isEmpty
          ? 'أخرى'
          : _categoryController.text.trim(),
      description: _descriptionController.text.trim(),
      duration: _durationController.text.trim().isEmpty
          ? '30 دقيقة'
          : _durationController.text.trim(),
      price: int.tryParse(_priceController.text.trim()) ?? 0,
      imageUrl: _imageController.text.trim(),
    );
    Navigator.of(context).pop(service);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.82,
      minChildSize: 0.55,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          padding: EdgeInsets.only(
            right: 20,
            left: 20,
            top: 16,
            bottom: MediaQuery.viewInsetsOf(context).bottom + 20,
          ),
          decoration: const BoxDecoration(
            color: AppColors.secondaryBackground,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: ListView(
            controller: scrollController,
            children: [
              Center(
                child: Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                widget.service == null ? 'إضافة خدمة' : 'تعديل الخدمة',
                textAlign: TextAlign.center,
                style: AppTextStyles.sectionTitle,
              ),
              const SizedBox(height: AppSpacing.xl),
              _SheetField(controller: _nameController, label: 'اسم الخدمة'),
              _SheetField(controller: _categoryController, label: 'التصنيف'),
              _SheetField(
                controller: _priceController,
                label: 'السعر',
                keyboardType: TextInputType.number,
              ),
              _SheetField(controller: _durationController, label: 'المدة'),
              _SheetField(
                controller: _descriptionController,
                label: 'الوصف',
                maxLines: 3,
              ),
              _SheetField(
                controller: _imageController,
                label: 'رابط الصورة / صورة وهمية',
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: GoldButton(
                      text: 'حفظ',
                      onPressed: _save,
                      icon: Icons.save_rounded,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: GoldButton(
                      text: 'إلغاء',
                      variant: GoldButtonVariant.outlined,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SheetField extends StatelessWidget {
  const _SheetField({
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
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        textAlign: TextAlign.right,
        style: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
