import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  const AppTextStyles._();

  static TextStyle get largeTitle => GoogleFonts.cairo(
    fontSize: 30,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    height: 1.25,
  );

  static TextStyle get screenTitle => GoogleFonts.cairo(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static TextStyle get sectionTitle => GoogleFonts.cairo(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static TextStyle get cardTitle => GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static TextStyle get body => GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static TextStyle get caption => GoogleFonts.cairo(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.mutedText,
  );

  static TextStyle get button => GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    color: AppColors.background,
  );
}
