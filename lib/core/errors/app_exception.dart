enum AppErrorType {
  network,
  unauthorized,
  forbidden,
  notFound,
  serverError,
  timeout,
  parseError,
  unknown,
  validation,
  sessionExpired,
  noInternet,
}

class AppException implements Exception {
  final String message;
  final AppErrorType type;
  final int? statusCode;
  final dynamic data;

  const AppException({
    required this.message,
    required this.type,
    this.statusCode,
    this.data,
  });

  factory AppException.network(String message) => AppException(
        message: message,
        type: AppErrorType.network,
      );

  factory AppException.unauthorized([String? message]) => AppException(
        message: message ?? 'Unauthorized. Please login again.',
        type: AppErrorType.unauthorized,
        statusCode: 401,
      );

  factory AppException.forbidden([String? message]) => AppException(
        message: message ?? 'Access denied.',
        type: AppErrorType.forbidden,
        statusCode: 403,
      );

  factory AppException.notFound([String? message]) => AppException(
        message: message ?? 'Resource not found.',
        type: AppErrorType.notFound,
        statusCode: 404,
      );

  factory AppException.serverError([String? message]) => AppException(
        message: message ?? 'Internal server error. Please try again later.',
        type: AppErrorType.serverError,
        statusCode: 500,
      );

  factory AppException.timeout() => const AppException(
        message: 'Request timed out. Please try again.',
        type: AppErrorType.timeout,
      );

  factory AppException.parseError([String? message]) => AppException(
        message: message ?? 'Failed to parse response.',
        type: AppErrorType.parseError,
      );

  factory AppException.noInternet() => const AppException(
        message: 'No internet connection.',
        type: AppErrorType.noInternet,
      );

  factory AppException.sessionExpired() => const AppException(
        message: 'Session expired. Please login again.',
        type: AppErrorType.sessionExpired,
      );

  factory AppException.validation(String message) => AppException(
        message: message,
        type: AppErrorType.validation,
      );

  factory AppException.unknown([String? message]) => AppException(
        message: message ?? 'Something went wrong.',
        type: AppErrorType.unknown,
      );

  factory AppException.fromStatusCode(int statusCode, [String? message]) {
    switch (statusCode) {
      case 400:
        return AppException(
          message: message ?? 'Bad request.',
          type: AppErrorType.validation,
          statusCode: statusCode,
        );
      case 401:
        return AppException.unauthorized(message);
      case 403:
        return AppException.forbidden(message);
      case 404:
        return AppException.notFound(message);
      case 408:
        return AppException.timeout();
      case >= 500:
        return AppException.serverError(message);
      default:
        return AppException.unknown(message);
    }
  }

  @override
  String toString() => 'AppException(type: $type, message: $message, statusCode: $statusCode)';
}
