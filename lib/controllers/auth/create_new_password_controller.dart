import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../../services/auth_service.dart';
import '../../widgets/custom_snackbar.dart';

class CreateNewPasswordController extends GetxController {
  // Services
  final AuthService _authService = Get.find<AuthService>();
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
      // Call auth service to set/reset password
      final response = await _authService.setPassword(
        newPassword: newPasswordController.text,
        confirmPassword: confirmPasswordController.text,
      );

      isLoading.value = false;

      // Show success message
      CustomSnackbar.success(
        title: 'Success',
        message: response['message'] ?? 'Password changed successfully!',
      );

      // Delay navigation to allow snackbar to show and avoid disposal errors
      await Future.delayed(const Duration(milliseconds: 500));

      // Navigate to login screen
      Get.offAllNamed(AppRoutes.login);
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
        message: 'Failed to change password. Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
