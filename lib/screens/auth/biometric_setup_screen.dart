import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../controllers/biometric_setup_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_back_button.dart';

class BiometricSetupScreen extends GetView<BiometricSetupController> {
  const BiometricSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConstants.lightSystemOverlay(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Back button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBackButton(onTap: () => Get.back()),
                    Obx(
                      () => Text(
                        controller.biometricType.value == 'face'
                            ? 'Face ID'
                            : 'Fingerprint',
                        style: const TextStyle(
                          color: AppColors.blackText,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'DMSans',
                        ),
                      ),
                    ),
                    SizedBox(),
                  ],
                ),

                const Spacer(),

                // Icon
                Obx(
                  () => SvgPicture.asset(
                    controller.biometricType.value == 'face'
                        ? 'assets/icons/face.svg'
                        : 'assets/icons/face.svg',
                    width: 80,
                    height: 80,
                  ),
                ),

                const SizedBox(height: 40),

                // Main text
                Obx(
                  () => Text(
                    controller.biometricType.value == 'face'
                        ? 'Face ID Is Now Available! Enabling Face ID Will Give You Faster Access To Your Information.'
                        : 'Fingerprint Is Now Available! Enabling Fingerprint Will Give You Faster Access To Your Information.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.blackText,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'DMSans',
                      height: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Subtitle
                const Text(
                  'You can turn it on or turn it off at any time under Settings',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.greyText,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'DMSans',
                    height: 1.5,
                  ),
                ),

                const Spacer(),

                // Enable button
                Obx(
                  () => CustomButton(
                    title: 'Enable',
                    onTap: controller.enableBiometric,
                    height: 54,
                    backgroundColor: AppColors.primary,
                    textColor: AppColors.white,
                    borderRadius: 50,
                    margin: 0,
                    horizontalPadding: 36,
                    titleFontSize: 16,
                    loading: controller.isLoading.value,
                  ),
                ),

                const SizedBox(height: 16),

                // Learn More / Skip button
                Obx(
                  () => GestureDetector(
                    onTap: controller.skip,
                    child: Text(
                      controller.biometricType.value == 'face'
                          ? 'Learn More About Face ID'
                          : 'Skip',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'DMSans',
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
