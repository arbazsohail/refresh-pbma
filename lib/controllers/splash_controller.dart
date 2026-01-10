import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/storage_service.dart';
import '../services/biometric_service.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_snackbar.dart';

class SplashController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();
  final BiometricService _biometricService = Get.find<BiometricService>();

  @override
  void onInit() {
    super.onInit();
    navigateToNextScreen();
  }

  Future<void> navigateToNextScreen() async {
    // Wait for 2 seconds to show splash screen
    await Future.delayed(const Duration(seconds: 2));

    // Check if user is logged in
    final bool isLoggedIn = _storageService.isLoggedIn();

    // Check if user has completed onboarding
    final bool onboardingCompleted =
        _storageService.getBool('onboarding_completed') ?? false;

    if (!onboardingCompleted) {
      // First time user, show onboarding
      Get.offAllNamed(AppRoutes.onboarding);
    } else if (isLoggedIn) {
      // User is logged in
      // Check if biometric is enabled
      final bool biometricEnabled = _biometricService.isBiometricEnabled();
      final bool biometricAvailable = await _biometricService.isBiometricAvailable();

      if (biometricEnabled && biometricAvailable) {
        // Biometric is enabled, prompt for authentication
        print('🔐 Biometric authentication required on app launch');
        await _promptBiometricAuthentication();
      } else {
        // No biometric, go directly to main page
        Get.offAllNamed(AppRoutes.mainPage);
      }
    } else {
      // User has completed onboarding but not logged in, go to join screen
      Get.offAllNamed(AppRoutes.join);
    }
  }

  // Prompt biometric authentication
  Future<void> _promptBiometricAuthentication() async {
    try {
      final biometricType = await _biometricService.getBiometricTypeName();

      final didAuthenticate = await _biometricService.authenticate(
        localizedReason: 'Authenticate to access the app',
        useErrorDialogs: true,
      );

      if (didAuthenticate) {
        // Authentication successful, go to main page
        print('✅ Biometric authentication successful');
        Get.offAllNamed(AppRoutes.mainPage);
      } else {
        // Authentication failed, give user options
        print('❌ Biometric authentication failed');
        _showAuthenticationFailedDialog();
      }
    } catch (e) {
      print('❌ Biometric authentication error: $e');
      // On error, show dialog with options
      _showAuthenticationFailedDialog();
    }
  }

  // Show dialog when biometric authentication fails
  void _showAuthenticationFailedDialog() {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false, // Prevent back button
        child: Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Lock icon
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lock_outline,
                    color: Colors.red,
                    size: 32,
                  ),
                ),

                const SizedBox(height: 20),

                // Title
                const Text(
                  'Authentication Required',
                  style: TextStyle(
                    color: Color(0xFF141413),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DMSans',
                  ),
                ),

                const SizedBox(height: 12),

                // Message
                const Text(
                  'Biometric authentication is required to access the app. Please try again or login with your credentials.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF7C8086),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'DMSans',
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 24),

                // Buttons
                Column(
                  children: [
                    // Try Again button
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Get.back(); // Close dialog
                          _promptBiometricAuthentication(); // Try again
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF2B8C6A),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: const Text(
                          'Try Again',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'DMSans',
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Use Password button
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () async {
                          Get.back(); // Close dialog
                          // Clear session and go to login
                          await _storageService.clearSession();
                          Get.offAllNamed(AppRoutes.login);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFE0E0E0),
                          foregroundColor: const Color(0xFF141413),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: const Text(
                          'Use Password',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'DMSans',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
