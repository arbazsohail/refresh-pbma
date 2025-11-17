import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/storage_service.dart';

class SettingsController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();

  // Notification settings
  final RxBool pushNotificationsEnabled = true.obs;
  final RxBool emailUpdatesEnabled = true.obs;

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
  void togglePushNotifications(bool value) {
    pushNotificationsEnabled.value = value;
    _storageService.saveBool('pushNotifications', value);
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
                    child: TextButton(
                      onPressed: () {
                        // Clear user data
                        _storageService.clearAll();
                        // Navigate to login screen
                        Get.back();
                        Get.offAllNamed('/login');
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: const Text(
                        'Log Out',
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
      barrierDismissible: true,
    );
  }
}
