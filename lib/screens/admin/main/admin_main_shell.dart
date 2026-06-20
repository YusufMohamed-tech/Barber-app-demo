import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../widgets/admin/admin_widgets.dart';
import '../barbers/admin_barbers_screen.dart';
import '../bookings/admin_bookings_screen.dart';
import '../dashboard/admin_dashboard_screen.dart';
import '../reports/admin_reports_screen.dart';
import '../services/admin_services_screen.dart';
import '../settings/admin_settings_screen.dart';

class AdminMainShell extends StatefulWidget {
  const AdminMainShell({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<AdminMainShell> createState() => _AdminMainShellState();
}

class _AdminMainShellState extends State<AdminMainShell> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _selectTab(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          AdminDashboardScreen(onTabSelected: _selectTab),
          const AdminBarbersScreen(),
          const AdminServicesScreen(),
          const AdminBookingsScreen(),
          const AdminReportsScreen(),
          const AdminSettingsScreen(),
        ],
      ),
      bottomNavigationBar: AdminBottomNav(
        currentIndex: _selectedIndex,
        onTap: _selectTab,
      ),
    );
  }
}
