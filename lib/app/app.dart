import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/constants/app_constants.dart';
import '../core/localization/app_translations.dart';
import '../core/services/shared_prefs_service.dart';
import '../core/theme/app_theme.dart';
import 'bindings/initial_binding.dart';
import 'routes/app_pages.dart';

class App extends StatelessWidget {
  final String initialRoute;
  const App({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    final prefs = SharedPrefsService.instance;

    // Restore saved theme
    final savedTheme = prefs.getString(AppConstants.keyThemeMode);
    final themeMode = savedTheme == 'dark'
        ? ThemeMode.dark
        : savedTheme == 'light'
            ? ThemeMode.light
            : ThemeMode.system;

    // Restore saved locale
    final langCode = prefs.getString(
      AppConstants.keyLanguageCode,
      defaultValue: 'en',
    )!;
    final countryCode = prefs.getString(
      AppConstants.keyCountryCode,
      defaultValue: 'US',
    )!;

    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,

      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      // Localization
      translations: AppTranslations(),
      locale: Locale(langCode, countryCode),
      fallbackLocale: AppTranslations.fallbackLocale,

      // Navigation
      initialRoute: initialRoute,
      getPages: AppPages.pages,
      initialBinding: InitialBinding(),

      // Default transitions
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),

      // Global snackbar position
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling,
          ),
          child: child!,
        );
      },
    );
  }
}
