import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/storage_service.dart';
import '../../services/auth_service.dart';
import '../../widgets/custom_snackbar.dart';

class ProfileSettingsController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();
  final AuthService _authService = Get.find<AuthService>();

  // Form key
  final formKey = GlobalKey<FormState>();

  // Text controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();

  // Loading state
  final RxBool isLoading = false.obs;
  final RxBool isDeleting = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    super.onClose();
  }

  // Load user profile data
  void loadUserProfile() {
    // Load from storage
    final userName = _storageService.getUserName() ?? '';
    final userEmail = _storageService.getUserEmail() ?? '';
    final userMobile = _storageService.getUserMobile() ?? '';
    final userDob = _storageService.getUserDob() ?? '';

    // Split name into first and last name if available
    final nameParts = userName.split(' ');
    if (nameParts.isNotEmpty) {
      firstNameController.text = nameParts[0];
      if (nameParts.length > 1) {
        lastNameController.text = nameParts.sublist(1).join(' ');
      }
    }

    emailController.text = userEmail;
    phoneController.text = userMobile;

    // Format DOB from YYYY-MM-DD to MM/DD/YYYY if available
    if (userDob.isNotEmpty) {
      try {
        final parts = userDob.split('-');
        if (parts.length == 3) {
          // Convert from YYYY-MM-DD to MM/DD/YYYY
          dobController.text = '${parts[1]}/${parts[2]}/${parts[0]}';
        } else {
          dobController.text = userDob;
        }
      } catch (e) {
        dobController.text = userDob;
      }
    }
  }

  // Validation methods
  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'First name is required';
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Last name is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? validateDOB(String? value) {
    // DOB is optional, so no validation if empty
    if (value == null || value.isEmpty) {
      return null;
    }
    // Basic format check for MM/DD/YYYY
    final RegExp dobRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    if (!dobRegex.hasMatch(value)) {
      return 'Please use MM/DD/YYYY format';
    }
    return null;
  }

  // Date picker for DOB
  Future<void> selectDOB(BuildContext context) async {
    // Parse current DOB if available
    DateTime? initialDate;
    if (dobController.text.isNotEmpty) {
      try {
        final parts = dobController.text.split('/');
        if (parts.length == 3) {
          initialDate = DateTime(
            int.parse(parts[2]), // year
            int.parse(parts[0]), // month
            int.parse(parts[1]), // day
          );
        }
      } catch (e) {
        // Use default if parsing fails
      }
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      // Format as MM/DD/YYYY
      dobController.text =
          '${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}';
    }
  }

  // Save changes
  Future<void> saveChanges() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    try {
      // Convert DOB from MM/DD/YYYY to YYYY-MM-DD for API
      String? dobForApi;
      if (dobController.text.isNotEmpty) {
        try {
          final parts = dobController.text.split('/');
          if (parts.length == 3) {
            dobForApi = '${parts[2]}-${parts[0]}-${parts[1]}'; // YYYY-MM-DD
          }
        } catch (e) {
          print('⚠️ DOB conversion error: $e');
        }
      }

      // Call API to update profile
      final response = await _authService.updateProfile(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        mobileNo: phoneController.text,
        dob: dobForApi,
      );

      // Stop loading to update UI
      isLoading.value = false;

      // Show success message
      CustomSnackbar.success(
        title: 'Success',
        message: response['message'] ?? 'Profile updated successfully',
      );

      // Wait briefly to ensure snackbar is visible before navigating back
      await Future.delayed(const Duration(milliseconds: 500));
      Get.back();
    } on String catch (errorMessage) {
      isLoading.value = false;
      // Error from AuthService
      CustomSnackbar.error(
        title: 'Error',
        message: errorMessage,
      );
    } catch (e) {
      isLoading.value = false;
      // Unexpected error
      CustomSnackbar.error(
        title: 'Error',
        message: 'Failed to update profile. Please try again.',
      );
    }
  }

  // Delete account - Step 1: Show password input dialog
  void deleteAccount() {
    final passwordController = TextEditingController();
    final passwordFormKey = GlobalKey<FormState>();
    final RxBool obscurePassword = true.obs;

    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: passwordFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Warning icon
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.red,
                    size: 32,
                  ),
                ),

                const SizedBox(height: 20),

                // Title
                const Text(
                  'Confirm Password',
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
                  'Please enter your password to confirm account deletion',
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

                // Password input field
                Obx(
                  () => TextFormField(
                    controller: passwordController,
                    obscureText: obscurePassword.value,
                    autofocus: true,
                    style: const TextStyle(
                      color: Color(0xFF141413),
                      fontSize: 15,
                      fontFamily: 'DMSans',
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      hintStyle: const TextStyle(
                        color: Color(0xFF141413),
                        fontSize: 15,
                        fontFamily: 'DMSans',
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF6F6F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: const Color(0xFF7C8086),
                        ),
                        onPressed: () => obscurePassword.value = !obscurePassword.value,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Buttons
                Row(
                  children: [
                    // Cancel button
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Get.back();
                          // Dispose after dialog is closed
                          Future.delayed(const Duration(milliseconds: 100), () {
                            passwordController.dispose();
                          });
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

                    // Continue button
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          if (passwordFormKey.currentState!.validate()) {
                            final password = passwordController.text;
                            Get.back(); // Close password dialog
                            // Dispose after dialog is closed
                            Future.delayed(const Duration(milliseconds: 100), () {
                              passwordController.dispose();
                            });
                            _confirmDeleteAccount(password); // Show confirmation dialog
                          }
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
                          'Continue',
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
      barrierDismissible: true,
    );
  }

  // Delete account - Step 2: Show confirmation dialog and call API
  void _confirmDeleteAccount(String password) {
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
              // Warning icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.warning_rounded,
                  color: Colors.red,
                  size: 32,
                ),
              ),

              const SizedBox(height: 20),

              // Title
              const Text(
                'Delete Account',
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
                'You are going to delete your account. This action cannot be undone. Are you sure?',
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
                        'No, Keep It',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'DMSans',
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Delete button
                  Expanded(
                    child: Obx(
                      () => TextButton(
                        onPressed: isDeleting.value
                            ? null
                            : () async {
                                // Set loading state
                                isDeleting.value = true;

                                try {
                                  // Call API to delete account with password
                                  final response = await _authService.deleteAccount(
                                    password: password,
                                  );

                                  // Close dialog
                                  Get.back();

                                  // Show success message
                                  CustomSnackbar.success(
                                    title: 'Account Deleted',
                                    message: response['message'] ?? 'Your account has been deleted successfully',
                                  );

                                  // Navigate to join screen
                                  Get.offAllNamed('/join');
                                } on String catch (errorMessage) {
                                  // Close dialog
                                  Get.back();

                                  // Show error message
                                  CustomSnackbar.error(
                                    title: 'Error',
                                    message: errorMessage,
                                  );
                                } catch (e) {
                                  // Close dialog
                                  Get.back();

                                  // Show error message
                                  CustomSnackbar.error(
                                    title: 'Error',
                                    message: 'Failed to delete account. Please try again.',
                                  );
                                } finally {
                                  isDeleting.value = false;
                                }
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
                        child: isDeleting.value
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text(
                                'Yes, Delete It',
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
