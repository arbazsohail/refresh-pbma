import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../../services/auth_service.dart';
import '../../services/biometric_service.dart';
import '../../services/storage_service.dart';
import '../../services/google_auth_service.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/custom_loading_dialog.dart';

class LoginController extends GetxController {
  // Services
  final AuthService _authService = Get.find<AuthService>();
  final BiometricService _biometricService = Get.find<BiometricService>();
  final StorageService _storageService = Get.find<StorageService>();
  final GoogleAuthService _googleAuthService = Get.find<GoogleAuthService>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool rememberMe = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isGoogleLoading = false.obs;
  final RxBool isAppleLoading = false.obs;

  // Biometric settings
  final RxBool showBiometricButton = false.obs;
  final RxString biometricType = 'Fingerprint'.obs;

  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    checkBiometricAvailability();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Check if biometric login should be shown
  Future<void> checkBiometricAvailability() async {
    print('🔍 Checking biometric availability...');

    // Check 1: Device supports biometric
    final isAvailable = await _biometricService.isBiometricAvailable();
    print('📱 Device supports biometric: $isAvailable');

    // Check 2: User has enabled biometric in settings
    final isEnabled = _biometricService.isBiometricEnabled();
    print('⚙️ Biometric enabled in settings: $isEnabled');

    // Check 3: User is logged in (has user data saved)
    final isLoggedIn = _storageService.isLoggedIn();
    print('👤 User is logged in: $isLoggedIn');

    // Show biometric button if device supports it, user enabled it, and user is logged in
    if (isAvailable && isEnabled && isLoggedIn) {
      showBiometricButton.value = true;
      biometricType.value = await _biometricService.getBiometricTypeName();
      print('✅ Biometric login button will be shown (${biometricType.value})');
    } else {
      showBiometricButton.value = false;
      print('❌ Biometric login button will NOT be shown');
      if (!isAvailable) print('   ⚠️ Device does not support biometric');
      if (!isEnabled) print('   ⚠️ Biometric not enabled in settings');
      if (!isLoggedIn) print('   ⚠️ User not logged in yet');
    }
  }

  // Login with biometric
  Future<void> loginWithBiometric() async {
    try {
      // Authenticate using biometric
      final didAuthenticate = await _biometricService.authenticate(
        localizedReason: 'Authenticate to login',
      );

      if (didAuthenticate) {
        // Biometric authentication successful
        // User is already logged in (has valid token), just navigate to main page
        CustomSnackbar.success(
          title: 'Success',
          message: 'Login successful!',
        );

        Get.offAllNamed(AppRoutes.mainPage);
      } else {
        // Authentication failed
        CustomSnackbar.error(
          title: 'Authentication Failed',
          message: 'Biometric authentication failed. Please try again.',
        );
      }
    } catch (e) {
      print('❌ Biometric login error: $e');
      CustomSnackbar.error(
        title: 'Error',
        message: 'Failed to authenticate. Please use email and password.',
      );
    }
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
