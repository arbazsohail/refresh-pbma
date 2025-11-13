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

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Refresh PBMA',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,

      // Initial Route
      initialRoute: AppRoutes.splash,

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
