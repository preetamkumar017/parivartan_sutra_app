import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              // Logo / Title
              const Text(
                'Parivartan Sutra',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Sign in to continue',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 32),

              // Mode toggle
              Obx(() => Row(
                    children: [
                      Expanded(
                        child: _ModeTab(
                          label: 'Parent',
                          selected: controller.loginMode.value == LoginMode.parent,
                          onTap: () => controller.switchMode(LoginMode.parent),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _ModeTab(
                          label: 'Student',
                          selected: controller.loginMode.value == LoginMode.student,
                          onTap: () => controller.switchMode(LoginMode.student),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 28),

              // Form
              Obx(() {
                if (controller.loginMode.value == LoginMode.parent) {
                  return _ParentLoginForm(controller: controller);
                }
                return _StudentLoginForm(controller: controller);
              }),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Parent OTP form ──────────────────────────────────────────────────────────

class _ParentLoginForm extends StatelessWidget {
  final LoginController controller;
  const _ParentLoginForm({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.otpSent.value) {
        // Step 1: enter email
        return Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: _inputDecoration('Email', Icons.email_outlined),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Email is required';
                  if (!GetUtils.isEmail(v.trim())) return 'Enter a valid email';
                  return null;
                },
              ),
              const SizedBox(height: 8),
              _ErrorText(message: controller.errorMessage.value),
              const SizedBox(height: 16),
              _SubmitButton(
                label: 'Send OTP',
                isLoading: controller.isLoading.value,
                onPressed: controller.sendOtp,
              ),
            ],
          ),
        );
      }

      // Step 2: enter OTP
      return Form(
        key: controller.otpFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'OTP sent to ${controller.emailController.text}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: controller.otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: _inputDecoration('Enter OTP', Icons.lock_outline),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'OTP is required';
                if (v.trim().length != 6) return 'OTP must be 6 digits';
                return null;
              },
            ),
            const SizedBox(height: 8),
            _ErrorText(message: controller.errorMessage.value),
            const SizedBox(height: 16),
            _SubmitButton(
              label: 'Verify OTP',
              isLoading: controller.isLoading.value,
              onPressed: controller.verifyOtp,
            ),
            TextButton(
              onPressed: controller.isLoading.value
                  ? null
                  : () => controller.switchMode(LoginMode.parent),
              child: const Text('Change email'),
            ),
          ],
        ),
      );
    });
  }
}

// ── Student login form ───────────────────────────────────────────────────────

class _StudentLoginForm extends StatelessWidget {
  final LoginController controller;
  const _StudentLoginForm({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: _inputDecoration('Email', Icons.email_outlined),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Email is required';
                  if (!GetUtils.isEmail(v.trim())) return 'Enter a valid email';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.passwordController,
                obscureText: controller.obscurePassword.value,
                decoration: _inputDecoration(
                  'Password',
                  Icons.lock_outline,
                  suffix: IconButton(
                    icon: Icon(
                      controller.obscurePassword.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () => controller.obscurePassword.toggle(),
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Password is required';
                  if (v.length < 6) return 'Minimum 6 characters';
                  return null;
                },
              ),
              const SizedBox(height: 8),
              _ErrorText(message: controller.errorMessage.value),
              const SizedBox(height: 16),
              _SubmitButton(
                label: 'Login',
                isLoading: controller.isLoading.value,
                onPressed: controller.studentLogin,
              ),
            ],
          ),
        ));
  }
}

// ── Shared widgets ───────────────────────────────────────────────────────────

class _ModeTab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _ModeTab(
      {required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF1A237E) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: selected ? Colors.white : Colors.grey.shade600,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback onPressed;
  const _SubmitButton(
      {required this.label,
      required this.isLoading,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A237E),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2),
              )
            : Text(label,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
      ),
    );
  }
}

class _ErrorText extends StatelessWidget {
  final String message;
  const _ErrorText({required this.message});

  @override
  Widget build(BuildContext context) {
    if (message.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        message,
        style: const TextStyle(color: Colors.red, fontSize: 13),
        textAlign: TextAlign.center,
      ),
    );
  }
}

InputDecoration _inputDecoration(String label, IconData icon,
    {Widget? suffix}) {
  return InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon, color: const Color(0xFF1A237E)),
    suffixIcon: suffix,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFF1A237E), width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );
}
