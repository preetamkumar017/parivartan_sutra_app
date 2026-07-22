import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../config/env_config.dart';
import '../constants/app_constants.dart';
import '../errors/app_exception.dart';
import '../utils/app_logger.dart';
import '../network/api_response.dart';

class ApiClient {
  ApiClient._();
  static final ApiClient instance = ApiClient._();

  final http.Client _client = http.Client();

  String? _authToken;

  void setAuthToken(String token) {
    _authToken = token;
    AppLogger.debug('ApiClient', 'Auth token set');
  }

  void clearAuthToken() {
    _authToken = null;
    AppLogger.debug('ApiClient', 'Auth token cleared');
  }

  Map<String, String> _buildHeaders({Map<String, String>? extra}) {
    // No explicit Content-Type here: the backend reads bodies via
    // CodeIgniter's `getPost()` everywhere (confirmed across AuthController,
    // ParentController, InterviewController, StrategyController), which means
    // every request body must be `application/x-www-form-urlencoded`, not
    // JSON. `http.Client` sets that header itself when `body` is a
    // `Map<String, String>` (see post/put/patch below) — setting it here too
    // would just duplicate it.
    final headers = <String, String>{
      'Accept': AppConstants.contentTypeJson,
    };
    if (_authToken != null && _authToken!.isNotEmpty) {
      headers[AppConstants.authorizationHeader] =
          '${AppConstants.bearerPrefix}$_authToken';
    }
    if (extra != null) headers.addAll(extra);
    return headers;
  }

  /// Converts a JSON-shaped body into form fields the backend's `getPost()`
  /// can read. `null` values are dropped so optional params (e.g. `device`)
  /// aren't sent as the literal string `"null"`.
  Map<String, String> _toFormFields(Map<String, dynamic>? body) {
    if (body == null) return {};
    final fields = <String, String>{};
    for (final entry in body.entries) {
      if (entry.value == null) continue;
      fields[entry.key] = entry.value.toString();
    }
    return fields;
  }

  Uri _buildUri(String endpoint, {Map<String, dynamic>? queryParams}) {
    final base = EnvConfig.instance.baseUrl;
    final url = '$base$endpoint';
    final uri = Uri.parse(url);
    if (queryParams != null && queryParams.isNotEmpty) {
      final stringParams = queryParams.map(
        (k, v) => MapEntry(k, v.toString()),
      );
      return uri.replace(queryParameters: stringParams);
    }
    return uri;
  }

  Future<ApiResponse<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    T Function(dynamic)? fromJson,
  }) async {
    final uri = _buildUri(endpoint, queryParams: queryParams);
    AppLogger.request('GET', uri.toString());

    try {
      final response = await _client
          .get(uri, headers: _buildHeaders(extra: headers))
          .timeout(const Duration(milliseconds: AppConstants.connectTimeoutMs));

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<ApiResponse<T>> post<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    T Function(dynamic)? fromJson,
  }) async {
    final uri = _buildUri(endpoint);
    AppLogger.request('POST', uri.toString(), body: body);

    try {
      final response = await _client
          .post(
            uri,
            headers: _buildHeaders(extra: headers),
            body: _toFormFields(body),
          )
          .timeout(const Duration(milliseconds: AppConstants.connectTimeoutMs));

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<ApiResponse<T>> put<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    T Function(dynamic)? fromJson,
  }) async {
    final uri = _buildUri(endpoint);
    AppLogger.request('PUT', uri.toString(), body: body);

    try {
      final response = await _client
          .put(
            uri,
            headers: _buildHeaders(extra: headers),
            body: _toFormFields(body),
          )
          .timeout(const Duration(milliseconds: AppConstants.connectTimeoutMs));

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<ApiResponse<T>> patch<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    T Function(dynamic)? fromJson,
  }) async {
    final uri = _buildUri(endpoint);
    AppLogger.request('PATCH', uri.toString(), body: body);

    try {
      final response = await _client
          .patch(
            uri,
            headers: _buildHeaders(extra: headers),
            body: _toFormFields(body),
          )
          .timeout(const Duration(milliseconds: AppConstants.connectTimeoutMs));

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<ApiResponse<T>> delete<T>(
    String endpoint, {
    Map<String, String>? headers,
    T Function(dynamic)? fromJson,
  }) async {
    final uri = _buildUri(endpoint);
    AppLogger.request('DELETE', uri.toString());

    try {
      final response = await _client
          .delete(uri, headers: _buildHeaders(extra: headers))
          .timeout(const Duration(milliseconds: AppConstants.connectTimeoutMs));

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      throw _handleError(e);
    }
  }

  ApiResponse<T> _handleResponse<T>(
    http.Response response,
    T Function(dynamic)? fromJson,
  ) {
    final statusCode = response.statusCode;
    AppLogger.response(statusCode, response.request?.url.toString() ?? '');

    // Decode first so the backend's own `message` (e.g. "Invalid password",
    // "Mobile number not registered") can be surfaced instead of a generic
    // one, regardless of status code.
    dynamic decoded;
    try {
      decoded = jsonDecode(response.body);
    } catch (_) {
      decoded = null;
    }
    final message = decoded is Map ? decoded['message'] as String? : null;

    if (decoded != null) AppLogger.response(statusCode, '', body: decoded);

    if (statusCode == 401) throw AppException.unauthorized(message);
    if (statusCode == 403) throw AppException.forbidden(message);
    if (statusCode == 404) throw AppException.notFound(message);
    if (statusCode == 429) {
      throw AppException(
        message: message ?? 'Too many attempts. Please try again later.',
        type: AppErrorType.validation,
        statusCode: statusCode,
      );
    }
    if (statusCode >= 500) throw AppException.serverError(message);

    if (decoded == null) {
      throw AppException.parseError();
    }

    if (statusCode >= 200 && statusCode < 300) {
      if (decoded is Map<String, dynamic>) {
        return ApiResponse.fromJson(decoded, fromJson);
      }
      return ApiResponse.success(
        data: fromJson != null ? fromJson(decoded) : null,
        statusCode: statusCode,
      );
    }

    throw AppException.fromStatusCode(statusCode, message);
  }

  AppException _handleError(dynamic error) {
    if (error is AppException) return error;
    if (error is SocketException) return AppException.noInternet();
    if (error is TimeoutException) return AppException.timeout();
    if (error is FormatException) return AppException.parseError();
    return AppException.unknown(error.toString());
  }

  void dispose() {
    _client.close();
  }
}
