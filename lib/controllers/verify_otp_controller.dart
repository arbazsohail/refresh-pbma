import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../widgets/verification_success_dialog.dart';
import '../services/storage_service.dart';

class VerifyOTPController extends GetxController {
  final RxString email = ''.obs;
  final RxString otpCode = ''.obs;
  final RxBool isLoading = false.obs;
  final RxBool canResend = false.obs;
  final RxInt resendTimer = 60.obs;
  final RxString verificationType = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Get email and verification type from arguments
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      if (args.containsKey('email')) {
        email.value = args['email'] as String;
      }
      if (args.containsKey('verificationType')) {
        verificationType.value = args['verificationType'] as String;
      }
    }

    // Start resend timer
    startResendTimer();
  }

  // Start countdown timer for resend
  void startResendTimer() {
    canResend.value = false;
    resendTimer.value = 60;

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (resendTimer.value > 0) {
        resendTimer.value--;
        return true;
      } else {
        canResend.value = true;
        return false;
      }
    });
  }

  // Verify OTP
  Future<void> verifyOTP() async {
    if (otpCode.value.length != 6) {
      Get.snackbar(
        'Invalid OTP',
        'Please enter the complete 6-digit code',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      // TODO: Implement actual OTP verification logic here
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Stop loading
      isLoading.value = false;

      // Check verification type and navigate accordingly
      if (verificationType.value == 'forgotPassword') {
        // Navigate to create new password screen
        Get.toNamed(
          AppRoutes.createNewPassword,
          arguments: {'email': email.value},
        );
      } else {
        // Save login state for signup flow
        final storage = Get.find<StorageService>();
        await storage.saveBool('is_logged_in', true);

        // Show success dialog with confetti for signup flow
        Get.dialog(
          VerificationSuccessDialog(
            onOkPressed: () {
              Get.back(); // Close dialog
              Get.offAllNamed(AppRoutes.mainPage); // Navigate to main page
            },
          ),
          barrierDismissible: false,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Invalid OTP code. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Colors.white,
      );
    }
  }

  // Resend OTP
  Future<void> resendOTP() async {
    if (!canResend.value) return;

    try {
      // TODO: Implement actual resend OTP logic here
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      Get.snackbar(
        'OTP Sent',
        'A new verification code has been sent to your email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Restart timer
      startResendTimer();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to resend OTP. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Colors.white,
      );
    }
  }
}
