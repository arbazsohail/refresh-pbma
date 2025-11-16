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
import '../controllers/onboarding_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/signup_controller.dart';
import '../controllers/verify_email_controller.dart';
import '../controllers/verify_otp_controller.dart';
import '../controllers/forgot_password_controller.dart';
import '../controllers/create_new_password_controller.dart';
import '../controllers/main_controller.dart';

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
      }),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Add more routes here as you build your app
  ];
}
