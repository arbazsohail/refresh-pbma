import 'package:get/get.dart';
import '../services/storage_service.dart';
import '../routes/app_routes.dart';

class SplashController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();

  @override
  void onInit() {
    super.onInit();
    navigateToNextScreen();
  }

  Future<void> navigateToNextScreen() async {
    // Wait for 2 seconds to show splash screen
    await Future.delayed(const Duration(seconds: 2));

    // Check if user is logged in
    final bool isLoggedIn = _storageService.isLoggedIn();

    // Check if user has completed onboarding
    final bool onboardingCompleted =
        _storageService.getBool('onboarding_completed') ?? false;

    if (!onboardingCompleted) {
      // First time user, show onboarding
      Get.offAllNamed(AppRoutes.onboarding);
    } else if (isLoggedIn) {
      // User is logged in, go to main page
      Get.offAllNamed(AppRoutes.mainPage);
    } else {
      // User has completed onboarding but not logged in, go to join screen
      Get.offAllNamed(AppRoutes.join);
    }
  }
}
