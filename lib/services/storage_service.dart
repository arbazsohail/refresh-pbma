import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService extends GetxService {
  late SharedPreferences _prefs;

  // Storage Keys
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';
  static const String _userNameKey = 'user_name';
  static const String _userEmailKey = 'user_email';
  static const String _userMobileKey = 'user_mobile';
  static const String _userDobKey = 'user_dob';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _biometricEnabledKey = 'biometric_enabled';

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  // Token Management
  Future<void> saveToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    return _prefs.getString(_tokenKey);
  }

  Future<void> clearToken() async {
    await _prefs.remove(_tokenKey);
  }

  // User Data Management
  Future<void> saveUserData({
    required String userId,
    required String userName,
    required String userEmail,
    String? userMobile,
    String? userDob,
  }) async {
    await _prefs.setString(_userIdKey, userId);
    await _prefs.setString(_userNameKey, userName);
    await _prefs.setString(_userEmailKey, userEmail);
    if (userMobile != null) {
      await _prefs.setString(_userMobileKey, userMobile);
    }
    if (userDob != null) {
      await _prefs.setString(_userDobKey, userDob);
    }
    await _prefs.setBool(_isLoggedInKey, true);
  }

  String? getUserId() => _prefs.getString(_userIdKey);
  String? getUserName() => _prefs.getString(_userNameKey);
  String? getUserEmail() => _prefs.getString(_userEmailKey);
  String? getUserMobile() => _prefs.getString(_userMobileKey);
  String? getUserDob() => _prefs.getString(_userDobKey);
  bool isLoggedIn() => _prefs.getBool(_isLoggedInKey) ?? false;

  // Biometric Management
  Future<void> saveBiometricEnabled(bool enabled) async {
    await _prefs.setBool(_biometricEnabledKey, enabled);
  }

  bool isBiometricEnabled() => _prefs.getBool(_biometricEnabledKey) ?? false;

  // Clear All Data
  Future<void> clearAll() async {
    await _prefs.clear();
  }

  // Clear only user session data (keep app settings like FCM token, onboarding status, etc.)
  Future<void> clearSession() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_userIdKey);
    await _prefs.remove(_userNameKey);
    await _prefs.remove(_userEmailKey);
    await _prefs.remove(_userMobileKey);
    await _prefs.remove(_userDobKey);
    await _prefs.remove(_isLoggedInKey);
    // Note: We keep FCM token, onboarding status, and other app-level settings
  }

  // Generic Storage Methods
  Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String? getString(String key) => _prefs.getString(key);

  Future<void> saveBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  bool? getBool(String key) => _prefs.getBool(key);

  Future<void> saveInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  int? getInt(String key) => _prefs.getInt(key);

  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }
}
