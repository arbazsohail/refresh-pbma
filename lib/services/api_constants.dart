class ApiConstants {
  static const String baseUrl = 'https://api.refreshpbma.com/api'; // Placeholder URL

  // Auth Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String profile = '/auth/profile';

  // Timeout
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
}
