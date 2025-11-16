import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class SignupController extends GetxController {
  // Text controllers for Step 1
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Text controllers for Step 2
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Form keys
  final GlobalKey<FormState> step1FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> step2FormKey = GlobalKey<FormState>();

  // Observable states
  final RxInt currentStep = 1.obs;
  final RxBool isLoading = false.obs;
  final RxBool agreeToTerms = false.obs;
  final RxString selectedCountryCode = '+1'.obs;

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    dobController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // Validation methods
  String? validateName(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $fieldName';
    }
    if (value.length < 2) {
      return '$fieldName must be at least 2 characters';
    }
    return null;
  }

  String? validateDOB(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your date of birth';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (value.length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Toggle terms agreement
  void toggleTerms(bool? value) {
    agreeToTerms.value = value ?? false;
  }

  // Select date of birth
  Future<void> selectDOB(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dobController.text =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
    }
  }

  // Continue to step 2
  void continueToStep2() {
    if (!step1FormKey.currentState!.validate()) {
      return;
    }
    currentStep.value = 2;
  }

  // Go back to step 1
  void goBackToStep1() {
    currentStep.value = 1;
  }

  // Sign up
  Future<void> signUp() async {
    if (!step2FormKey.currentState!.validate()) {
      return;
    }

    if (!agreeToTerms.value) {
      Get.snackbar(
        'Terms Required',
        'Please agree to the terms and conditions',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      // TODO: Implement actual sign up logic here
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Navigate to verify email screen on success
      Get.toNamed(
        AppRoutes.verifyEmail,
        arguments: {'email': emailController.text},
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to sign up. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Sign up with Google
  Future<void> signUpWithGoogle() async {
    isLoading.value = true;

    try {
      // TODO: Implement Google sign up logic
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      Get.offAllNamed(AppRoutes.mainPage);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to sign up with Google. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Sign up with Apple
  Future<void> signUpWithApple() async {
    isLoading.value = true;

    try {
      // TODO: Implement Apple sign up logic
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      Get.offAllNamed(AppRoutes.mainPage);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to sign up with Apple. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Navigate to sign in
  void goToSignIn() {
    Get.back();
  }

  // Open terms and conditions
  void openTerms() {
    // TODO: Open terms and conditions page
  }

  // Open privacy policy
  void openPrivacyPolicy() {
    // TODO: Open privacy policy page
  }
}
