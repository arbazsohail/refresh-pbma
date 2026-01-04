import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../../services/auth_service.dart';
import '../../widgets/custom_snackbar.dart';

class VerifyEmailController extends GetxController {
  // Services
  final AuthService _authService = Get.find<AuthService>();

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
      // Send OTP based on selected method
      if (selectedMethod.value == 'email') {
        // Send OTP to email
        final response = await _authService.sendOtpEmail(email: email.value);

        CustomSnackbar.success(
          title: 'Success',
          message: response['message'] ?? 'OTP sent to your email',
        );
      } else {
        // TODO: Send OTP to phone when endpoint is available
        CustomSnackbar.warning(
          title: 'Coming Soon',
          message: 'Phone OTP is not yet implemented',
        );
        isLoading.value = false;
        return;
      }

      // Navigate to OTP verification screen
      Get.toNamed(
        AppRoutes.verifyOTP,
        arguments: {
          'email': email.value,
          'phoneNumber': phoneNumber.value,
          'verificationType': selectedMethod.value,
        },
      );
    } on String catch (errorMessage) {
      CustomSnackbar.error(
        title: 'Error',
        message: errorMessage,
      );
    } catch (e) {
      CustomSnackbar.error(
        title: 'Error',
        message: 'Failed to send OTP. Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
