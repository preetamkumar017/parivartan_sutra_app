import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import '../errors/app_exception.dart';
import '../utils/app_logger.dart';

class ErrorHandler {
  ErrorHandler._();

  static AppException handle(dynamic error) {
    AppLogger.error('ErrorHandler', error.toString());

    if (error is AppException) return error;

    if (error is SocketException) {
      return AppException.noInternet();
    }

    if (error is TimeoutException) {
      return AppException.timeout();
    }

    if (error is FormatException) {
      return AppException.parseError(error.message);
    }

    if (error is HttpException) {
      return AppException.network(error.message);
    }

    return AppException.unknown(error?.toString());
  }

  static void showError(AppException exception) {
    AppLogger.error('AppError', exception.toString());

    if (exception.type == AppErrorType.sessionExpired ||
        exception.type == AppErrorType.unauthorized) {
      _handleSessionExpiry();
      return;
    }

    Get.snackbar(
      _getErrorTitle(exception.type),
      exception.message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }

  static void _handleSessionExpiry() {
    Get.offAllNamed('/login');
    Get.snackbar(
      'Session Expired',
      'Please login again to continue.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }

  static String _getErrorTitle(AppErrorType type) {
    switch (type) {
      case AppErrorType.network:
      case AppErrorType.noInternet:
        return 'Network Error';
      case AppErrorType.unauthorized:
      case AppErrorType.sessionExpired:
        return 'Authentication Error';
      case AppErrorType.forbidden:
        return 'Access Denied';
      case AppErrorType.notFound:
        return 'Not Found';
      case AppErrorType.serverError:
        return 'Server Error';
      case AppErrorType.timeout:
        return 'Timeout';
      case AppErrorType.parseError:
        return 'Data Error';
      case AppErrorType.validation:
        return 'Validation Error';
      case AppErrorType.unknown:
        return 'Error';
    }
  }
}
