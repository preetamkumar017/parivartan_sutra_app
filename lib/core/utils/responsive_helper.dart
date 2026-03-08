import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

class ResponsiveHelper {
  ResponsiveHelper._();

  static const double _mobileBreakpoint = 600;
  static const double _tabletBreakpoint = 1024;

  // ─── Device Type ─────────────────────────────────────────────────────────────

  static DeviceType deviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < _mobileBreakpoint) return DeviceType.mobile;
    if (width < _tabletBreakpoint) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  static bool isMobile(BuildContext context) =>
      deviceType(context) == DeviceType.mobile;

  static bool isTablet(BuildContext context) =>
      deviceType(context) == DeviceType.tablet;

  static bool isDesktop(BuildContext context) =>
      deviceType(context) == DeviceType.desktop;

  // ─── Screen Dimensions ───────────────────────────────────────────────────────

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double screenWidthPercent(BuildContext context, double percent) =>
      MediaQuery.of(context).size.width * (percent / 100);

  static double screenHeightPercent(BuildContext context, double percent) =>
      MediaQuery.of(context).size.height * (percent / 100);

  // ─── Safe Area ───────────────────────────────────────────────────────────────

  static EdgeInsets safeAreaPadding(BuildContext context) =>
      MediaQuery.of(context).padding;

  static double safeAreaTop(BuildContext context) =>
      MediaQuery.of(context).padding.top;

  static double safeAreaBottom(BuildContext context) =>
      MediaQuery.of(context).padding.bottom;

  // ─── Responsive Value ────────────────────────────────────────────────────────

  static T responsive<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final type = deviceType(context);
    switch (type) {
      case DeviceType.desktop:
        return desktop ?? tablet ?? mobile;
      case DeviceType.tablet:
        return tablet ?? mobile;
      case DeviceType.mobile:
        return mobile;
    }
  }

  // ─── Font Scale ──────────────────────────────────────────────────────────────

  static double textScaleFactor(BuildContext context) =>
      MediaQuery.of(context).textScaler.scale(1.0);

  // ─── Orientation ─────────────────────────────────────────────────────────────

  static bool isPortrait(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.portrait;

  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  // ─── Adaptive Padding ────────────────────────────────────────────────────────

  static EdgeInsets horizontalPadding(BuildContext context) {
    return responsive<EdgeInsets>(
      context,
      mobile: const EdgeInsets.symmetric(horizontal: 16),
      tablet: const EdgeInsets.symmetric(horizontal: 32),
      desktop: const EdgeInsets.symmetric(horizontal: 64),
    );
  }

  static EdgeInsets pagePadding(BuildContext context) {
    return responsive<EdgeInsets>(
      context,
      mobile: const EdgeInsets.all(16),
      tablet: const EdgeInsets.all(24),
      desktop: const EdgeInsets.all(32),
    );
  }

  // ─── Grid Columns ────────────────────────────────────────────────────────────

  static int gridColumns(BuildContext context) {
    return responsive<int>(
      context,
      mobile: 2,
      tablet: 3,
      desktop: 4,
    );
  }

  // ─── Keyboard ────────────────────────────────────────────────────────────────

  static bool isKeyboardOpen(BuildContext context) =>
      MediaQuery.of(context).viewInsets.bottom > 0;

  static double keyboardHeight(BuildContext context) =>
      MediaQuery.of(context).viewInsets.bottom;
}
