class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Parivartan Sutra';
  static const String appVersion = '1.0.0';

  // Storage Keys
  static const String keyAuthToken = 'auth_token';
  static const String keyUserId = 'user_id';
  static const String keyUserEmail = 'user_email';
  static const String keyUserMobile = 'user_mobile';
  static const String keyUserRole = 'user_role';
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguageCode = 'language_code';
  static const String keyCountryCode = 'country_code';
  static const String keyOnboardingDone = 'onboarding_done';

  // Network
  static const int connectTimeoutMs = 30000;
  static const int receiveTimeoutMs = 30000;
  static const String contentTypeJson = 'application/json';
  static const String authorizationHeader = 'Authorization';
  static const String bearerPrefix = 'Bearer ';

  // Pagination
  static const int defaultPageSize = 20;
  static const int defaultPage = 1;

  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 32;
  static const int minNameLength = 2;
  static const int maxNameLength = 50;
  static const int otpLength = 6;
  static const int phoneLength = 10;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);

  // Snackbar
  static const Duration snackbarDuration = Duration(seconds: 3);

  // Session
  static const int sessionTimeoutMinutes = 30;
}
