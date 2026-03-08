import 'dart:ui' show Locale;
import 'package:get/get.dart';
import 'en_US.dart';
import 'hi_IN.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'hi_IN': hiIN,
      };

  static const Locale defaultLocale = Locale('en', 'US');
  static const Locale fallbackLocale = Locale('en', 'US');

  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('hi', 'IN'),
  ];

  static const List<Map<String, String>> supportedLanguages = [
    {'code': 'en', 'country': 'US', 'name': 'English', 'nativeName': 'English'},
    {'code': 'hi', 'country': 'IN', 'name': 'Hindi', 'nativeName': 'हिन्दी'},
  ];

  static void changeLanguage(String langCode, String countryCode) {
    final locale = Locale(langCode, countryCode);
    Get.updateLocale(locale);
  }
}
