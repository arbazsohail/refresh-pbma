import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

/// App-wide constants and reusable configurations
class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  /// App Name
  static const String appName = 'Refresh PBMA';

  /// API Configuration
  static const String baseUrl = 'https://api.example.com'; // TODO: Update with actual API URL
  static const int apiTimeout = 30; // seconds

  /// Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);

  /// Padding & Spacing
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;

  /// Border Radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 18.0;
  static const double radiusXLarge = 24.0;
  static const double radiusRound = 34.0;

  /// Icon Sizes
  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;

  /// Font Sizes
  static const double fontSizeSmall = 12.0;
  static const double fontSizeMedium = 14.0;
  static const double fontSizeNormal = 16.0;
  static const double fontSizeLarge = 18.0;
  static const double fontSizeXLarge = 24.0;
  static const double fontSizeHeading = 34.0;
  static const double fontSizeDisplay = 48.0;

  /// Image Paths
  static const String logoPath = 'assets/images/logo.png';
  static const String splashBgPath = 'assets/images/splashBg.png';
  static const String welcomeBgPath = 'assets/images/welcomeBg.png';
  static const String goldenLogoPath = 'assets/icons/golden_logo_with_text.png';

  /// System UI Overlay Styles (Annotated Regions)

  /// Dark System Overlay - For Main App Screens
  /// Used for screens with dark app bar and light bottom navigation
  /// Example: MainPage with CustomAppBar (dark) and bottom nav (light frame)
  static Widget darkSystemOverlay({required Widget child}) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.background, // Dark status bar matching app bar
        statusBarIconBrightness: Brightness.light, // Light icons for dark status bar
        statusBarBrightness: Brightness.dark, // iOS: dark status bar
        systemNavigationBarColor: AppColors.lightBackground, // Light bottom nav frame
        systemNavigationBarIconBrightness: Brightness.dark, // Dark icons for light nav
      ),
      child: child,
    );
  }

  /// Light System Overlay - For Auth Screens
  /// Used for screens with light backgrounds (Login, Signup, etc.)
  static Widget lightSystemOverlay({required Widget child}) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Transparent status bar
        statusBarIconBrightness: Brightness.dark, // Dark icons for light backgrounds
        statusBarBrightness: Brightness.light, // iOS: light status bar
        systemNavigationBarColor: AppColors.lightBackground, // Light bottom nav
        systemNavigationBarIconBrightness: Brightness.dark, // Dark navigation icons
      ),
      child: child,
    );
  }

  /// Dark Background Overlay - For Splash/Welcome Screens
  /// Used for screens with dark/image backgrounds (Splash, Welcome)
  static Widget darkBackgroundOverlay({required Widget child}) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Transparent status bar
        statusBarIconBrightness: Brightness.light, // Light icons for dark backgrounds
        statusBarBrightness: Brightness.dark, // iOS: dark status bar
        systemNavigationBarColor: AppColors.background, // Dark bottom nav
        systemNavigationBarIconBrightness: Brightness.light, // Light navigation icons
      ),
      child: child,
    );
  }
}

/// Extension for easier usage
extension SystemBarsExtension on Widget {
  /// Wrap widget with dark system overlay (for main app screens with dark app bar)
  Widget withDarkSystemOverlay() => AppConstants.darkSystemOverlay(child: this);

  /// Wrap widget with light system overlay (for auth screens with light backgrounds)
  Widget withLightSystemOverlay() => AppConstants.lightSystemOverlay(child: this);

  /// Wrap widget with dark background overlay (for splash/welcome screens)
  Widget withDarkBackgroundOverlay() => AppConstants.darkBackgroundOverlay(child: this);
}
