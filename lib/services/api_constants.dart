class ApiConstants {
  // Base URL
  static const String baseUrl = 'https://api.refresh-pma.staging.appstackstudios.com';

  // API Token for authentication
  static const String apiToken = 'cf6c0327-2768-493b-889f-59a33b9f8b6e';

  // Timeout
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds

  // ========== Auth Endpoints ==========
  static const String register = '/api/user'; // Signup endpoint
  static const String sendOtpEmail = '/api/user/send-otp/mail'; // Send OTP via email
  static const String verifyOtpRegister = '/api/user/verify-otp/register'; // Verify OTP for signup/register
  static const String verifyOtpForgotPassword = '/api/user/verify-otp/forgot-password'; // Verify OTP for forgot password
  static const String login = '/api/user/login'; // Login endpoint
  static const String socialLogin = '/api/user/social-login'; // Social login (Google, Apple, etc.)
  static const String logout = '/api/user/logout';
  static const String setPassword = '/api/user/set-password'; // Set new password (reset password)
  static const String changePassword = '/api/user/change-password'; // Change password (logged in user)
  static const String toggleNotification = '/api/user/toggle-notification'; // Toggle push notification
  static const String refreshToken = '/api/user/refresh-token'; // TODO: Confirm
  static const String user = '/api/user'; // User profile (GET, PATCH, DELETE)

  // ========== User Endpoints ==========
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/profile';
  static const String uploadProfileImage = '/user/upload-image';

  // ========== Home Endpoints ==========
  static const String getHomeData = '/home';

  // ========== Referral Endpoints ==========
  static const String getReferrals = '/referrals';
  static const String getReferralDetails = '/referrals/details';

  // ========== Points & Rewards Endpoints ==========
  static const String getPointsHistory = '/points/history';
  static const String getRewardTiers = '/rewards/tiers';
  static const String getRewards = '/rewards';

  // ========== Wallet Endpoints ==========
  static const String getWalletBalance = '/wallet/balance';
  static const String getWalletTransactions = '/wallet/transactions';

  // ========== FAQ & Support Endpoints ==========
  static const String getFaqs = '/api/user/faq';
  static const String contactUs = '/contact';

  // ========== Notifications ==========
  static const String getNotifications = '/notifications';
  static const String markNotificationRead = '/notifications/mark-read';

  // ========== Payment ==========
  static const String getPaymentQuestions = '/payment/questions';
  static const String submitPaymentApplication = '/payment/submit';

  // ========== How to Earn ==========
  static const String getHowToEarn = '/earn/how-to-earn';
}
