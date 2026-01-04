import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import '../../services/storage_service.dart';
import '../../widgets/custom_snackbar.dart';

class BiometricSetupController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();
  final StorageService _storageService = Get.find<StorageService>();

  // Observable states
  final RxBool isLoading = false.obs;
  final RxString biometricType = 'fingerprint'.obs; // 'face' or 'fingerprint'
  final RxBool biometricAvailable = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkBiometricAvailability();
  }

  // Check if biometric is available on device
  Future<void> checkBiometricAvailability() async {
    try {
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await auth.isDeviceSupported();

      biometricAvailable.value = canAuthenticate;

      if (canAuthenticate) {
        // Get available biometrics
        final List<BiometricType> availableBiometrics =
            await auth.getAvailableBiometrics();

        // Determine biometric type
        if (availableBiometrics.contains(BiometricType.face)) {
          biometricType.value = 'face';
        } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
          biometricType.value = 'fingerprint';
        } else {
          biometricType.value = 'fingerprint'; // Default
        }
      }
    } on PlatformException catch (e) {
      print('Error checking biometric availability: $e');
      biometricAvailable.value = false;
    }
  }

  // Enable biometric authentication
  Future<void> enableBiometric() async {
    if (!biometricAvailable.value) {
      CustomSnackbar.error(
        title: 'Not Available',
        message: 'Biometric authentication is not available on this device',
      );
      return;
    }

    isLoading.value = true;

    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: biometricType.value == 'face'
            ? 'Please authenticate using Face ID'
            : 'Please authenticate using your fingerprint',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (didAuthenticate) {
        // Save biometric preference
        await _storageService.saveBiometricEnabled(true);

        CustomSnackbar.success(
          title: 'Success',
          message: biometricType.value == 'face'
              ? 'Face ID has been enabled successfully'
              : 'Fingerprint has been enabled successfully',
        );

        // Navigate to main page after short delay
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.offAllNamed('/main');
        });
      } else {
        CustomSnackbar.warning(
          title: 'Authentication Failed',
          message: 'Please try again',
        );
      }
    } on PlatformException catch (e) {
      print('Error authenticating: $e');
      CustomSnackbar.error(
        title: 'Error',
        message: 'Failed to enable biometric authentication',
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Skip biometric setup
  void skip() {
    // Save biometric as disabled
    _storageService.saveBiometricEnabled(false);

    // Navigate to main page
    Get.offAllNamed('/main');
  }
}
