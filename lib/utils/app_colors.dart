import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF195B91); // Blue
  static const Color primaryDark = Color(0xFF134375);
  static const Color primaryLight = Color(0xFF2372AD);

  // Secondary Color
  static const Color secondary = Color(0xFF5A9DD5); // Light Blue

  // Background Colors (Dark Theme)
  static const Color background = Color(0xFF121212);
  static const Color surface = Color(0xFF1E1E1E);
  static const Color cardBackground = Color(0xFF2A2A2A);

  // Background Colors (Light Theme)
  static const Color lightBackground = Color(0xFFFCFCFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGray = Color(0xFFF5F5F5);
  static const Color textFieldColor = Color(0xFFF5F5F5);

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textHint = Color(0xFF707070);

  // Light Theme Text Colors
  static const Color blackText = Color(0xFF101010);
  static const Color darkBlackText = Color(0xFF060606);
  static const Color darkBlueText = Color(0xFF2D5F9B); // Dark blue for titles
  static const Color greyText = Color(0xFF7C8086); // Grey for descriptions

  // Status Colors
  static const Color success = Color(0xFF2BC259); // Dark Green
  static const Color warning = Color(0xFFD8A20C); // Dark Yellow
  static const Color error = Color(0xFFE57373);
  static const Color info = Color(0xFF42A5F5);

  // Status Badge Colors (Light variants)
  static const Color lightGreen = Color(0xFFDBF3E2); // Light Green background
  static const Color lightYellow = Color(0xFFFAECD5); // Light Yellow background
  static const Color darkGreen = Color(0xFF2BC259); // Dark Green (for text/icons)
  static const Color darkYellow = Color(0xFFD8A20C); // Dark Yellow (for text/icons)

  static const Color pending = Color(0xFFD8A20C);
  static const Color completed = Color(0xFF2BC259);
  static const Color ongoing = Color(0xFF42A5F5);
  static const Color rejected = Color(0xFFE57373);

  // Priority Colors
  static const Color highPriority = Color(0xFFE57373);
  static const Color mediumPriority = Color(0xFFFFA726);
  static const Color lowPriority = Color(0xFF81C784);

  // Border Colors
  static const Color border = Color(0xFF3A3A3A);
  static const Color divider = Color(0xFF2A2A2A);
  static const Color lightBorder = Color(0xFFEDF1F3);
  static const Color borderColor = Color(0xFFB9B9B9);
  static const Color borderGrey = Color(0xFFE0E2E5);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Light variants for effects
  static const Color lightPrimary = primaryLight;

  // Accent Colors
  static const Color purpleAccent = Color(0xFF5C266E);
  static const Color goldAccent = Color(0xFFEDC96A);
}
