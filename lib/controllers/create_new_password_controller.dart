import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class CreateNewPasswordController extends GetxController {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;
  final RxString email = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Get email from arguments
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args.containsKey('email')) {
      email.value = args['email'] as String;
    }
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // Validate password
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  // Validate confirm password
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Change password
  Future<void> changePassword() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      Get.snackbar(
        'Success',
        'Your password has been changed successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Navigate to login screen
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to change password. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
