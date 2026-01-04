import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../../widgets/verification_success_dialog.dart';
import '../../services/auth_service.dart';
import '../../widgets/custom_snackbar.dart';

class VerifyOTPController extends GetxController {
  // Services
  final AuthService _authService = Get.find<AuthService>();

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
      CustomSnackbar.warning(
        title: 'Invalid OTP',
        message: 'Please enter the complete 6-digit code',
      );
      return;
    }

    isLoading.value = true;

    try {
      // Call appropriate API based on verification type
      if (verificationType.value == 'forgotPassword') {
        // Verify OTP for forgot password flow
        final response = await _authService.verifyOtpForgotPassword(
          email: email.value,
          otp: otpCode.value,
        );

        // Show success message
        CustomSnackbar.success(
          title: 'Success',
          message: response['message'] ?? 'OTP verified successfully',
        );

        // Navigate to create new password screen
        Get.toNamed(
          AppRoutes.createNewPassword,
          arguments: {
            'email': email.value,
            'otp': otpCode.value, // Pass OTP for password reset
          },
        );
      } else {
        // Verify OTP for signup flow
        await _authService.verifyOtpSignup(
          email: email.value,
          otp: otpCode.value,
        );

        // Stop loading before showing dialog
        isLoading.value = false;

        // Show success dialog with confetti for signup flow
        Get.dialog(
          VerificationSuccessDialog(
            onOkPressed: () {
              Get.back(); // Close dialog
              Get.offAllNamed(AppRoutes.biometricSetup); // Navigate to biometric setup
            },
          ),
          barrierDismissible: false,
        );
      }
    } on String catch (errorMessage) {
      // Error from AuthService
      CustomSnackbar.error(
        title: 'Verification Failed',
        message: errorMessage,
      );
    } catch (e) {
      // Unexpected error
      CustomSnackbar.error(
        title: 'Error',
        message: 'Invalid OTP code. Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Resend OTP
  Future<void> resendOTP() async {
    if (!canResend.value) return;

    try {
      // Resend OTP via email
      final response = await _authService.sendOtpEmail(email: email.value);

      CustomSnackbar.success(
        title: 'OTP Sent',
        message: response['message'] ?? 'A new verification code has been sent to your email',
      );

      // Restart timer
      startResendTimer();
    } on String catch (errorMessage) {
      CustomSnackbar.error(
        title: 'Error',
        message: errorMessage,
      );
    } catch (e) {
      CustomSnackbar.error(
        title: 'Error',
        message: 'Failed to resend OTP. Please try again.',
      );
    }
  }
}
