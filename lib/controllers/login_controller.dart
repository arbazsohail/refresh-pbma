import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../services/storage_service.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool rememberMe = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isGoogleLoading = false.obs;
  final RxBool isAppleLoading = false.obs;

  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Email validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Password validation
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Toggle remember me
  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  // Sign in with email and password
  Future<void> signIn() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Save login state
      final storage = Get.find<StorageService>();
      await storage.saveBool('is_logged_in', true);

      // Navigate to main page on success
      Get.offAllNamed(AppRoutes.mainPage);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to sign in. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Sign in with Google
  Future<void> signInWithGoogle() async {
    Get.snackbar(
      'Under Development',
      'This feature is currently under development',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  // Sign in with Apple
  Future<void> signInWithApple() async {
    Get.snackbar(
      'Under Development',
      'This feature is currently under development',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  // Navigate to forgot password
  void goToForgotPassword() {
    Get.toNamed(AppRoutes.forgotPassword);
  }

  // Navigate to sign up
  void goToSignUp() {
    Get.toNamed(AppRoutes.signup);
  }
}
