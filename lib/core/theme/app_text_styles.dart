import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Fonts match the Parent web portal's "Sprout" theme
/// (`../parivartan-sutra-new/public/assets/css/parent-theme.css`):
/// `--font-display: 'Baloo 2'` for display/headline/title styles,
/// `--font-body: 'Nunito Sans'` for everything else. Pulled via
/// `google_fonts` rather than bundled font assets — no local files needed.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle _display(TextStyle style) => GoogleFonts.baloo2(textStyle: style);
  static TextStyle _body(TextStyle style) => GoogleFonts.nunitoSans(textStyle: style);

  // Display
  static TextStyle get displayLarge => _display(const TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        height: 1.12,
      ));

  static TextStyle get displayMedium => _display(const TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.16,
      ));

  static TextStyle get displaySmall => _display(const TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.22,
      ));

  // Headline
  static TextStyle get headlineLarge => _display(const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        height: 1.25,
      ));

  static TextStyle get headlineMedium => _display(const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        height: 1.29,
      ));

  static TextStyle get headlineSmall => _display(const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.33,
      ));

  // Title
  static TextStyle get titleLarge => _display(const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.27,
      ));

  static TextStyle get titleMedium => _display(const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        height: 1.5,
      ));

  static TextStyle get titleSmall => _display(const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: 1.43,
      ));

  // Body
  static TextStyle get bodyLarge => _body(const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 1.5,
      ));

  static TextStyle get bodyMedium => _body(const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.43,
      ));

  static TextStyle get bodySmall => _body(const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.33,
      ));

  // Label
  static TextStyle get labelLarge => _body(const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
      ));

  static TextStyle get labelMedium => _body(const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.33,
      ));

  static TextStyle get labelSmall => _body(const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.45,
      ));

  // Button
  static TextStyle get button => _body(const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        height: 1.5,
      ));

  // Caption
  static TextStyle get caption => _body(const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: AppColors.textSecondaryLight,
      ));

  // Overline
  static TextStyle get overline => _body(const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.5,
      ));

  // Input
  static TextStyle get inputText => _body(const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ));

  static TextStyle get inputHint => _body(TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: AppColors.textHintLight,
      ));

  static TextStyle get inputLabel => _body(const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.4,
      ));

  static TextStyle get inputError => _body(TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: AppColors.error,
      ));
}
