import 'package:get/get.dart';
import '../routes/app_routes.dart';

class VerifyEmailController extends GetxController {
  final RxString email = ''.obs;
  final RxString phoneNumber = ''.obs;
  final RxString selectedMethod = 'email'.obs; // 'email' or 'phone'
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Get email and phone from arguments
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      if (args.containsKey('email')) {
        email.value = args['email'] as String;
      }
      if (args.containsKey('phoneNumber')) {
        phoneNumber.value = args['phoneNumber'] as String;
      }
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

  // Mask phone for display
  String get maskedPhone {
    if (phoneNumber.value.isEmpty) return '';
    // Simple masking: show last 4 digits
    if (phoneNumber.value.length < 4) return phoneNumber.value;
    return '**** **** ${phoneNumber.value.substring(phoneNumber.value.length - 4)}';
  }

  void selectMethod(String method) {
    selectedMethod.value = method;
  }

  // Send OTP to email or phone
  Future<void> getOTP() async {
    isLoading.value = true;

    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Navigate to OTP verification screen
      Get.toNamed(
        AppRoutes.verifyOTP,
        arguments: {
          'email': email.value,
          'phoneNumber': phoneNumber.value,
          'verificationType': selectedMethod.value,
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
