import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Palette (Brand)
  static const Color primary = Color(0xFF004DA0);
  static const Color primaryLight = Color(0xFF3A75C4);
  static const Color primaryDark = Color(0xFF003A7A);

  // Secondary Palette
  static const Color secondary = Color(0xFF64D2E5);
  static const Color secondaryLight = Color(0xFF9FE6F1);
  static const Color secondaryDark = Color(0xFF2FB4C9);

  // Accent
  static const Color accent = Color(0xFF22C55E);
  static const Color accentLight = Color(0xFF86EFAC);
  static const Color accentDark = Color(0xFF15803D);

  // Neutral - Light Mode
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF8FAFC);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color dividerLight = Color(0xFFE2E8F0);

  // Neutral - Dark Mode
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color cardDark = Color(0xFF2A2A2A);
  static const Color dividerDark = Color(0xFF3A3A3A);

  // Text - Light Mode
  static const Color textPrimaryLight = Color(0xFF1E293B);
  static const Color textSecondaryLight = Color(0xFF64748B);
  static const Color textHintLight = Color(0xFF94A3B8);
  static const Color textDisabledLight = Color(0xFFCBD5E1);

  // Text - Dark Mode
  static const Color textPrimaryDark = Color(0xFFF1F5F9);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color textHintDark = Color(0xFF64748B);
  static const Color textDisabledDark = Color(0xFF475569);

  // Status Colors
  static const Color success = Color(0xFF22C55E);
  static const Color successLight = Color(0xFFDCFCE7);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color info = Color(0xFF64D2E5);
  static const Color infoLight = Color(0xFFE0F7FA);

  // Input Fields
  static const Color inputFillLight = Color(0xFFF8FAFC);
  static const Color inputFillDark = Color(0xFF2A2A2A);
  static const Color inputBorderLight = Color(0xFFE2E8F0);
  static const Color inputBorderDark = Color(0xFF3D3D3D);
  static const Color inputFocusBorder = primary;

  // Button
  static const Color buttonPrimary = primary;
  static const Color buttonSecondary = secondary;
  static const Color buttonDisabled = Color(0xFFCBD5E1);
  static const Color buttonTextLight = Color(0xFFFFFFFF);
  static const Color buttonTextDark = Color(0xFFFFFFFF);

  // Overlay
  static const Color overlayLight = Color(0x66000000);
  static const Color overlayDark = Color(0xB3000000);

  // Transparent
  static const Color transparent = Colors.transparent;
  static const Color white = Colors.white;
  static const Color black = Colors.black;
}