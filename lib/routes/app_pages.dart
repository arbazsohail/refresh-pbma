import 'package:get/get.dart';
import 'app_routes.dart';
import '../screens/splash_screen.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Add more routes here as you build your app
  ];
}
