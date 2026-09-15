import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color background = Color(0xFF07070A);
  static const Color surface = Color(0xFF121218);
  static const Color card = Color(0xFF17171F);
  static const Color border = Color(0xFF2A2A35);
  static const Color accent = Color(0xFFF5C542);
  static const Color accentWarm = Color(0xFFFF8A4C);
  static const Color accentPink = Color(0xFFE85D9A);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0BC);

  static const LinearGradient statGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [accentPink, accentWarm, accent],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF23232E), Color(0xFF15151C)],
  );
}
