import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'services/storage_service.dart';
import 'services/api_service.dart';
import 'services/auth_service.dart';
import 'services/biometric_service.dart';
import 'services/firebase_service.dart';
import 'services/google_auth_service.dart';
import 'services/payment_service.dart';
import 'services/settings_service.dart';
import 'services/wallet_service.dart';
import 'utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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

  // Initialize Auth Service
  Get.put(AuthService());

  // Initialize Biometric Service
  Get.put(BiometricService());

  // Initialize Firebase Service (FCM)
  Get.put(FirebaseService());

  // Initialize Google Auth Service
  Get.put(GoogleAuthService());

  // Initialize Payment Service
  Get.put(PaymentService());

  // Initialize Settings Service (FAQs, Support, etc.)
  Get.put(SettingsService());

  // Initialize Wallet Service
  Get.put(WalletService());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  String _getInitialRoute() {
    // Always start with splash screen
    return AppRoutes.splash;
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
