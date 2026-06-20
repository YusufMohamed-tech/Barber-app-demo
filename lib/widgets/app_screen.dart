import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({
    super.key,
    required this.child,
    this.scrollable = false,
    this.padding = const EdgeInsets.fromLTRB(20, 16, 20, 0),
    this.bottomPadding = 24,
  });

  final Widget child;
  final bool scrollable;
  final EdgeInsetsGeometry padding;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    final content = Padding(padding: padding, child: child);

    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: scrollable
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: bottomPadding + AppSpacing.lg),
                child: content,
              )
            : content,
      ),
    );
  }
}
