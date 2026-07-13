import 'package:flutter/material.dart';

/// Single source of truth for the app's colors.
class AppColors {
  AppColors._();

  // Backgrounds & surfaces
  static const Color background = Color(0xFF0F172A);
  static const Color surface = Color(0xFF1B2536); // cards, dialogs, sheets, menus
  static const Color surfaceHigh = Color(0xFF0B1527); // elevated / nested surfaces

  // Brand
  static const Color primary = Color(0xFFF6C344); // gold accent
  static const Color onPrimary = Colors.black;
  static const Color danger = Color(0xFFE50914); // remove / primary CTA red
  static const Color tv = Colors.purpleAccent; // TV badge

  // Text
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.white70;
  static const Color textMuted = Colors.white54;
  static const Color textFaint = Colors.white38;

  // Lines & fills
  static const Color border = Color(0x1FFFFFFF); // white ~12%
  static const Color divider = Color(0x1FFFFFFF);
  static const Color fill = Color(0x0FFFFFFF); // white ~6%
}
