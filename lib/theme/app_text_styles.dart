import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract final class AppTextStyles {
  /// Scales type with screen width, clamped so web/desktop stay readable.
  static double sp(double fontSize) {
    try {
      return fontSize.sp.clamp(fontSize * 0.86, fontSize * 1.12);
    } catch (_) {
      return fontSize;
    }
  }

  static TextStyle heading({
    double fontSize = 40,
    FontWeight weight = FontWeight.w800,
    Color color = AppColors.textPrimary,
    double letterSpacing = -1.2,
    double? height,
  }) {
    return GoogleFonts.poppins(
      fontSize: sp(fontSize),
      fontWeight: weight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextStyle script({
    double fontSize = 36,
    Color color = AppColors.accent,
  }) {
    return GoogleFonts.caveat(
      fontSize: sp(fontSize),
      fontWeight: FontWeight.w600,
      color: color,
      height: 1,
    );
  }

  static TextStyle body({
    double fontSize = 16,
    FontWeight weight = FontWeight.w400,
    Color color = AppColors.textSecondary,
    double? height,
  }) {
    return GoogleFonts.inter(
      fontSize: sp(fontSize),
      fontWeight: weight,
      color: color,
      height: height ?? 1.65,
    );
  }

  static TextStyle mono({
    double fontSize = 12,
    FontWeight weight = FontWeight.w500,
    Color color = AppColors.textSecondary,
  }) {
    return GoogleFonts.jetBrainsMono(
      fontSize: sp(fontSize),
      fontWeight: weight,
      color: color,
    );
  }

  static TextStyle label({
    double fontSize = 14,
    FontWeight weight = FontWeight.w500,
    Color color = AppColors.textPrimary,
  }) {
    return GoogleFonts.inter(
      fontSize: sp(fontSize),
      fontWeight: weight,
      color: color,
    );
  }
}
