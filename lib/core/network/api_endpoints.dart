class ApiEndpoints {
  ApiEndpoints._();

  // ── Auth ──────────────────────────────────────────────────────────────────
  static const String login        = '/auth/login';
  static const String studentLogin = '/auth/student-login';
  static const String sendOtp      = '/auth/send-otp';
  static const String verifyOtp    = '/auth/verify-otp';
  static const String refreshToken = '/auth/refresh';
  static const String logout       = '/auth/logout';
  static const String register     = '/auth/register';

  // ── User ──────────────────────────────────────────────────────────────────
  static const String userProfile   = '/user/profile';
  static const String updateProfile = '/user/profile/update';

  // ── Children ──────────────────────────────────────────────────────────────
  static const String children   = '/child';
  static String childById(int id) => '/child/$id';

  // ── Assessment ────────────────────────────────────────────────────────────
  static String parentTestStart(int childId) => '/test/parent/start/$childId';
  static const String parentTestSubmit  = '/test/parent/submit';
  static const String studentTestStart  = '/test/student/start';
  static const String studentTestSubmit = '/test/student/submit';

  // ── Strategy ──────────────────────────────────────────────────────────────
  static String strategyPreview(int childId)   => '/strategy/preview/$childId';
  static String strategyDashboard(int childId) => '/strategy/dashboard/$childId';

  // ── Home ──────────────────────────────────────────────────────────────────
  static const String dashboard = '/dashboard';
}
