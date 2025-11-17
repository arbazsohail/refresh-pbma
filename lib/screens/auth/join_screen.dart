import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/service_card.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/auto_scroll_banner.dart';
import '../../routes/app_routes.dart';

class JoinScreen extends StatelessWidget {
  const JoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      {'image': 'assets/images/join1.png', 'label': 'Smooth fine lines'},
      {'image': 'assets/images/join2.png', 'label': 'Restore Volume'},
      {'image': 'assets/images/join3.png', 'label': 'Remove Unwanted Hair'},
      {'image': 'assets/images/join4.png', 'label': 'Lose Weight'},
    ];

    return AppConstants.lightSystemOverlay(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mini Logo at top left
              Padding(
                padding: EdgeInsets.only(left: 24, top: Get.height * 0.08),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 63,
                  width: 47,
                ),
              ),

              const SizedBox(height: 32),

              // Title
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Get Your Personalized\nService Plan',
                  style: TextStyle(
                    color: AppColors.blackText,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'DMSans',
                    height: 1.2,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Subtitle
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Refer and earn rewards',
                  style: TextStyle(
                    color: Color(0xFF7C8086),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'DMSans',
                  ),
                ),
              ),

              SizedBox(height: Get.height * 0.05),

              // Auto-scrolling Service Banner
              AutoScrollBanner(
                height: Get.height * 0.18,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                scrollDuration: const Duration(milliseconds: 800),
                pauseDuration: const Duration(seconds: 3),
                children: services.asMap().entries.map((entry) {
                  final index = entry.key;
                  final service = entry.value;
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index < services.length - 1 ? 16 : 0,
                    ),
                    child: ServiceCard(
                      image: service['image']!,
                      label: service['label']!,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: Get.height * 0.07),

              // Get Started Button
              CustomButton(
                title: 'Get Started',
                onTap: () {
                  Get.toNamed(AppRoutes.signup);
                },
                height: 54,
                backgroundColor: AppColors.primary,
                textColor: AppColors.white,
                borderRadius: 50,
                margin: 24,
                horizontalPadding: 36,
                titleFontSize: 16,
              ),

              const SizedBox(height: 16),

              // Login Button
              CustomButton(
                title: 'Login',
                onTap: () {
                  Get.toNamed(AppRoutes.login);
                },
                height: 54,
                textColor: AppColors.primary,
                borderColor: AppColors.primary,
                borderRadius: 50,
                margin: 24,
                horizontalPadding: 36,
                titleFontSize: 16,
              ),

              SizedBox(height: Get.height * 0.08),

              // Sign up text
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: Color(0xFF7C8086),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'DMSans',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.signup);
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'DMSans',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
