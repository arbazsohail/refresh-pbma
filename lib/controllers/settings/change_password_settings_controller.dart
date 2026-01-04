import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/auth_service.dart';
import '../../widgets/custom_snackbar.dart';

class ChangePasswordSettingsController extends GetxController {
  // Services
  final AuthService _authService = Get.find<AuthService>();
  // Form key
  final formKey = GlobalKey<FormState>();

  // Text controllers
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Loading state
  final RxBool isLoading = false.obs;

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // Validation methods
  String? validateOldPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Old password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'New password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    if (value == oldPasswordController.text) {
      return 'New password must be different from old password';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Save password
  Future<void> savePassword() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    try {
      // Call API to change password
      final response = await _authService.changePassword(
        currentPassword: oldPasswordController.text,
        newPassword: newPasswordController.text,
        confirmPassword: confirmPasswordController.text,
      );

      // Show success message
      CustomSnackbar.success(
        title: 'Success',
        message: response['message'] ?? 'Password changed successfully',
      );

      // Clear fields
      oldPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();

      // Go back to previous screen
      Get.back();
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
