import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService extends GetxService {
  late SharedPreferences _prefs;

  // Storage Keys
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';
  static const String _userNameKey = 'user_name';
  static const String _userEmailKey = 'user_email';
  static const String _isLoggedInKey = 'is_logged_in';

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
  }) async {
    await _prefs.setString(_userIdKey, userId);
    await _prefs.setString(_userNameKey, userName);
    await _prefs.setString(_userEmailKey, userEmail);
    await _prefs.setBool(_isLoggedInKey, true);
  }

  String? getUserId() => _prefs.getString(_userIdKey);
  String? getUserName() => _prefs.getString(_userNameKey);
  String? getUserEmail() => _prefs.getString(_userEmailKey);
  bool isLoggedIn() => _prefs.getBool(_isLoggedInKey) ?? false;

  // Clear All Data
  Future<void> clearAll() async {
    await _prefs.clear();
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
