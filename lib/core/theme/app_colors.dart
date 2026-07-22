import 'package:flutter/material.dart';

/// Colors match the Parent web portal's "Sprout" theme
/// (`../parivartan-sutra-new/public/assets/css/parent-theme.css`) so the
/// mobile app and web portal share one brand identity. Field names kept
/// as-is (primary/secondary/accent/etc.) for drop-in compatibility with
/// existing usages — only the values changed.
class AppColors {
  AppColors._();

  // Primary Palette (Brand) — Sprout teal (--ps-sprout)
  static const Color primary = Color(0xFF1FB8BE);
  // `primaryLight` is used throughout as a legible border/gradient/foreground
  // tint (not a background wash), so it's a lightened *teal* rather than the
  // web's near-white `--ps-sprout-light` — that pale tint is kept separately
  // below as `primarySurface` for badge/hover backgrounds.
  static const Color primaryLight = Color(0xFF6FD3D8);
  static const Color primaryDark = Color(0xFF158387); // --ps-sprout-dark
  static const Color primarySurface = Color(0xFFE1F7F8); // --ps-sprout-light

  // Secondary Palette — Kite blue (--ps-kite)
  static const Color secondary = Color(0xFF0B4DA2);
  static const Color secondaryLight = Color(0xFFE5EDF9); // --ps-kite-light
  static const Color secondaryDark = Color(0xFF083A7A);

  // Accent — Marigold (--ps-marigold)
  static const Color accent = Color(0xFFF5A623);
  static const Color accentLight = Color(0xFFFDEDD3); // --ps-marigold-light
  static const Color accentDark = Color(0xFFC77E0E); // --ps-marigold-dark

  // Additional Sprout accent — Blossom (--ps-blossom). Doubles as this
  // app's `error`/attention color below, since Sprout doesn't define a
  // separate red.
  static const Color blossom = Color(0xFFE8637A);
  static const Color blossomLight = Color(0xFFFCE6EA);

  // Neutral - Light Mode
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF5FAFB); // --ps-cloud
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color dividerLight = Color(0xFFDCEBEC); // --ps-border

  // Neutral - Dark Mode
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color cardDark = Color(0xFF2A2A2A);
  static const Color dividerDark = Color(0xFF3A3A3A);

  // Text - Light Mode — Ink / Ink-soft (--ps-ink / --ps-ink-soft)
  static const Color textPrimaryLight = Color(0xFF4A4A4A);
  static const Color textSecondaryLight = Color(0xFF7A7A7A);
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
  static const Color error = blossom; // --ps-blossom
  static const Color errorLight = blossomLight; // --ps-blossom-light
  static const Color info = secondary;
  static const Color infoLight = secondaryLight;

  // Input Fields
  static const Color inputFillLight = Color(0xFFF5FAFB); // --ps-cloud
  static const Color inputFillDark = Color(0xFF2A2A2A);
  static const Color inputBorderLight = Color(0xFFDCEBEC); // --ps-border
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