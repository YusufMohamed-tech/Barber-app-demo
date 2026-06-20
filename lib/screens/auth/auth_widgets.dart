import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({super.key, required this.child, this.showLogo = true});

  final Widget child;
  final bool showLogo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.secondaryBackground,
              AppColors.background,
              AppColors.background,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(22, 24, 22, 28),
            child: Column(
              children: [
                if (showLogo) ...[
                  const AuthLogo(),
                  const SizedBox(height: AppSpacing.xxl),
                ],
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key, this.size = 122});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size,
          height: size,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: AppColors.borderGold),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryGold.withValues(alpha: 0.18),
                blurRadius: 28,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(AppAssets.appLogo, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'صالون الحلاقة',
          textAlign: TextAlign.center,
          style: AppTextStyles.screenTitle.copyWith(
            color: AppColors.primaryGold,
          ),
        ),
      ],
    );
  }
}

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.icon,
    this.validator,
    this.keyboardType,
    this.isPassword = false,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final IconData? icon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isPassword;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword && _obscure,
      textAlign: TextAlign.right,
      style: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        prefixIcon: widget.icon == null
            ? null
            : Icon(widget.icon, color: AppColors.primaryGold),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () => setState(() => _obscure = !_obscure),
                icon: Icon(
                  _obscure
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  color: AppColors.mutedText,
                ),
              )
            : null,
      ),
    );
  }
}

class AuthCard extends StatelessWidget {
  const AuthCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.divider),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.24),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: child,
    );
  }
}

void showArabicSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.right,
        style: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
      ),
      backgroundColor: AppColors.card2,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
