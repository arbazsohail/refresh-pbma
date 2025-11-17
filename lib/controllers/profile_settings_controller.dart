import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/storage_service.dart';

class ProfileSettingsController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();

  // Form key
  final formKey = GlobalKey<FormState>();

  // Text controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  // Loading state
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  // Load user profile data
  void loadUserProfile() {
    // Load from storage or API
    final userName = _storageService.getUserName() ?? '';
    final userEmail = _storageService.getUserEmail() ?? '';

    // Split name into first and last name if available
    final nameParts = userName.split(' ');
    if (nameParts.isNotEmpty) {
      firstNameController.text = nameParts[0];
      if (nameParts.length > 1) {
        lastNameController.text = nameParts.sublist(1).join(' ');
      }
    }

    emailController.text = userEmail;

    // Phone number would come from API in a real app
    phoneController.text = _storageService.getString('phone') ?? '';
  }

  // Validation methods
  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'First name is required';
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Last name is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  // Save changes
  Future<void> saveChanges() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    try {
      // In a real app, you would call an API to update the profile
      await Future.delayed(const Duration(seconds: 1));

      // Save to storage
      final fullName = '${firstNameController.text} ${lastNameController.text}';
      await _storageService.saveUserData(
        userId: _storageService.getUserId() ?? '',
        userName: fullName,
        userEmail: emailController.text,
      );
      await _storageService.saveString('phone', phoneController.text);

      Get.snackbar(
        'Success',
        'Profile updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Delete account
  void deleteAccount() {
    Get.defaultDialog(
      title: 'Delete Account',
      middleText: 'Are you sure you want to delete your account? This action cannot be undone.',
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      cancelTextColor: Get.theme.colorScheme.primary,
      onConfirm: () async {
        Get.back(); // Close dialog

        isLoading.value = true;

        try {
          // In a real app, you would call an API to delete the account
          await Future.delayed(const Duration(seconds: 1));

          // Clear all data
          await _storageService.clearAll();

          // Navigate to login
          Get.offAllNamed('/login');

          Get.snackbar(
            'Account Deleted',
            'Your account has been deleted successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );
        } catch (e) {
          Get.snackbar(
            'Error',
            'Failed to delete account. Please try again.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );
        } finally {
          isLoading.value = false;
        }
      },
    );
  }
}
