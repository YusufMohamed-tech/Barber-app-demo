import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/admin_mock_data.dart';
import '../../../models/admin_client_model.dart';
import '../../../widgets/admin/admin_widgets.dart';
import '../../../widgets/app_header.dart';
import '../../../widgets/app_screen.dart';

class AdminClientsScreen extends StatefulWidget {
  const AdminClientsScreen({super.key});

  @override
  State<AdminClientsScreen> createState() => _AdminClientsScreenState();
}

class _AdminClientsScreenState extends State<AdminClientsScreen> {
  String _query = '';

  List<AdminClientModel> get _clients {
    final query = _query.trim();
    if (query.isEmpty) return AdminMockData.clients;
    return AdminMockData.clients
        .where(
          (client) =>
              client.name.contains(query) || client.phone.contains(query),
        )
        .toList();
  }

  void _showClientDetails(AdminClientModel client) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: AppColors.secondaryBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AdminAvatar(imageUrl: client.imageUrl, size: 86),
            const SizedBox(height: AppSpacing.md),
            Text(client.name, style: AppTextStyles.sectionTitle),
            const SizedBox(height: AppSpacing.sm),
            Text(client.phone, style: AppTextStyles.body),
            const SizedBox(height: AppSpacing.xl),
            _ClientInfoRow(
              label: 'عدد الحجوزات',
              value: '${client.bookingsCount} حجز',
            ),
            _ClientInfoRow(label: 'آخر حجز', value: client.lastBooking),
            _ClientInfoRow(
              label: 'الخدمة المفضلة',
              value: client.favoriteService,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: AppScreen(
        scrollable: true,
        bottomPadding: 24,
        child: Column(
          children: [
            const AppHeader(title: 'العملاء', showBack: true),
            const SizedBox(height: AppSpacing.lg),
            AdminSearchBar(
              hint: 'ابحث عن عميل',
              onChanged: (value) => setState(() => _query = value),
            ),
            const SizedBox(height: AppSpacing.xl),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _clients.length,
              separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, index) {
                final client = _clients[index];
                return AdminClientCard(
                  client: client,
                  onTap: () => _showClientDetails(client),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ClientInfoRow extends StatelessWidget {
  const _ClientInfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(
            label,
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
          ),
          const Spacer(),
          Text(
            value,
            style: AppTextStyles.body.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
