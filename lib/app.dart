import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'screens/auth/splash_loading_screen.dart';

class BarberApp extends StatelessWidget {
  const BarberApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'صالون الحلاقة',
        theme: AppTheme.darkTheme,
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child ?? const SizedBox.shrink(),
          );
        },
        home: const SplashLoadingScreen(),
      ),
    );
  }
}
