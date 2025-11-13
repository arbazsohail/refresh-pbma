import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';

/// Custom Snackbar Types
enum SnackbarType {
  success,
  error,
  warning,
  info,
}

/// Custom Snackbar Widget
///
/// Shows a beautiful animated snackbar from the top with icon and message
class CustomSnackbar {
  /// Show snackbar with custom styling
  static void show({
    required String title,
    required String message,
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: _getBackgroundColor(type),
      colorText: Colors.white,
      borderRadius: 12,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _getIcon(type),
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
      duration: duration,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      animationDuration: const Duration(milliseconds: 500),
      boxShadows: [
        BoxShadow(
          color: _getBackgroundColor(type).withValues(alpha: 0.4),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
      titleText: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Gilroy',
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.white,
          fontFamily: 'Gilroy',
        ),
      ),
    );
  }

  /// Show success snackbar
  static void success({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      title: title,
      message: message,
      type: SnackbarType.success,
      duration: duration,
    );
  }

  /// Show error snackbar
  static void error({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      title: title,
      message: message,
      type: SnackbarType.error,
      duration: duration,
    );
  }

  /// Show warning snackbar
  static void warning({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      title: title,
      message: message,
      type: SnackbarType.warning,
      duration: duration,
    );
  }

  /// Show info snackbar
  static void info({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      title: title,
      message: message,
      type: SnackbarType.info,
      duration: duration,
    );
  }

  /// Get background color based on type
  static Color _getBackgroundColor(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return AppColors.success;
      case SnackbarType.error:
        return AppColors.error;
      case SnackbarType.warning:
        return const Color(0xFFF59E0B); // Amber/Orange
      case SnackbarType.info:
        return const Color(0xFF3B82F6); // Blue
    }
  }

  /// Get icon based on type
  static IconData _getIcon(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return Icons.check_circle_rounded;
      case SnackbarType.error:
        return Icons.error_rounded;
      case SnackbarType.warning:
        return Icons.warning_rounded;
      case SnackbarType.info:
        return Icons.info_rounded;
    }
  }
}
