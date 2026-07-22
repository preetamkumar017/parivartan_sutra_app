import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../controllers/login_controller.dart';
import 'forgot_password_view.dart';
import 'sign_up_view.dart';

class ParentLoginView extends GetView<LoginController> {
  const ParentLoginView({super.key});

  InputDecoration _inputDecoration({
    required String hint,
    required IconData prefix,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyles.inputHint.copyWith(
        color: AppColors.textHintLight,
        fontSize: 16,
      ),
      filled: true,
      fillColor: AppColors.surfaceLight,
      prefixIcon: Icon(prefix, color: AppColors.textSecondaryLight),
      suffixIcon: suffix,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.primaryLight, width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(34),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 24,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/logo.jpeg',
                          width: width * 0.42,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Text(
                        'Welcome Back',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.headlineLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Glad to see you again!',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.titleMedium,
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: controller.mobileController,
                        keyboardType: TextInputType.phone,
                        decoration: _inputDecoration(
                          hint: 'Mobile Number',
                          prefix: Icons.phone_outlined,
                        ),
                        validator: (value) {
                          final v = value?.trim() ?? '';
                          if (v.isEmpty) return 'Mobile number is required';
                          if (v.length < AppConstants.phoneLength) {
                            return 'Enter a valid mobile number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () => TextFormField(
                          controller: controller.passwordController,
                          obscureText: controller.obscurePassword.value,
                          decoration: _inputDecoration(
                            hint: 'Password',
                            prefix: Icons.lock_outline,
                            suffix: IconButton(
                              onPressed: controller.toggleObscurePassword,
                              icon: Icon(
                                controller.obscurePassword.value
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: AppColors.textSecondaryLight,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      Obx(() {
                        if (controller.errorMessage.value.isEmpty) {
                          return const SizedBox(height: 12);
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            controller.errorMessage.value,
                            style: AppTextStyles.inputError.copyWith(
                              color: AppColors.error,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 14),
                      SizedBox(
                        height: 60,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            gradient: const LinearGradient(
                              colors: [AppColors.primaryLight, AppColors.primary],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: Obx(
                            () => ElevatedButton(
                              onPressed:
                                  controller.isLoading.value ? null : controller.login,
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.transparent,
                                backgroundColor: Colors.transparent,
                                foregroundColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                              child: controller.isLoading.value
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.4,
                                        valueColor: AlwaysStoppedAnimation(
                                          AppColors.white,
                                        ),
                                      ),
                                    )
                                  : Text('Log In', style: AppTextStyles.button),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextButton(
                        onPressed: () => Get.to(() => const ForgotPasswordView()),
                        child: Text(
                          'Forgot Password?',
                          style: AppTextStyles.titleLarge.copyWith(
                            color: AppColors.primaryLight,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Get.to(() => const SignUpView()),
                        child: Text(
                          'Sign Up',
                          style: AppTextStyles.titleLarge.copyWith(
                            color: AppColors.primaryLight,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
