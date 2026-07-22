/// Mirrors `../parivartan-sutra-new/app/Config/Routes.php`'s `api` group
/// and its CLAUDE.md's "Mobile API" section exactly — no speculative paths.
class ApiEndpoints {
  ApiEndpoints._();

  // ── Auth ──────────────────────────────────────────────────────────────────
  static const String login = 'login';
  static const String logout = 'logout';

  // ── Interview (any authenticated role) ───────────────────────────────────
  static const String interviewStatus = 'interview/status';
  static const String interviewStart = 'interview/start';
  static const String interviewQuestions = 'interview/questions';
  static const String interviewSubmit = 'interview/submit';
  static const String interviewResult = 'interview/result';

  // ── Strategy ──────────────────────────────────────────────────────────────
  static const String strategyAssigned = 'strategy/assigned';
  static const String parentStrategyOrder = 'parent/strategy/order';
  static const String parentStrategyVerify = 'parent/strategy/verify';

  // ── Parent-only ───────────────────────────────────────────────────────────
  static const String parentChildren = 'parent/children';
  static String parentCreateChildLogin(int childId) =>
      'parent/children/$childId/create-login';
  static const String parentDashboard = 'parent/dashboard';

  // ── Student-only ──────────────────────────────────────────────────────────
  static const String studentDashboard = 'student/dashboard';
}
