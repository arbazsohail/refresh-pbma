import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../../services/auth_service.dart';
import '../../services/google_auth_service.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/custom_loading_dialog.dart';

class SignupController extends GetxController {
  // Services
  final AuthService _authService = Get.find<AuthService>();
  final GoogleAuthService _googleAuthService = Get.find<GoogleAuthService>();

  // Text controllers for Step 1
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Text controllers for Step 2
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
      // Format as MM/DD/YYYY
      dobController.text =
          '${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}';
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

  // Sign up with API integration
  Future<void> signUp() async {
    if (!step2FormKey.currentState!.validate()) {
      return;
    }

    if (!agreeToTerms.value) {
      CustomSnackbar.warning(
        title: 'Terms Required',
        message: 'Please agree to the terms and conditions',
      );
      return;
    }

    isLoading.value = true;

    try {
      // Call auth service to register user
      final response = await _authService.register(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        mobileNo: selectedCountryCode.value + phoneController.text,
        dob: dobController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
      );

      // Show success message
      CustomSnackbar.success(
        title: 'Success',
        message: response['message'] ?? 'Account created successfully!',
      );

      // Navigate to verify email screen
      Get.toNamed(
        AppRoutes.verifyEmail,
        arguments: {
          'email': emailController.text,
          'phoneNumber': phoneController.text,
        },
      );
    } on String catch (errorMessage) {
      // Error from AuthService
      CustomSnackbar.error(
        title: 'Signup Failed',
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

  // Sign up with Google
  Future<void> signUpWithGoogle() async {
    try {
      // Show centered loading dialog
      CustomLoadingDialog.show(message: 'Signing up with Google...');

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
        message: response['message'] ?? 'Account created successfully!',
      );

      // Navigate to main page
      Get.offAllNamed(AppRoutes.mainPage);
    } on String catch (errorMessage) {
      // Hide loading dialog
      CustomLoadingDialog.hide();

      // Error from AuthService
      CustomSnackbar.error(
        title: 'Signup Failed',
        message: errorMessage,
      );
    } catch (e) {
      // Hide loading dialog
      CustomLoadingDialog.hide();

      // Unexpected error
      CustomSnackbar.error(
        title: 'Error',
        message: 'Failed to sign up with Google. Please try again.',
      );
      print('Google Sign-Up Error: $e');
    }
  }

  // Sign up with Apple
  Future<void> signUpWithApple() async {
    // Show centered loading dialog
    CustomLoadingDialog.show(message: 'Signing up with Apple...');

    // Simulate delay for now
    await Future.delayed(const Duration(seconds: 1));

    // Hide loading dialog
    CustomLoadingDialog.hide();

    CustomSnackbar.warning(
      title: 'Coming Soon',
      message: 'Apple sign-up is currently under development',
    );
  }

  // Navigate to sign in
  void goToSignIn() {
    Get.back();
  }

  // Open terms and conditions
  void openTerms() {}

  // Open privacy policy
  void openPrivacyPolicy() {}
}
