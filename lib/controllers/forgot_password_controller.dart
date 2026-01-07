import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class ForgotPasswordController extends GetxController {
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

  // Send reset code
  Future<void> sendCode() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Navigate to OTP verification screen
      Get.toNamed(
        AppRoutes.verifyOTP,
        arguments: {
          'email': emailController.text,
          'verificationType': 'forgotPassword',
        },
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send reset code. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
