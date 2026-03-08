import 'package:flutter/foundation.dart';
import '../../core/config/env_config.dart';

class AppLogger {
  AppLogger._();

  static bool get _canLog => kDebugMode && EnvConfig.instance.enableLogging;

  static void info(String tag, String message) {
    if (_canLog) {
      debugPrint('ℹ️ [INFO] [$tag] $message');
    }
  }

  static void debug(String tag, String message) {
    if (_canLog) {
      debugPrint('🐛 [DEBUG] [$tag] $message');
    }
  }

  static void warning(String tag, String message) {
    if (_canLog) {
      debugPrint('⚠️ [WARN] [$tag] $message');
    }
  }

  static void error(String tag, String message, [StackTrace? stackTrace]) {
    if (_canLog) {
      debugPrint('❌ [ERROR] [$tag] $message');
      if (stackTrace != null) {
        debugPrint('📋 [STACK] $stackTrace');
      }
    }
  }

  static void success(String tag, String message) {
    if (_canLog) {
      debugPrint('✅ [SUCCESS] [$tag] $message');
    }
  }

  static void request(String method, String url, {Map<String, dynamic>? body}) {
    if (_canLog) {
      debugPrint('🌐 [REQUEST] $method $url');
      if (body != null) {
        debugPrint('📤 [BODY] $body');
      }
    }
  }

  static void response(int statusCode, String url, {dynamic body}) {
    if (_canLog) {
      debugPrint('📥 [RESPONSE] $statusCode $url');
      if (body != null) {
        debugPrint('📦 [DATA] $body');
      }
    }
  }
}
