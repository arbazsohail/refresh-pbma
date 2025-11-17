import 'package:get/get.dart';
import '../routes/app_routes.dart';

class VerifyEmailController extends GetxController {
  final RxString email = ''.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Get email from arguments
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args.containsKey('email')) {
      email.value = args['email'] as String;
    }
  }

  // Mask email for display
  String get maskedEmail {
    if (email.value.isEmpty) return '';

    final parts = email.value.split('@');
    if (parts.length != 2) return email.value;

    final username = parts[0];
    final domain = parts[1];

    if (username.length <= 2) {
      return email.value;
    }

    // Show first 2 characters, mask the rest with asterisks
    final masked = username.substring(0, 2) + '*' * (username.length - 2);
    return '$masked@$domain';
  }

  // Send OTP to email
  Future<void> getOTP() async {
    isLoading.value = true;

    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Navigate to OTP verification screen
      Get.toNamed(
        AppRoutes.verifyOTP,
        arguments: {
          'email': email.value,
          'verificationType': 'email',
        },
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send OTP. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
