import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordSettingsController extends GetxController {
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
      // In a real app, you would call an API to change the password
      await Future.delayed(const Duration(seconds: 1));

      // Simulate API call
      // await apiService.changePassword(
      //   oldPassword: oldPasswordController.text,
      //   newPassword: newPasswordController.text,
      // );

      Get.snackbar(
        'Success',
        'Password changed successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      // Clear fields
      oldPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();

      // Go back after a delay
      await Future.delayed(const Duration(seconds: 1));
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to change password. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
