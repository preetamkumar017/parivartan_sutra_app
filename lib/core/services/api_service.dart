import '../errors/app_exception.dart';
import '../errors/error_handler.dart';
import '../network/api_client.dart';
import '../network/api_response.dart';
import '../utils/app_logger.dart';

abstract class ApiService {
  final ApiClient _client = ApiClient.instance;

  Future<ApiResponse<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      return await _client.get<T>(
        endpoint,
        queryParams: queryParams,
        headers: headers,
        fromJson: fromJson,
      );
    } catch (e) {
      final exception = ErrorHandler.handle(e);
      AppLogger.error(runtimeType.toString(), 'GET $endpoint failed: $exception');
      throw exception;
    }
  }

  Future<ApiResponse<T>> post<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      return await _client.post<T>(
        endpoint,
        body: body,
        headers: headers,
        fromJson: fromJson,
      );
    } catch (e) {
      final exception = ErrorHandler.handle(e);
      AppLogger.error(runtimeType.toString(), 'POST $endpoint failed: $exception');
      throw exception;
    }
  }

  Future<ApiResponse<T>> put<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      return await _client.put<T>(
        endpoint,
        body: body,
        headers: headers,
        fromJson: fromJson,
      );
    } catch (e) {
      final exception = ErrorHandler.handle(e);
      AppLogger.error(runtimeType.toString(), 'PUT $endpoint failed: $exception');
      throw exception;
    }
  }

  Future<ApiResponse<T>> patch<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      return await _client.patch<T>(
        endpoint,
        body: body,
        headers: headers,
        fromJson: fromJson,
      );
    } catch (e) {
      final exception = ErrorHandler.handle(e);
      AppLogger.error(runtimeType.toString(), 'PATCH $endpoint failed: $exception');
      throw exception;
    }
  }

  Future<ApiResponse<T>> delete<T>(
    String endpoint, {
    Map<String, String>? headers,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      return await _client.delete<T>(
        endpoint,
        headers: headers,
        fromJson: fromJson,
      );
    } catch (e) {
      final exception = ErrorHandler.handle(e);
      AppLogger.error(runtimeType.toString(), 'DELETE $endpoint failed: $exception');
      throw exception;
    }
  }

  void handleError(AppException exception, {bool showSnackbar = true}) {
    if (showSnackbar) {
      ErrorHandler.showError(exception);
    }
  }
}
