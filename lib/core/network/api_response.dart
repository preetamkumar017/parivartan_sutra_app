class ApiResponse<T> {
  final bool success;
  final String? message;
  final T? data;
  final int? statusCode;
  final Map<String, dynamic>? errors;
  final PaginationMeta? pagination;

  const ApiResponse({
    required this.success,
    this.message,
    this.data,
    this.statusCode,
    this.errors,
    this.pagination,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    // Backend sends 'status' (bool); fallback to 'success' for compatibility
    final isSuccess =
        json['status'] as bool? ?? json['success'] as bool? ?? false;

    T? parsedData;
    if (json['data'] != null && fromJsonT != null) {
      try {
        parsedData = fromJsonT(json['data']) as T?;
      } catch (_) {
        parsedData = null;
      }
    }

    Map<String, dynamic>? errorsMap;
    final rawErrors = json['errors'];
    if (rawErrors is Map) {
      errorsMap = Map<String, dynamic>.from(rawErrors);
    } else if (rawErrors is List && rawErrors.isNotEmpty) {
      errorsMap = {for (var i = 0; i < rawErrors.length; i++) '$i': rawErrors[i]};
    }

    return ApiResponse<T>(
      success: isSuccess,
      message: json['message'] as String?,
      statusCode: json['statusCode'] as int? ?? json['status_code'] as int?,
      data: parsedData,
      errors: errorsMap,
      pagination: json['pagination'] != null
          ? PaginationMeta.fromJson(
              json['pagination'] as Map<String, dynamic>)
          : null,
    );
  }

  factory ApiResponse.success({
    T? data,
    String? message,
    int? statusCode,
    PaginationMeta? pagination,
  }) {
    return ApiResponse<T>(
      success: true,
      data: data,
      message: message,
      statusCode: statusCode,
      pagination: pagination,
    );
  }

  factory ApiResponse.failure({
    String? message,
    int? statusCode,
    Map<String, dynamic>? errors,
  }) {
    return ApiResponse<T>(
      success: false,
      message: message ?? 'Something went wrong',
      statusCode: statusCode,
      errors: errors,
    );
  }

  bool get hasData => data != null;
  bool get hasPagination => pagination != null;
  bool get hasErrors => errors != null && errors!.isNotEmpty;

  @override
  String toString() =>
      'ApiResponse(success: $success, message: $message, statusCode: $statusCode)';
}

class PaginationMeta {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final bool hasNextPage;
  final bool hasPrevPage;

  const PaginationMeta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.hasNextPage,
    required this.hasPrevPage,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    final current = json['current_page'] as int? ?? 1;
    final last = json['last_page'] as int? ?? 1;
    return PaginationMeta(
      currentPage: current,
      lastPage: last,
      perPage: json['per_page'] as int? ?? 20,
      total: json['total'] as int? ?? 0,
      hasNextPage: current < last,
      hasPrevPage: current > 1,
    );
  }

  @override
  String toString() =>
      'PaginationMeta(currentPage: $currentPage, lastPage: $lastPage, total: $total)';
}
