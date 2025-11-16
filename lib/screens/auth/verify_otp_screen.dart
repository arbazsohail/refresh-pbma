import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../controllers/verify_otp_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_back_button.dart';

class VerifyOTPScreen extends GetView<VerifyOTPController> {
  const VerifyOTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Pinput theme - Rounded With Cursor variant
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: AppColors.secondary,
        fontWeight: FontWeight.w600,
        fontFamily: 'DMSans',
      ),
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        border: Border.all(color: AppColors.lightBorder),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.secondary, width: 2),
      borderRadius: BorderRadius.circular(12),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: AppColors.lightGray,
        border: Border.all(color: AppColors.secondary, width: 2),
      ),
    );

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

                const SizedBox(height: 40),

                // Title
                const Center(
                  child: Text(
                    'OTP Verification',
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
                    'Enter the verification code we just\nsent on your email address',
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

                // OTP Input
                Center(
                  child: Pinput(
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    showCursor: true,
                    cursor: Container(
                      height: 24,
                      width: 2,
                      decoration: BoxDecoration(
                        color: AppColors.greyText,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    preFilledWidget: const Text(
                      '—',
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.lightBorder,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'DMSans',
                      ),
                    ),
                    onCompleted: (pin) {
                      controller.otpCode.value = pin;
                    },
                    onChanged: (value) {
                      controller.otpCode.value = value;
                    },
                  ),
                ),

                const SizedBox(height: 40),

                // Verify button
                Obx(
                  () => CustomButton(
                    title: 'Verify',
                    onTap: controller.verifyOTP,
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

                const SizedBox(height: 24),

                // Resend OTP
                Center(
                  child: Obx(
                    () =>
                        controller.canResend.value
                            ? GestureDetector(
                              onTap: controller.resendOTP,
                              child: const Text(
                                'Resend OTP',
                                style: TextStyle(
                                  color: AppColors.secondary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'DMSans',
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                            : Text(
                              'Resend OTP in ${controller.resendTimer.value}s',
                              style: const TextStyle(
                                color: AppColors.greyText,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'DMSans',
                              ),
                            ),
                  ),
                ),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
