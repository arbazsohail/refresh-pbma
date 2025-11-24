import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/splash_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access controller to trigger initialization
    Get.find<SplashController>();

    return AppConstants.lightSystemOverlay(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Center(
          child: Image.asset(
            'assets/images/logo.png',
            width: 136,
            height: 181,
          fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
