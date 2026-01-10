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

      // Stop loading immediately
      isLoading.value = false;

      // Show success message
      CustomSnackbar.success(
        title: 'Success',
        message: response['message'] ?? 'Password changed successfully!',
      );

      // Use a post-frame callback to ensure the widget tree is stable before navigation
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        // Small delay to let the UI update
        await Future.delayed(const Duration(milliseconds: 300));

        // Navigate to login screen, keeping current route in stack temporarily
        Get.offNamedUntil(AppRoutes.login, (route) => false);
      });
    } on String catch (errorMessage) {
      isLoading.value = false;

      // Error from AuthService
      CustomSnackbar.error(
        title: 'Error',
        message: errorMessage,
      );
    } catch (e) {
      isLoading.value = false;

      // Unexpected error
      CustomSnackbar.error(
        title: 'Error',
        message: 'Failed to change password. Please try again.',
      );
    }
  }
}
