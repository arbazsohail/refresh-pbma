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
    // TODO: Navigate to contact us screen
    Get.snackbar('Contact Us', 'Coming soon');
  }

  // Navigate to Terms & Conditions
  void navigateToTermsAndConditions() {
    // TODO: Navigate to terms screen
    Get.snackbar('Terms & Conditions', 'Coming soon');
  }

  // Navigate to Privacy Policy
  void navigateToPrivacyPolicy() {
    // TODO: Navigate to privacy policy screen
    Get.snackbar('Privacy Policy', 'Coming soon');
  }

  // Log out
  void logOut() {
    Get.defaultDialog(
      title: 'Log Out',
      middleText: 'Are you sure you want to log out?',
      textConfirm: 'Yes',
      textCancel: 'Cancel',
      confirmTextColor: Get.theme.colorScheme.onPrimary,
      onConfirm: () {
        // Clear user data
        _storageService.clearAll();
        // Navigate to login screen
        Get.back();
        Get.offAllNamed('/login');
      },
    );
  }
}
