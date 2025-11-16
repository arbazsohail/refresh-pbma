import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../controllers/verify_email_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_back_button.dart';

class VerifyEmailScreen extends GetView<VerifyEmailController> {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConstants.lightSystemOverlay(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                const CustomBackButton(),

                const SizedBox(height: 20),

                // Title
                const Center(
                  child: Text(
                    'Verify Your Account With',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.blackText,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'DMSans',
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Subtitle
                const Center(
                  child: Text(
                    'We Will send you 6 digit on time\ncode (OTP)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.greyText,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'DMSans',
                      height: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Email card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.lightGray,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.secondary, width: 1.5),
                  ),
                  child: Row(
                    children: [
                      // Email icon
                      Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          color: AppColors.secondary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/message.svg',
                            width: 28,
                            height: 28,
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Email text
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Via Email:',
                              style: TextStyle(
                                color: AppColors.blackText,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'DMSans',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Obx(
                              () => Text(
                                controller.maskedEmail,
                                style: const TextStyle(
                                  color: AppColors.blackText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'DMSans',
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: Get.height * 0.05),
                // Get OTP button
                Obx(
                  () => CustomButton(
                    title: 'Get OTP',
                    onTap: controller.getOTP,
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

                SizedBox(height: Get.height * 0.10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
