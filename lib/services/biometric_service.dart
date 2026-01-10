import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'storage_service.dart';

/// Biometric Authentication Service
/// Handles fingerprint and face ID authentication
class BiometricService extends GetxService {
  final LocalAuthentication _localAuth = LocalAuthentication();
  final StorageService _storageService = Get.find<StorageService>();

  /// Check if device supports biometric authentication
  Future<bool> isBiometricAvailable() async {
    try {
      final isAvailable = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      return isAvailable && isDeviceSupported;
    } catch (e) {
      print('❌ Biometric availability check error: $e');
      return false;
    }
  }

  /// Get list of available biometric types
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
      print('❌ Get available biometrics error: $e');
      return [];
    }
  }

  /// Authenticate using biometrics
  /// Returns: true if authentication successful, false otherwise
  Future<bool> authenticate({
    String localizedReason = 'Please authenticate to continue',
    bool useErrorDialogs = true,
  }) async {
    try {
      final isAvailable = await isBiometricAvailable();
      if (!isAvailable) {
        print('⚠️ Biometric authentication not available on this device');
        return false;
      }

      final didAuthenticate = await _localAuth.authenticate(
        localizedReason: localizedReason,
        options: AuthenticationOptions(
          useErrorDialogs: useErrorDialogs,
          stickyAuth: true,
          biometricOnly: false, // Allow PIN/password fallback
        ),
      );

      if (didAuthenticate) {
        print('✅ Biometric authentication successful');
        return true;
      } else {
        print('❌ Biometric authentication failed');
        return false;
      }
    } on Exception catch (e) {
      print('❌ Biometric authentication error: $e');

      // Handle specific error codes
      if (e.toString().contains(auth_error.notAvailable)) {
        print('⚠️ Biometric not available');
      } else if (e.toString().contains(auth_error.notEnrolled)) {
        print('⚠️ No biometrics enrolled');
      } else if (e.toString().contains(auth_error.passcodeNotSet)) {
        print('⚠️ Passcode not set');
      } else if (e.toString().contains(auth_error.permanentlyLockedOut)) {
        print('⚠️ Permanently locked out');
      } else if (e.toString().contains(auth_error.lockedOut)) {
        print('⚠️ Temporarily locked out');
      }

      return false;
    }
  }

  /// Enable biometric authentication for the app
  /// This will authenticate first, then save the setting
  Future<bool> enableBiometric() async {
    try {
      // Check if biometric is available
      final isAvailable = await isBiometricAvailable();
      if (!isAvailable) {
        throw 'Biometric authentication is not available on this device';
      }

      // Authenticate to enable
      final didAuthenticate = await authenticate(
        localizedReason: 'Authenticate to enable biometric login',
      );

      if (didAuthenticate) {
        // Save biometric enabled status
        await _storageService.saveBiometricEnabled(true);
        print('✅ Biometric authentication enabled');
        return true;
      } else {
        print('❌ Authentication failed, biometric not enabled');
        return false;
      }
    } catch (e) {
      print('❌ Enable biometric error: $e');
      rethrow;
    }
  }

  /// Disable biometric authentication for the app
  Future<void> disableBiometric() async {
    await _storageService.saveBiometricEnabled(false);
    print('✅ Biometric authentication disabled');
  }

  /// Check if biometric is enabled for the app
  bool isBiometricEnabled() {
    return _storageService.isBiometricEnabled();
  }

  /// Get biometric type name for display
  Future<String> getBiometricTypeName() async {
    final biometrics = await getAvailableBiometrics();

    if (biometrics.isEmpty) {
      return 'Biometric';
    }

    if (biometrics.contains(BiometricType.face)) {
      return 'Face ID';
    } else if (biometrics.contains(BiometricType.fingerprint)) {
      return 'Fingerprint';
    } else if (biometrics.contains(BiometricType.iris)) {
      return 'Iris';
    } else {
      return 'Biometric';
    }
  }
}
