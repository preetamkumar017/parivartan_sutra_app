import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import 'onboarding_two_view.dart';

class OnboardingOneView extends GetView {
  const OnboardingOneView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: width * 0.16),
              Container(
                width: double.infinity,
                height: width * 0.52,
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    Icons.insights_outlined,
                    size: width * 0.24,
                    color: AppColors.primaryLight,
                  ),
                ),
              ),
              SizedBox(height: width * 0.1),
              Text(
                'Understand Your Child’s Learning Style',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: width * 0.085,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimaryLight,
                  height: 1.18,
                ),
              ),
              SizedBox(height: width * 0.05),
              Text(
                'Structured assessments to identify strengths and improvement areas.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: width * 0.047,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondaryLight,
                  height: 1.35,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.dividerLight,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.dividerLight,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 120,
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Get.to(() => const OnboardingTwoView()),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
