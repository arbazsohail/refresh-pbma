import 'dart:io';
import 'package:get/get.dart';
import 'api_service.dart';
import 'api_constants.dart';
import 'storage_service.dart';
import 'firebase_service.dart';
import 'google_auth_service.dart';

/// Authentication Service
/// Handles all authentication-related API calls
class AuthService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();
  final StorageService _storageService = Get.find<StorageService>();

  /// Get device type (android/ios)
  String _getDeviceType() {
    if (Platform.isAndroid) {
      return 'android';
    } else if (Platform.isIOS) {
      return 'ios';
    }
    return 'android'; // default
  }

  /// Get device token for push notifications
  String _getDeviceToken() {
    try {
      final firebaseService = Get.find<FirebaseService>();
      return firebaseService.fcmToken ?? _storageService.getString('fcm_token') ?? '';
    } catch (e) {
      // FirebaseService not initialized yet, fallback to storage
      return _storageService.getString('fcm_token') ?? '';
    }
  }

  /// Register/Signup a new user
  ///
  /// Parameters:
  /// - [firstName]: User's first name
  /// - [lastName]: User's last name
  /// - [email]: User's email address
  /// - [mobileNo]: User's mobile number with country code (e.g., "923456678666")
  /// - [dob]: Date of birth in format YYYY-MM-DD (e.g., "1995-12-21")
  /// - [password]: User's password
  /// - [confirmPassword]: Password confirmation
  ///
  /// Returns: Response data from server
  /// Throws: String error message on failure
  Future<Map<String, dynamic>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String mobileNo,
    required String dob,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final requestBody = {
        'firstname': firstName.trim(),
        'lastname': lastName.trim(),
        'email': email.trim().toLowerCase(),
        'mobile_no': mobileNo.trim(),
        'dob': dob,
        'password': password,
        'confirm_password': confirmPassword,
        'device_type': _getDeviceType(),
        'device_token': _getDeviceToken(),
      };

      print('📤 Register Request: $requestBody');

      final response = await _apiService.post(
        ApiConstants.register,
        data: requestBody,
      );

      print('📥 Register Response: ${response.data}');

      // API Response format:
      // {
      //   "code": 200,
      //   "message": "User Created Successfully",
      //   "data": {}
      // }

      // Check if registration was successful
      if (response.data['code'] == 200) {
        // Note: No token is returned on registration
        // User needs to verify email/OTP before login
        return response.data;
      } else {
        // Unexpected response format
        throw response.data['message'] ?? 'Registration failed';
      }
    } catch (e) {
      print('❌ Register Error: $e');
      rethrow;
    }
  }

  /// Login user
  ///
  /// Parameters:
  /// - [email]: User's email address
  /// - [password]: User's password
  ///
  /// Returns: Response data from server
  /// Throws: String error message on failure
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final requestBody = {
        'email': email.trim().toLowerCase(),
        'password': password,
        'device_type': _getDeviceType(),
        'device_token': _getDeviceToken(),
      };

      print('📤 Login Request: ${requestBody.keys}'); // Don't log password

      final response = await _apiService.post(
        ApiConstants.login,
        data: requestBody,
      );

      print('📥 Login Response: ${response.data}');

      // API Response format:
      // {
      //   "code": 200,
      //   "message": "User logged in successfully!",
      //   "data": {
      //     "id": 10,
      //     "firstname": "Abc",
      //     "lastname": "Xyz",
      //     "email": "user@gmail.com",
      //     "api_token": "...",
      //     "mobile_no": "+12135754094",
      //     "dob": "2000-01-12",
      //     "code": "U56UZOF6",
      //     "total_referrals": 0,
      //     "total_points": 0,
      //     ...
      //   }
      // }

      if (response.data['code'] == 200) {
        final data = response.data['data'];

        // Save api_token
        if (data != null && data['api_token'] != null) {
          await _storageService.saveToken(data['api_token']);
        }

        // Save user data
        if (data != null) {
          await _storageService.saveUserData(
            userId: data['id']?.toString() ?? '',
            userName: '${data['firstname'] ?? ''} ${data['lastname'] ?? ''}',
            userEmail: data['email'] ?? '',
            userMobile: data['mobile_no'],
          );
        }

        return response.data;
      } else {
        throw response.data['message'] ?? 'Login failed';
      }
    } catch (e) {
      print('❌ Login Error: $e');
      rethrow;
    }
  }

  /// Social Login (Google, Apple, Facebook, etc.)
  ///
  /// Parameters:
  /// - [name]: User's full name from social provider
  /// - [email]: User's email from social provider
  /// - [platformType]: Social platform (google, apple, facebook)
  /// - [platformId]: Unique ID from social provider
  ///
  /// Returns: Response data from server
  /// Throws: String error message on failure
  Future<Map<String, dynamic>> socialLogin({
    required String name,
    required String email,
    required String platformType,
    required String platformId,
  }) async {
    try {
      final requestBody = {
        'name': name.trim(),
        'email': email.trim().toLowerCase(),
        'device_type': _getDeviceType(),
        'device_token': _getDeviceToken(),
        'platform_type': platformType, // google, apple, facebook
        'platform_id': platformId, // Unique ID from social provider
      };

      print('📤 Social Login Request: $requestBody');

      final response = await _apiService.post(
        ApiConstants.socialLogin,
        data: requestBody,
      );

      print('📥 Social Login Response: ${response.data}');

      // API Response format (similar to regular login):
      // {
      //   "code": 200,
      //   "message": "User logged in successfully!",
      //   "data": {
      //     "id": 10,
      //     "firstname": "Abc",
      //     "lastname": "Xyz",
      //     "email": "user@gmail.com",
      //     "api_token": "...",
      //     ...
      //   }
      // }

      if (response.data['code'] == 200) {
        final data = response.data['data'];

        // Save api_token
        if (data != null && data['api_token'] != null) {
          await _storageService.saveToken(data['api_token']);
        }

        // Save user data
        if (data != null) {
          await _storageService.saveUserData(
            userId: data['id']?.toString() ?? '',
            userName: '${data['firstname'] ?? ''} ${data['lastname'] ?? ''}',
            userEmail: data['email'] ?? '',
            userMobile: data['mobile_no'],
          );
        }

        return response.data;
      } else {
        throw response.data['message'] ?? 'Social login failed';
      }
    } catch (e) {
      print('❌ Social Login Error: $e');
      rethrow;
    }
  }

  /// Verify OTP for Signup/Register
  ///
  /// Parameters:
  /// - [email]: User's email address
  /// - [otp]: OTP code
  ///
  /// Returns: Response data from server
  /// Throws: String error message on failure
  Future<Map<String, dynamic>> verifyOtpSignup({
    required String email,
    required String otp,
  }) async {
    try {
      final requestBody = {
        'email': email.trim().toLowerCase(),
        'otp': otp,
        'device_type': _getDeviceType(),
        'device_token': _getDeviceToken(),
      };

      print('📤 Verify OTP (Register) Request: $requestBody');

      final response = await _apiService.post(
        ApiConstants.verifyOtpRegister,
        data: requestBody,
      );

      print('📥 Verify OTP (Register) Response: ${response.data}');

      // API Response format:
      // {
      //   "code": 200,
      //   "message": "OTP verified",
      //   "data": {
      //     "id": 10,
      //     "firstname": "Abc",
      //     "lastname": "Xyz",
      //     "email": "user@gmail.com",
      //     "api_token": "...",
      //     "mobile_no": "+12135754094",
      //     "dob": "2000-01-12",
      //     "code": "U56UZOF6",
      //     ...
      //   }
      // }

      if (response.data['code'] == 200) {
        final data = response.data['data'];

        // Save api_token if provided after OTP verification
        if (data != null && data['api_token'] != null) {
          await _storageService.saveToken(data['api_token']);
        }

        // Save user data
        if (data != null) {
          await _storageService.saveUserData(
            userId: data['id']?.toString() ?? '',
            userName: '${data['firstname'] ?? ''} ${data['lastname'] ?? ''}',
            userEmail: data['email'] ?? '',
            userMobile: data['mobile_no'],
          );
        }

        return response.data;
      } else {
        throw response.data['message'] ?? 'OTP verification failed';
      }
    } catch (e) {
      print('❌ Verify OTP (Signup) Error: $e');
      rethrow;
    }
  }

  /// Verify OTP for Forgot Password
  ///
  /// Parameters:
  /// - [email]: User's email address
  /// - [otp]: OTP code
  ///
  /// Returns: Response data from server
  /// Throws: String error message on failure
  Future<Map<String, dynamic>> verifyOtpForgotPassword({
    required String email,
    required String otp,
  }) async {
    try {
      final requestBody = {
        'email': email.trim().toLowerCase(),
        'otp': otp,
      };

      print('📤 Verify OTP (Forgot Password) Request: $requestBody');

      final response = await _apiService.post(
        ApiConstants.verifyOtpForgotPassword,
        data: requestBody,
      );

      print('📥 Verify OTP (Forgot Password) Response: ${response.data}');

      // API Response format:
      // {
      //   "code": 200,
      //   "message": "OTP verified",
      //   "data": {
      //     "api_token": "..."
      //   }
      // }

      if (response.data['code'] == 200) {
        final data = response.data['data'];

        // Save api_token for setting new password
        if (data != null && data['api_token'] != null) {
          await _storageService.saveToken(data['api_token']);
          print('✅ Forgot password token saved');
        }

        return response.data;
      } else {
        throw response.data['message'] ?? 'OTP verification failed';
      }
    } catch (e) {
      print('❌ Verify OTP (Forgot Password) Error: $e');
      rethrow;
    }
  }

  /// Send OTP to Email
  ///
  /// Parameters:
  /// - [email]: User's email address
  ///
  /// Returns: Response data from server
  /// Throws: String error message on failure
  Future<Map<String, dynamic>> sendOtpEmail({
    required String email,
  }) async {
    try {
      final requestBody = {
        'email': email.trim().toLowerCase(),
      };

      print('📤 Send OTP Email Request: $requestBody');

      final response = await _apiService.post(
        ApiConstants.sendOtpEmail,
        data: requestBody,
      );

      print('📥 Send OTP Email Response: ${response.data}');

      // API Response format:
      // {
      //   "code": 200,
      //   "message": "OTP sent successfully",
      //   "data": {}
      // }

      if (response.data['code'] == 200) {
        return response.data;
      } else {
        throw response.data['message'] ?? 'Failed to send OTP';
      }
    } catch (e) {
      print('❌ Send OTP Email Error: $e');
      rethrow;
    }
  }

  /// Set/Reset Password
  ///
  /// Parameters:
  /// - [newPassword]: New password
  /// - [confirmPassword]: Password confirmation
  ///
  /// Returns: Response data from server
  /// Throws: String error message on failure
  Future<Map<String, dynamic>> setPassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final requestBody = {
        'new_password': newPassword,
        'confirm_password': confirmPassword,
      };

      print('📤 Set Password Request: ${requestBody.keys}'); // Don't log password

      final response = await _apiService.post(
        ApiConstants.setPassword,
        data: requestBody,
      );

      print('📥 Set Password Response: ${response.data}');

      // API Response format:
      // {
      //   "code": 200,
      //   "message": "Password set successfully",
      //   "data": {}
      // }

      if (response.data['code'] == 200) {
        return response.data;
      } else {
        throw response.data['message'] ?? 'Failed to set password';
      }
    } catch (e) {
      print('❌ Set Password Error: $e');
      rethrow;
    }
  }

  /// Logout user
  /// Calls logout API endpoint, signs out from social providers, and clears local storage
  ///
  /// Returns: void
  /// Note: Local data is cleared even if API call fails
  Future<void> logout() async {
    try {
      print('📤 Logout Request');

      final response = await _apiService.post(ApiConstants.logout);

      print('📥 Logout Response: ${response.data}');

      // API Response format:
      // {
      //   "code": 200,
      //   "message": "User logged out successfully",
      //   "data": {}
      // }

      if (response.data['code'] == 200) {
        print('✅ Logout successful');
      }
    } catch (e) {
      print('⚠️ Logout API Error: $e');
      // Continue with local logout even if API fails
    } finally {
      // Sign out from Google if user was logged in with Google
      try {
        final googleAuthService = Get.find<GoogleAuthService>();
        await googleAuthService.signOut();
        print('✅ Google sign out successful');
      } catch (e) {
        print('⚠️ Google sign out error (user may not be signed in with Google): $e');
        // Continue with logout even if Google sign out fails
      }

      // Clear session data (keep app settings like FCM token, onboarding)
      await _storageService.clearSession();
      print('🗑️ User session cleared');
    }
  }

  /// Update user profile
  ///
  /// Parameters:
  /// - [firstName]: User's first name (optional)
  /// - [lastName]: User's last name (optional)
  /// - [mobileNo]: User's mobile number (optional)
  /// - [dob]: Date of birth (optional)
  ///
  /// Returns: Response data from server with updated user info
  /// Throws: String error message on failure
  Future<Map<String, dynamic>> updateProfile({
    String? firstName,
    String? lastName,
    String? mobileNo,
    String? dob,
  }) async {
    try {
      // Build request body with only provided fields
      final Map<String, dynamic> requestBody = {};

      if (firstName != null) requestBody['firstname'] = firstName.trim();
      if (lastName != null) requestBody['lastname'] = lastName.trim();
      if (mobileNo != null) requestBody['mobile_no'] = mobileNo.trim();
      if (dob != null) requestBody['dob'] = dob;

      print('📤 Update Profile Request: $requestBody');

      final response = await _apiService.patch(
        ApiConstants.user,
        data: requestBody,
      );

      print('📥 Update Profile Response: ${response.data}');

      // API Response format:
      // {
      //   "code": 200,
      //   "message": "Profile updated successfully",
      //   "data": {
      //     "id": 10,
      //     "firstname": "Updated",
      //     "lastname": "Name",
      //     "email": "user@gmail.com",
      //     ...
      //   }
      // }

      if (response.data['code'] == 200) {
        final data = response.data['data'];

        // Update local user data with new info
        if (data != null) {
          // Update api_token if provided in response
          if (data['api_token'] != null) {
            await _storageService.saveToken(data['api_token']);
          }

          // Update user data
          await _storageService.saveUserData(
            userId: data['id']?.toString() ?? '',
            userName: '${data['firstname'] ?? ''} ${data['lastname'] ?? ''}',
            userEmail: data['email'] ?? '',
            userMobile: data['mobile_no'],
          );
        }

        return response.data;
      } else {
        throw response.data['message'] ?? 'Failed to update profile';
      }
    } catch (e) {
      print('❌ Update Profile Error: $e');
      rethrow;
    }
  }

  /// Delete user account
  ///
  /// Parameters:
  /// - [password]: User's current password for verification
  ///
  /// Returns: Response data from server
  /// Throws: String error message on failure
  /// Note: After successful deletion, local data is cleared and user is logged out from all services
  Future<Map<String, dynamic>> deleteAccount({
    required String password,
  }) async {
    try {
      final requestBody = {
        'password': password,
      };

      print('📤 Delete Account Request: ${requestBody.keys}'); // Don't log password

      final response = await _apiService.delete(
        ApiConstants.user,
        data: requestBody,
      );

      print('📥 Delete Account Response: ${response.data}');

      // API Response format:
      // {
      //   "code": 200,
      //   "message": "Account deleted successfully",
      //   "data": {}
      // }

      if (response.data['code'] == 200) {
        // Sign out from Google if user was logged in with Google
        try {
          final googleAuthService = Get.find<GoogleAuthService>();
          await googleAuthService.signOut();
          print('✅ Google sign out successful');
        } catch (e) {
          print('⚠️ Google sign out error (user may not be signed in with Google): $e');
          // Continue with account deletion even if Google sign out fails
        }

        // Clear local data after successful account deletion
        await _storageService.clearAll();
        print('✅ Account deleted and local data cleared');

        return response.data;
      } else {
        throw response.data['message'] ?? 'Failed to delete account';
      }
    } catch (e) {
      print('❌ Delete Account Error: $e');
      rethrow;
    }
  }

  /// Change password for logged in user
  ///
  /// Parameters:
  /// - [currentPassword]: User's current password
  /// - [newPassword]: New password
  /// - [confirmPassword]: Password confirmation
  ///
  /// Returns: Response data from server
  /// Throws: String error message on failure
  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final requestBody = {
        'current_password': currentPassword,
        'new_password': newPassword,
        'confirm_password': confirmPassword,
      };

      print('📤 Change Password Request: ${requestBody.keys}'); // Don't log passwords

      final response = await _apiService.post(
        ApiConstants.changePassword,
        data: requestBody,
      );

      print('📥 Change Password Response: ${response.data}');

      // API Response format:
      // {
      //   "code": 200,
      //   "message": "Password changed successfully",
      //   "data": {}
      // }

      if (response.data['code'] == 200) {
        return response.data;
      } else {
        throw response.data['message'] ?? 'Failed to change password';
      }
    } catch (e) {
      print('❌ Change Password Error: $e');
      rethrow;
    }
  }

  /// Toggle push notification
  ///
  /// Returns: Response data from server
  /// Throws: String error message on failure
  Future<Map<String, dynamic>> toggleNotification() async {
    try {
      print('📤 Toggle Notification Request');

      final response = await _apiService.post(ApiConstants.toggleNotification);

      print('📥 Toggle Notification Response: ${response.data}');

      // API Response format:
      // {
      //   "code": 200,
      //   "message": "Notification toggled successfully",
      //   "data": {
      //     "push_notification": true/false
      //   }
      // }

      if (response.data['code'] == 200) {
        return response.data;
      } else {
        throw response.data['message'] ?? 'Failed to toggle notification';
      }
    } catch (e) {
      print('❌ Toggle Notification Error: $e');
      rethrow;
    }
  }

  /// Get FAQs
  ///
  /// Returns: Response data from server with list of FAQs
  /// Throws: String error message on failure
  Future<Map<String, dynamic>> getFaqs() async {
    try {
      print('📤 Get FAQs Request');

      final response = await _apiService.get(ApiConstants.getFaqs);

      print('📥 Get FAQs Response: ${response.data}');

      // API Response format:
      // {
      //   "code": 200,
      //   "message": "Retrieved data successfully!.",
      //   "data": [
      //     {
      //       "id": 1,
      //       "title": "Question 01",
      //       "content": "lorem ipsum",
      //       "createdAt": "2025-11-25T09:56:47.000Z",
      //       "updatedAt": "2025-11-25T09:56:47.000Z"
      //     }
      //   ]
      // }

      if (response.data['code'] == 200) {
        return response.data;
      } else {
        throw response.data['message'] ?? 'Failed to fetch FAQs';
      }
    } catch (e) {
      print('❌ Get FAQs Error: $e');
      rethrow;
    }
  }

  /// Check if user is logged in
  bool isLoggedIn() {
    return _storageService.isLoggedIn();
  }

  /// Get current auth token
  Future<String?> getToken() async {
    return await _storageService.getToken();
  }
}
