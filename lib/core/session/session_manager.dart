import 'package:get/get.dart';
import '../../features/auth/services/auth_api_service.dart';
import '../constants/app_constants.dart';
import '../network/api_client.dart';
import '../services/secure_storage_service.dart';
import '../services/shared_prefs_service.dart';
import '../utils/app_logger.dart';

class SessionManager {
  SessionManager._();
  static final SessionManager instance = SessionManager._();

  final _secureStorage = SecureStorageService.instance;
  final _prefs = SharedPrefsService.instance;

  String? _cachedToken;
  DateTime? _lastActivityTime;

  // ─── Token Management ───────────────────────────────────────────────────────

  Future<void> saveSession({
    required String token,
    required String userId,
    required String role,
    String? mobile,
    String? email,
  }) async {
    _cachedToken = token;
    _lastActivityTime = DateTime.now();

    await Future.wait([
      _secureStorage.write(AppConstants.keyAuthToken, token),
      _prefs.setString(AppConstants.keyUserId, userId),
      _prefs.setString(AppConstants.keyUserRole, role),
      if (mobile != null) _prefs.setString(AppConstants.keyUserMobile, mobile),
      if (email != null) _prefs.setString(AppConstants.keyUserEmail, email),
      _prefs.setBool(AppConstants.keyIsLoggedIn, true),
    ]);

    ApiClient.instance.setAuthToken(token);
    AppLogger.info('SessionManager', 'Session saved for userId: $userId ($role)');
  }

  Future<String?> getToken() async {
    if (_cachedToken != null) return _cachedToken;
    final token = await _secureStorage.read(AppConstants.keyAuthToken);
    _cachedToken = token;
    return token;
  }

  String? getUserId() => _prefs.getString(AppConstants.keyUserId);

  String? getUserRole() => _prefs.getString(AppConstants.keyUserRole);

  String? getUserMobile() => _prefs.getString(AppConstants.keyUserMobile);

  String? getUserEmail() => _prefs.getString(AppConstants.keyUserEmail);

  bool isParent() => getUserRole() == 'parent';

  bool isLoggedIn() => _prefs.getBool(AppConstants.keyIsLoggedIn);

  // ─── Session Expiry ──────────────────────────────────────────────────────────

  void updateActivity() {
    _lastActivityTime = DateTime.now();
  }

  bool isSessionExpired() {
    if (_lastActivityTime == null) return false;
    final elapsed = DateTime.now().difference(_lastActivityTime!);
    return elapsed.inMinutes >= AppConstants.sessionTimeoutMinutes;
  }

  void checkSessionExpiry() {
    if (isLoggedIn() && isSessionExpired()) {
      AppLogger.warning('SessionManager', 'Session expired due to inactivity');
      expireSession();
    }
  }

  void expireSession() {
    clearSession();
    Get.offAllNamed('/login');
    Get.snackbar(
      'Session Expired',
      'Your session has expired. Please login again.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 4),
    );
  }

  // ─── Restore Session ─────────────────────────────────────────────────────────

  Future<bool> restoreSession() async {
    try {
      final token = await getToken();
      if (token != null && token.isNotEmpty && isLoggedIn()) {
        ApiClient.instance.setAuthToken(token);
        _lastActivityTime = DateTime.now();
        AppLogger.info('SessionManager', 'Session restored');
        return true;
      }
      return false;
    } catch (e) {
      AppLogger.error('SessionManager', 'Restore session error: $e');
      return false;
    }
  }

  // ─── Clear Session ───────────────────────────────────────────────────────────

  Future<void> clearSession() async {
    _cachedToken = null;
    _lastActivityTime = null;

    await Future.wait([
      _secureStorage.delete(AppConstants.keyAuthToken),
      _prefs.remove(AppConstants.keyUserId),
      _prefs.remove(AppConstants.keyUserRole),
      _prefs.remove(AppConstants.keyUserMobile),
      _prefs.remove(AppConstants.keyUserEmail),
      _prefs.setBool(AppConstants.keyIsLoggedIn, false),
    ]);

    ApiClient.instance.clearAuthToken();
    AppLogger.info('SessionManager', 'Session cleared');
  }

  Future<void> logout() async {
    try {
      await AuthApiService().logout();
    } catch (e) {
      AppLogger.warning('SessionManager', 'Server-side logout call failed: $e');
    }
    await clearSession();
    Get.offAllNamed('/login');
    AppLogger.info('SessionManager', 'User logged out');
  }
}
