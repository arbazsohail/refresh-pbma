import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'services/storage_service.dart';
import 'services/api_service.dart';
import 'utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Services
  await initServices();

  runApp(const MyApp());
}

// Initialize all services before app starts
Future<void> initServices() async {
  // Initialize Storage Service
  await Get.putAsync(() => StorageService().init());

  // Initialize API Service
  Get.put(ApiService());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  String _getInitialRoute() {
    final storage = Get.find<StorageService>();
    final onboardingCompleted = storage.getBool('onboarding_completed') ?? false;

    // If onboarding not completed, show onboarding
    // Otherwise, go directly to join screen
    return onboardingCompleted ? AppRoutes.join : AppRoutes.onboarding;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Refresh PBMA',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,

      // Initial Route based on onboarding status
      initialRoute: _getInitialRoute(),

      // Routes
      getPages: AppPages.routes,

      // Default Transition
      defaultTransition: Transition.fade,

      // Fallback widget when route not found
      unknownRoute: GetPage(
        name: '/not-found',
        page: () => const Scaffold(body: Center(child: Text('Page not found'))),
      ),
    );
  }
}
