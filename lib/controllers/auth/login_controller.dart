import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../../services/auth_service.dart';
import '../../services/google_auth_service.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/custom_loading_dialog.dart';

class LoginController extends GetxController {
  // Services
  final AuthService _authService = Get.find<AuthService>();
  final GoogleAuthService _googleAuthService = Get.find<GoogleAuthService>();

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
      // Call auth service to login
      final response = await _authService.login(
        email: emailController.text,
        password: passwordController.text,
      );

      // Show success message
      CustomSnackbar.success(
        title: 'Success',
        message: response['message'] ?? 'Login successful!',
      );

      // Navigate to biometric setup or main page
      // TODO: Check if user has already setup biometric
      Get.offAllNamed(AppRoutes.mainPage);
    } on String catch (errorMessage) {
      // Error from AuthService
      CustomSnackbar.error(
        title: 'Login Failed',
        message: errorMessage,
      );
    } catch (e) {
      // Unexpected error
      CustomSnackbar.error(
        title: 'Error',
        message: 'An unexpected error occurred. Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Sign in with Google
  Future<void> signInWithGoogle() async {
    try {
      // Show centered loading dialog
      CustomLoadingDialog.show(message: 'Signing in with Google...');

      // Sign in with Google
      final googleUser = await _googleAuthService.signIn();

      if (googleUser == null) {
        // User cancelled the sign-in
        CustomLoadingDialog.hide();
        return;
      }

      // Call backend API with Google user data
      final response = await _authService.socialLogin(
        name: googleUser.displayName ?? '',
        email: googleUser.email,
        platformType: 'google',
        platformId: googleUser.id,
      );

      // Hide loading dialog
      CustomLoadingDialog.hide();

      // Show success message
      CustomSnackbar.success(
        title: 'Success',
        message: response['message'] ?? 'Login successful!',
      );

      // Navigate to main page
      Get.offAllNamed(AppRoutes.mainPage);
    } on String catch (errorMessage) {
      // Hide loading dialog
      CustomLoadingDialog.hide();

      // Error from AuthService
      CustomSnackbar.error(
        title: 'Login Failed',
        message: errorMessage,
      );
    } catch (e) {
      // Hide loading dialog
      CustomLoadingDialog.hide();

      // Unexpected error
      CustomSnackbar.error(
        title: 'Error',
        message: 'Failed to sign in with Google. Please try again.',
      );
      print('Google Sign-In Error: $e');
    }
  }

  // Sign in with Apple
  Future<void> signInWithApple() async {
    // Show centered loading dialog
    CustomLoadingDialog.show(message: 'Signing in with Apple...');

    // Simulate delay for now
    await Future.delayed(const Duration(seconds: 1));

    // Hide loading dialog
    CustomLoadingDialog.hide();

    CustomSnackbar.warning(
      title: 'Coming Soon',
      message: 'Apple sign-in is currently under development',
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
