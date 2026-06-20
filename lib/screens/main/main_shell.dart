import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../widgets/custom_bottom_nav.dart';
import '../appointments/appointments_screen.dart';
import '../barbers/barbers_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import '../services/services_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
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
          HomeScreen(onTabSelected: _selectTab),
          const ServicesScreen(),
          const BarbersScreen(),
          const AppointmentsScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedIndex,
        onTap: _selectTab,
      ),
    );
  }
}
