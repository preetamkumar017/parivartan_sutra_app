import 'package:get/get.dart';
import '../../core/errors/app_exception.dart';
import '../../core/errors/error_handler.dart';
import '../../core/utils/app_logger.dart';

abstract class BaseController extends GetxController {
  // ─── Loading State ───────────────────────────────────────────────────────────
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final RxBool _isPageLoading = false.obs;
  bool get isPageLoading => _isPageLoading.value;

  final RxBool _isRefreshing = false.obs;
  bool get isRefreshing => _isRefreshing.value;

  // ─── Error State ─────────────────────────────────────────────────────────────
  final Rx<AppException?> _error = Rx<AppException?>(null);
  AppException? get error => _error.value;
  bool get hasError => _error.value != null;

  final RxString _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  // ─── Loading Helpers ─────────────────────────────────────────────────────────

  void setLoading(bool value) => _isLoading.value = value;

  void setPageLoading(bool value) => _isPageLoading.value = value;

  void setRefreshing(bool value) => _isRefreshing.value = value;

  // ─── Error Helpers ───────────────────────────────────────────────────────────

  void setError(AppException? exception) {
    _error.value = exception;
    _errorMessage.value = exception?.message ?? '';
  }

  void clearError() {
    _error.value = null;
    _errorMessage.value = '';
  }

  // ─── Execute with Loading ────────────────────────────────────────────────────

  Future<T?> runWithLoading<T>(
    Future<T> Function() action, {
    bool showError = true,
    bool pageLoading = false,
  }) async {
    try {
      clearError();
      if (pageLoading) {
        setPageLoading(true);
      } else {
        setLoading(true);
      }
      final result = await action();
      return result;
    } on AppException catch (e) {
      setError(e);
      if (showError) ErrorHandler.showError(e);
      AppLogger.error(runtimeType.toString(), e.toString());
      return null;
    } catch (e) {
      final exception = ErrorHandler.handle(e);
      setError(exception);
      if (showError) ErrorHandler.showError(exception);
      AppLogger.error(runtimeType.toString(), e.toString());
      return null;
    } finally {
      if (pageLoading) {
        setPageLoading(false);
      } else {
        setLoading(false);
      }
    }
  }

  Future<T?> runWithRefresh<T>(
    Future<T> Function() action, {
    bool showError = true,
  }) async {
    try {
      clearError();
      setRefreshing(true);
      final result = await action();
      return result;
    } on AppException catch (e) {
      setError(e);
      if (showError) ErrorHandler.showError(e);
      return null;
    } catch (e) {
      final exception = ErrorHandler.handle(e);
      setError(exception);
      if (showError) ErrorHandler.showError(exception);
      return null;
    } finally {
      setRefreshing(false);
    }
  }

  // ─── Lifecycle ───────────────────────────────────────────────────────────────

  @override
  void onInit() {
    super.onInit();
    AppLogger.debug(runtimeType.toString(), 'onInit');
  }

  @override
  void onReady() {
    super.onReady();
    AppLogger.debug(runtimeType.toString(), 'onReady');
  }

  @override
  void onClose() {
    AppLogger.debug(runtimeType.toString(), 'onClose');
    super.onClose();
  }
}
