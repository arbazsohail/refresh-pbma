import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/storage_service.dart';
import '../../services/auth_service.dart';
import '../../widgets/custom_snackbar.dart';

class SettingsController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();
  final AuthService _authService = Get.find<AuthService>();

  // Notification settings
  final RxBool pushNotificationsEnabled = true.obs;
  final RxBool emailUpdatesEnabled = true.obs;
  final RxBool isLoggingOut = false.obs;
  final RxBool isTogglingNotification = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  // Load settings from storage
  void loadSettings() {
    pushNotificationsEnabled.value =
        _storageService.getBool('pushNotifications') ?? true;
    emailUpdatesEnabled.value =
        _storageService.getBool('emailUpdates') ?? true;
  }

  // Toggle push notifications
  Future<void> togglePushNotifications(bool value) async {
    // Prevent multiple concurrent toggles
    if (isTogglingNotification.value) return;

    // Optimistically update UI
    final previousValue = pushNotificationsEnabled.value;
    pushNotificationsEnabled.value = value;

    isTogglingNotification.value = true;

    try {
      // Call API to toggle notification
      final response = await _authService.toggleNotification();

      // Update local storage with server response
      final serverValue = response['data']?['push_notification'] ?? value;
      pushNotificationsEnabled.value = serverValue;
      await _storageService.saveBool('pushNotifications', serverValue);

      // Show success message
      CustomSnackbar.success(
        title: 'Success',
        message: response['message'] ?? 'Notification settings updated',
      );
    } on String catch (errorMessage) {
      // Revert to previous value on error
      pushNotificationsEnabled.value = previousValue;

      // Show error message
      CustomSnackbar.error(
        title: 'Error',
        message: errorMessage,
      );
    } catch (e) {
      // Revert to previous value on error
      pushNotificationsEnabled.value = previousValue;

      // Show error message
      CustomSnackbar.error(
        title: 'Error',
        message: 'Failed to update notification settings. Please try again.',
      );
    } finally {
      isTogglingNotification.value = false;
    }
  }

  // Toggle email updates
  void toggleEmailUpdates(bool value) {
    emailUpdatesEnabled.value = value;
    _storageService.saveBool('emailUpdates', value);
  }

  // Navigate to Profile Settings
  void navigateToProfileSettings() {
    Get.toNamed('/profile-settings');
  }

  // Navigate to Change Password
  void navigateToChangePassword() {
    Get.toNamed('/change-password-settings');
  }

  // Navigate to FAQ
  void navigateToFAQ() {
    Get.toNamed('/faq');
  }

  // Navigate to Contact Us
  void navigateToContactUs() {
    Get.toNamed('/contact-us');
  }

  // Navigate to Terms & Conditions
  void navigateToTermsAndConditions() {
    Get.toNamed('/terms-and-conditions');
  }

  // Navigate to Privacy Policy
  void navigateToPrivacyPolicy() {
    Get.toNamed('/privacy-policy');
  }

  // Log out
  void logOut() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logout icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.logout_rounded,
                  color: Colors.red,
                  size: 32,
                ),
              ),

              const SizedBox(height: 20),

              // Title
              const Text(
                'Log Out',
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
                'Are you sure you want to log out of your account?',
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
              Row(
                children: [
                  // Cancel button
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFE0E0E0),
                        foregroundColor: const Color(0xFF141413),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'DMSans',
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Logout button
                  Expanded(
                    child: Obx(
                      () => TextButton(
                        onPressed: isLoggingOut.value
                            ? null
                            : () async {
                                // Set loading state
                                isLoggingOut.value = true;

                                // Call logout API and clear local data
                                try {
                                  await _authService.logout();
                                } catch (e) {
                                  print('Logout error: $e');
                                  // Continue with navigation even if API fails
                                } finally {
                                  isLoggingOut.value = false;
                                }

                                // Close dialog and navigate to join screen
                                Get.back();
                                Get.offAllNamed('/join');
                              },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          disabledBackgroundColor: Colors.red.withValues(alpha: 0.6),
                        ),
                        child: isLoggingOut.value
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text(
                                'Log Out',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'DMSans',
                                ),
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
      barrierDismissible: true,
    );
  }
}
