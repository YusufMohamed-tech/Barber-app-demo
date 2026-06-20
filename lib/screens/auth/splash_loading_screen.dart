import 'package:flutter/material.dart';

import '../../core/services/local_auth_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../admin/main/admin_main_shell.dart';
import '../main/main_shell.dart';
import 'auth_widgets.dart';
import 'role_selection_screen.dart';

class SplashLoadingScreen extends StatefulWidget {
  const SplashLoadingScreen({super.key});

  @override
  State<SplashLoadingScreen> createState() => _SplashLoadingScreenState();
}

class _SplashLoadingScreenState extends State<SplashLoadingScreen> {
  final _authService = const LocalAuthService();

  @override
  void initState() {
    super.initState();
    _routeUser();
  }

  Future<void> _routeUser() async {
    await Future<void>.delayed(const Duration(milliseconds: 650));
    final loggedIn = await _authService.isLoggedIn();
    final role = await _authService.getUserRole();

    if (!mounted) return;

    Widget destination;
    if (loggedIn && role == LocalAuthService.adminRole) {
      destination = const AdminMainShell();
    } else if (loggedIn && role == LocalAuthService.clientRole) {
      destination = const MainShell();
    } else {
      destination = const RoleSelectionScreen();
    }

    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => destination));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AuthLogo(size: 136),
              const SizedBox(height: AppSpacing.xxl),
              const CircularProgressIndicator(
                color: AppColors.primaryGold,
                strokeWidth: 2.4,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('جاري التحميل...', style: AppTextStyles.body),
            ],
          ),
        ),
      ),
    );
  }
}
