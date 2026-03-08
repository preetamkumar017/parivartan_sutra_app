import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/errors/error_handler.dart';
import '../../../core/session/session_manager.dart';
import '../../../core/utils/app_logger.dart';
import '../models/auth_model.dart';
import '../services/auth_api_service.dart';

enum LoginMode { parent, student }

class LoginController extends GetxController {
  final AuthApiService _authService = AuthApiService();

  // ── Observables ────────────────────────────────────────────────────────────
  final isLoading    = false.obs;
  final loginMode    = LoginMode.parent.obs;
  final otpSent      = false.obs;
  final errorMessage = ''.obs;

  // ── Form controllers ───────────────────────────────────────────────────────
  final emailController    = TextEditingController();
  final passwordController = TextEditingController();
  final otpController      = TextEditingController();

  final formKey        = GlobalKey<FormState>();
  final otpFormKey     = GlobalKey<FormState>();
  final obscurePassword = true.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    otpController.dispose();
    super.onClose();
  }

  void switchMode(LoginMode mode) {
    loginMode.value = mode;
    otpSent.value   = false;
    errorMessage.value = '';
    emailController.clear();
    passwordController.clear();
    otpController.clear();
  }

  // ── Parent OTP flow ────────────────────────────────────────────────────────

  Future<void> sendOtp() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value    = true;
    errorMessage.value = '';

    try {
      final res = await _authService.sendOtp(emailController.text.trim());
      if (res.success) {
        otpSent.value = true;
        Get.snackbar(
          'OTP Sent',
          res.message ?? 'Check your email for the OTP.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        errorMessage.value = res.message ?? 'Failed to send OTP.';
      }
    } catch (e) {
      final ex = ErrorHandler.handle(e);
      errorMessage.value = ex.message;
      AppLogger.error('LoginController', 'sendOtp error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp() async {
    if (!otpFormKey.currentState!.validate()) return;
    isLoading.value    = true;
    errorMessage.value = '';

    try {
      final res = await _authService.verifyOtp(
        emailController.text.trim(),
        otpController.text.trim(),
      );
      if (res.success && res.data != null) {
        await _saveSessionAndNavigate(res.data!);
      } else {
        errorMessage.value = res.message ?? 'Invalid OTP.';
      }
    } catch (e) {
      final ex = ErrorHandler.handle(e);
      errorMessage.value = ex.message;
      AppLogger.error('LoginController', 'verifyOtp error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // ── Student login ──────────────────────────────────────────────────────────

  Future<void> studentLogin() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value    = true;
    errorMessage.value = '';

    try {
      final res = await _authService.studentLogin(
        emailController.text.trim(),
        passwordController.text,
      );
      if (res.success && res.data != null) {
        await _saveSessionAndNavigate(res.data!);
      } else {
        errorMessage.value = res.message ?? 'Login failed.';
      }
    } catch (e) {
      final ex = ErrorHandler.handle(e);
      errorMessage.value = ex.message;
      AppLogger.error('LoginController', 'studentLogin error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  Future<void> _saveSessionAndNavigate(AuthUserModel user) async {
    await SessionManager.instance.saveSession(
      token:        user.tokens.accessToken,
      userId:       user.id.toString(),
      refreshToken: user.tokens.refreshToken,
      email:        user.email,
    );
    Get.offAllNamed(AppRoutes.home);
  }
}
