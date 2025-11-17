import 'package:get/get.dart';
import 'app_routes.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/auth/join_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/auth/verify_email_screen.dart';
import '../screens/auth/verify_otp_screen.dart';
import '../screens/auth/forgot_password_screen.dart';
import '../screens/auth/create_new_password_screen.dart';
import '../screens/main/main_page.dart';
import '../screens/notification/notification_screen.dart';
import '../screens/profile/profile_settings_screen.dart';
import '../screens/password/change_password_settings_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/faq/faq_screen.dart';
import '../screens/referral/referral_details_screen.dart';
import '../screens/points/points_tiers_screen.dart';
import '../screens/earn/how_to_earn_screen.dart';
import '../screens/scanner/qr_scanner_screen.dart';
import '../controllers/onboarding_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/signup_controller.dart';
import '../controllers/verify_email_controller.dart';
import '../controllers/verify_otp_controller.dart';
import '../controllers/forgot_password_controller.dart';
import '../controllers/create_new_password_controller.dart';
import '../controllers/main_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/notification_controller.dart';
import '../controllers/profile_settings_controller.dart';
import '../controllers/change_password_settings_controller.dart';
import '../controllers/settings_controller.dart';
import '../controllers/faq_controller.dart';
import '../controllers/referrals_controller.dart';
import '../controllers/referral_details_controller.dart';
import '../controllers/points_tiers_controller.dart';
import '../controllers/how_to_earn_controller.dart';
import '../controllers/explore_controller.dart';
import '../controllers/wallet_controller.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OnboardingController>(() => OnboardingController());
      }),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.join,
      page: () => const JoinScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<LoginController>(() => LoginController());
      }),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SignupController>(() => SignupController());
      }),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.verifyEmail,
      page: () => const VerifyEmailScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<VerifyEmailController>(() => VerifyEmailController());
      }),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.verifyOTP,
      page: () => const VerifyOTPScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<VerifyOTPController>(() => VerifyOTPController());
      }),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
      }),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.createNewPassword,
      page: () => const CreateNewPasswordScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<CreateNewPasswordController>(
            () => CreateNewPasswordController());
      }),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.mainPage,
      page: () => const MainPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MainController>(() => MainController());
        Get.lazyPut<HomeController>(() => HomeController());
        Get.lazyPut<ReferralsController>(() => ReferralsController());
        Get.lazyPut<ExploreController>(() => ExploreController());
        Get.lazyPut<WalletController>(() => WalletController());
      }),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.notification,
      page: () => const NotificationScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<NotificationController>(() => NotificationController());
      }),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SettingsController>(() => SettingsController());
      }),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.profileSettings,
      page: () => const ProfileSettingsScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ProfileSettingsController>(() => ProfileSettingsController());
      }),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.changePasswordSettings,
      page: () => const ChangePasswordSettingsScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ChangePasswordSettingsController>(() => ChangePasswordSettingsController());
      }),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.faq,
      page: () => const FaqScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<FaqController>(() => FaqController());
      }),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.referralDetails,
      page: () => const ReferralDetailsScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ReferralDetailsController>(() => ReferralDetailsController());
      }),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.pointsTiers,
      page: () => const PointsTiersScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<PointsTiersController>(() => PointsTiersController());
      }),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.howToEarn,
      page: () => const HowToEarnScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HowToEarnController>(() => HowToEarnController());
      }),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.qrScanner,
      page: () => const QRScannerScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Add more routes here as you build your app
  ];
}
