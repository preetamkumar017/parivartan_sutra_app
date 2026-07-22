import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/errors/error_handler.dart';
import '../../../core/session/session_manager.dart';
import '../../../core/utils/app_logger.dart';
import '../models/auth_model.dart';
import '../services/auth_api_service.dart';

/// Single mobile+password login for both parent and student accounts —
/// the backend's `POST login` auto-detects role from `mobile`, so there's
/// no separate OTP flow and no mode toggle to drive.
class LoginController extends GetxController {
  final AuthApiService _authService = AuthApiService();

  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final obscurePassword = true.obs;

  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    mobileController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void toggleObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final res = await _authService.login(
        mobileController.text.trim(),
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
      AppLogger.error('LoginController', 'login error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _saveSessionAndNavigate(AuthUserModel user) async {
    await SessionManager.instance.saveSession(
      token: user.token,
      userId: user.id.toString(),
      role: user.role,
      mobile: user.mobile,
      email: user.email,
    );
    Get.offAllNamed(AppRoutes.home);
  }
}
