import 'package:get/get.dart';
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
    String? refreshToken,
    String? email,
  }) async {
    _cachedToken = token;
    _lastActivityTime = DateTime.now();

    await Future.wait([
      _secureStorage.write(AppConstants.keyAuthToken, token),
      if (refreshToken != null)
        _secureStorage.write(AppConstants.keyRefreshToken, refreshToken),
      _prefs.setString(AppConstants.keyUserId, userId),
      if (email != null) _prefs.setString(AppConstants.keyUserEmail, email),
      _prefs.setBool(AppConstants.keyIsLoggedIn, true),
    ]);

    ApiClient.instance.setAuthToken(token);
    AppLogger.info('SessionManager', 'Session saved for userId: $userId');
  }

  Future<String?> getToken() async {
    if (_cachedToken != null) return _cachedToken;
    final token = await _secureStorage.read(AppConstants.keyAuthToken);
    _cachedToken = token;
    return token;
  }

  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(AppConstants.keyRefreshToken);
  }

  String? getUserId() => _prefs.getString(AppConstants.keyUserId);

  String? getUserEmail() => _prefs.getString(AppConstants.keyUserEmail);

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
      _secureStorage.delete(AppConstants.keyRefreshToken),
      _prefs.remove(AppConstants.keyUserId),
      _prefs.remove(AppConstants.keyUserEmail),
      _prefs.setBool(AppConstants.keyIsLoggedIn, false),
    ]);

    ApiClient.instance.clearAuthToken();
    AppLogger.info('SessionManager', 'Session cleared');
  }

  Future<void> logout() async {
    await clearSession();
    Get.offAllNamed('/login');
    AppLogger.info('SessionManager', 'User logged out');
  }
}
