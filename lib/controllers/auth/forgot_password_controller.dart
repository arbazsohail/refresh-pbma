import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../../services/auth_service.dart';
import '../../widgets/custom_snackbar.dart';

class ForgotPasswordController extends GetxController {
  // Services
  final AuthService _authService = Get.find<AuthService>();

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  // Validate email
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Send reset code via email (using same endpoint as signup OTP)
  Future<void> sendCode() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    try {
      // Use the same sendOtpEmail method from AuthService
      final response = await _authService.sendOtpEmail(
        email: emailController.text,
      );

      // Show success message
      CustomSnackbar.success(
        title: 'Success',
        message: response['message'] ?? 'Reset code sent to your email',
      );

      // Navigate to OTP verification screen
      Get.toNamed(
        AppRoutes.verifyOTP,
        arguments: {
          'email': emailController.text,
          'verificationType': 'forgotPassword',
        },
      );
    } on String catch (errorMessage) {
      // Error from AuthService
      CustomSnackbar.error(
        title: 'Error',
        message: errorMessage,
      );
    } catch (e) {
      // Unexpected error
      CustomSnackbar.error(
        title: 'Error',
        message: 'Failed to send reset code. Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
