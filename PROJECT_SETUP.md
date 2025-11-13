# Flutter Base Template - Project Setup Guide

This comprehensive guide will walk you through setting up a new project from this base template.

---

## 📋 Table of Contents
1. [Quick Start](#quick-start)
2. [Project Customization](#project-customization)
3. [Custom Widgets Usage](#custom-widgets-usage)
4. [Architecture & Best Practices](#architecture--best-practices)
5. [Native Splash Screen Setup](#native-splash-screen-setup)
6. [API Integration](#api-integration)
7. [Deployment](#deployment)

---

## 🚀 Quick Start

### 1. Clone/Copy This Template
```bash
# Create your new project directory
mkdir my_new_project
cd my_new_project

# Copy all template files (excluding .git)
cp -R /path/to/flutter_base_template/* .
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Verify Installation
```bash
flutter doctor
flutter run
```

---

## 🔧 Project Customization

### Step 1: Rename Project

#### Option A: Using `rename` Package (Recommended)
```bash
# Install rename tool
dart pub global activate rename

# Rename your project
dart pub global run rename setAppName --targets ios,android,web --value "My App Name"
dart pub global run rename setBundleId --targets ios,android --value "com.yourcompany.yourapp"
```

#### Option B: Manual Renaming

**1. Update `pubspec.yaml`:**
```yaml
name: your_project_name  # Change this
description: "Your project description"  # Change this
```

**2. Update Android Package Name:**

File: `android/app/build.gradle`
```gradle
defaultConfig {
    applicationId "com.yourcompany.yourapp"  // Change this
    // ...
}
```

File: `android/app/src/main/AndroidManifest.xml`
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.yourcompany.yourapp">  <!-- Change this -->
```

**3. Update iOS Bundle Identifier:**

- Open `ios/Runner.xcworkspace` in Xcode
- Select Runner → General → Bundle Identifier
- Change to `com.yourcompany.yourapp`

**4. Rename Import Statements:**
```bash
# Find and replace in all files
find . -type f -name "*.dart" -exec sed -i '' 's/flutter_base_template/your_project_name/g' {} +
```

### Step 2: Update App Colors & Theme

Edit `lib/utils/app_colors.dart`:
```dart
class AppColors {
  // Change these to match your brand colors
  static const Color primary = Color(0xFFD4AF37); // Your primary color
  static const Color secondary = Color(0xFF8B6934); // Your secondary color

  // Update other colors as needed
}
```

### Step 3: Update App Constants

Edit `lib/utils/app_constants.dart`:
```dart
class AppConstants {
  static const String appName = 'Your App Name';  // Change this
  static const String baseUrl = 'https://your-api-url.com';  // Change this

  // Update image paths to match your assets
  static const String logoPath = 'assets/images/your_logo.png';
}
```

### Step 4: Configure API Base URL

Edit `lib/services/api_constants.dart`:
```dart
class ApiConstants {
  static const String baseUrl = 'https://your-actual-backend-url.com/api';  // IMPORTANT!

  // Add your API endpoints here
  static const String yourEndpoint = '/your/endpoint';
}
```

### Step 5: Add Your Assets

```
assets/
├── fonts/
│   └── gilroy/
│       ├── Gilroy-Regular.ttf
│       ├── Gilroy-Medium.ttf
│       ├── Gilroy-SemiBold.ttf
│       └── Gilroy-Bold.ttf
├── images/
│   ├── logo.png
│   ├── splashBg.png
│   └── welcomeBg.png
└── icons/
    └── (your SVG icons)
```

**Note**: You MUST add the Gilroy font files or change the font family in `pubspec.yaml` and `app_theme.dart`.

---

## 🎨 Custom Widgets Usage

### 1. CustomButton

**Location**: `lib/widgets/custom_button.dart`

**When to use**: For ALL button interactions in your app

**Features**:
- Gradient support
- Loading states
- Disabled states
- Custom colors, sizes, borders
- SVG icon support
- Press animations

**Example**:
```dart
CustomButton(
  height: 56,
  title: 'Login',
  gradient: true,
  onTap: controller.handleLogin,
  loading: controller.isLoading.value,
  margin: 0,
  borderRadius: 12,
)
```

**DO NOT**: Create `ElevatedButton` or `TextButton` directly. Always use `CustomButton`.

---

### 2. CustomTextfield

**Location**: `lib/widgets/custom_textfield.dart`

**When to use**: For ALL text input fields

**Features**:
- Password toggle
- Prefix icons
- Validation functions
- Keyboard types
- Input formatters
- Read-only mode
- Disabled state
- Multi-line support

**Example**:
```dart
CustomTextfield(
  controller: controller.emailController,
  text: 'Email Address',
  textInputType: TextInputType.emailAddress,
  prefix: const Icon(Icons.email_outlined),
  validation: Validators.email,
  textInputAction: TextInputAction.next,
)

// Password field
CustomTextfield(
  controller: controller.passwordController,
  text: 'Password',
  showPasswordToggle: true,  // Shows eye icon
  obsecureText: true,
  validation: Validators.password,
)
```

**DO NOT**: Use `TextField` or `TextFormField` directly.

---

### 3. CustomSnackbar

**Location**: `lib/widgets/custom_snackbar.dart`

**When to use**: For showing notifications, alerts, and messages

**Types**: success, error, warning, info

**Example**:
```dart
// Success message
CustomSnackbar.success(
  title: 'Success',
  message: 'Login successful!',
);

// Error message
CustomSnackbar.error(
  title: 'Error',
  message: 'Invalid credentials',
);

// Warning
CustomSnackbar.warning(
  title: 'Warning',
  message: 'Please verify your email',
);

// Info
CustomSnackbar.info(
  title: 'Info',
  message: 'New update available',
);
```

**DO NOT**: Use `Get.snackbar()` or `SnackBar` directly.

---

### 4. SocialButton

**Location**: `lib/widgets/social_button.dart`

**When to use**: For social login buttons (Google, Apple, Facebook, etc.)

**Example**:
```dart
SocialButton(
  provider: 'Google',
  iconPath: 'assets/icons/google.svg',  // SVG path
  onTap: controller.signInWithGoogle,
  isLoading: controller.isGoogleLoading.value,
)
```

**DO NOT**: Use `CustomButton` for social logins - they have different styling.

---

### 5. SmallLoader

**Location**: `lib/widgets/small_loader.dart`

**When to use**: For inline loading indicators

**Example**:
```dart
SmallLoader(
  adaptive: true,  // Uses platform-specific loader
  color: AppColors.primary,
)
```

---

### 6. UserImageView

**Location**: `lib/widgets/user_image_view.dart`

**When to use**: For displaying user profile images with caching

**Example**:
```dart
UserImageView(
  url: 'https://example.com/avatar.jpg',
  radius: 30,
  backgroundColor: AppColors.surface,
)

// Local image
UserImageView(
  url: '/path/to/local/image.jpg',
  local: true,
  radius: 40,
)
```

---

### 7. AdaptiveAnimatedToggle

**Location**: `lib/widgets/adaptive_animated_toggle.dart`

**When to use**: For tab-like toggles (Today/Yesterday, etc.)

**Example**:
```dart
AdaptiveAnimatedToggle(
  values: ['Today', 'Yesterday'],
  onToggleCallback: (index) {
    // Handle toggle change
  },
  initialValue: 0,
)
```

---

## 🏗️ Architecture & Best Practices

### Controller Pattern (GetX)

**CRITICAL**: All business logic MUST be in controllers. UI screens ONLY handle presentation.

#### Creating a New Feature

**1. Create Controller** (`lib/controllers/login_controller.dart`):
```dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../utils/validators.dart';
import '../widgets/custom_snackbar.dart';

class LoginController extends GetxController {
  // Dependencies
  final ApiService _apiService = Get.find();
  final StorageService _storageService = Get.find();

  // Form Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable State
  final isLoading = false.obs;

  // Validation Functions
  String? validateEmail(String? value) {
    return Validators.email(value);
  }

  String? validatePassword(String? value) {
    return Validators.password(value);
  }

  // Business Logic
  Future<void> login() async {
    try {
      isLoading.value = true;

      final response = await _apiService.post(
        '/auth/login',
        data: {
          'email': emailController.text,
          'password': passwordController.text,
        },
      );

      // Save token
      await _storageService.saveToken(response.data['token']);

      CustomSnackbar.success(
        title: 'Success',
        message: 'Login successful!',
      );

      Get.offAllNamed('/home');
    } catch (e) {
      CustomSnackbar.error(
        title: 'Error',
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
```

**2. Create Screen** (`lib/screens/auth/login_screen.dart`):
```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/login_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: AppConstants.lightSystemOverlay(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextfield(
                  controller: controller.emailController,
                  text: 'Email',
                  textInputType: TextInputType.emailAddress,
                  validation: controller.validateEmail,
                ),
                const SizedBox(height: 16),
                CustomTextfield(
                  controller: controller.passwordController,
                  text: 'Password',
                  showPasswordToggle: true,
                  obsecureText: true,
                  validation: controller.validatePassword,
                ),
                const SizedBox(height: 24),
                Obx(
                  () => CustomButton(
                    height: 56,
                    title: 'Login',
                    gradient: true,
                    onTap: controller.login,
                    loading: controller.isLoading.value,
                    margin: 0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

**3. Add Route** (`lib/routes/app_routes.dart`):
```dart
class AppRoutes {
  static const String login = '/login';  // Add this
  // ...
}
```

**4. Register Page** (`lib/routes/app_pages.dart`):
```dart
import '../screens/auth/login_screen.dart';
import '../controllers/login_controller.dart';

static final routes = [
  // ...
  GetPage(
    name: AppRoutes.login,
    page: () => const LoginScreen(),
    binding: BindingsBuilder(() {
      Get.lazyPut<LoginController>(() => LoginController());
    }),
    transition: Transition.cupertino,
  ),
];
```

### System UI Overlays

Use the helper extensions from `app_constants.dart`:

```dart
// For dark screens with dark app bar
Scaffold(
  body: yourWidget.withDarkSystemOverlay(),
)

// For light auth screens
Scaffold(
  body: yourWidget.withLightSystemOverlay(),
)

// For splash/welcome screens with images
Scaffold(
  body: yourWidget.withDarkBackgroundOverlay(),
)
```

---

## 🎨 Native Splash Screen Setup

This template includes `flutter_native_splash` configuration.

### Configure Splash Screen

**1. Add splash image** to `assets/images/splash_icon.png` (1024x1024 recommended)

**2. Add configuration** to `pubspec.yaml`:
```yaml
flutter_native_splash:
  color: "#121212"  # Your background color
  image: assets/images/splash_icon.png
  android_12:
    image: assets/images/splash_icon.png
    color: "#121212"
  web: false
```

**3. Generate splash screens**:
```bash
dart run flutter_native_splash:create
```

**4. Hide splash** in your splash screen (`lib/screens/splash_screen.dart`):
```dart
import 'package:flutter_native_splash/flutter_native_splash.dart';

@override
void initState() {
  super.initState();

  // Hide the native splash
  FlutterNativeSplash.remove();

  _navigateToNext();
}
```

---

## 🌐 API Integration

### Adding a New API Endpoint

**1. Define endpoint** in `lib/services/api_constants.dart`:
```dart
static const String getUserProfile = '/user/profile';
```

**2. Create repository** (optional but recommended):
```dart
// lib/repositories/user_repository.dart
class UserRepository {
  final ApiService _apiService = Get.find();

  Future<UserModel> getProfile() async {
    final response = await _apiService.get(ApiConstants.getUserProfile);
    return UserModel.fromJson(response.data);
  }
}
```

**3. Use in controller**:
```dart
final userRepo = UserRepository();
final user = await userRepo.getProfile();
```

### Handling API Errors

The `ApiService` automatically handles common errors. Custom handling:

```dart
try {
  final response = await _apiService.post('/endpoint', data: {...});
} on String catch (errorMessage) {
  // errorMessage is user-friendly from ApiService
  CustomSnackbar.error(title: 'Error', message: errorMessage);
}
```

---

## 📱 Deployment

### Android

**1. Update `android/app/build.gradle`**:
```gradle
defaultConfig {
    applicationId "com.yourcompany.yourapp"
    minSdkVersion 21
    targetSdkVersion 34
    versionCode 1
    versionName "1.0.0"
}
```

**2. Create keystore**:
```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

**3. Create `android/key.properties`**:
```
storePassword=your-store-password
keyPassword=your-key-password
keyAlias=upload
storeFile=/path/to/upload-keystore.jks
```

**4. Build release**:
```bash
flutter build appbundle
# or
flutter build apk --release
```

### iOS

**1. Open in Xcode**:
```bash
open ios/Runner.xcworkspace
```

**2. Update version** in Runner → General → Version

**3. Configure signing** in Signing & Capabilities

**4. Build**:
```bash
flutter build ipa
```

---

## ✅ Checklist for New Project

- [ ] Rename project name and bundle ID
- [ ] Update app colors in `app_colors.dart`
- [ ] Add your logo and assets
- [ ] Configure API base URL in `api_constants.dart`
- [ ] Add Gilroy fonts or change font family
- [ ] Setup native splash screen
- [ ] Update Android `applicationId`
- [ ] Update iOS `Bundle Identifier`
- [ ] Test on both Android and iOS
- [ ] Remove template TODOs from code
- [ ] Update this README for your project

---

## 🔗 Useful Resources

- [GetX Documentation](https://pub.dev/packages/get)
- [Dio HTTP Client](https://pub.dev/packages/dio)
- [Flutter Documentation](https://flutter.dev/docs)

---

## 📝 Notes

- **ALWAYS** use custom widgets instead of native Flutter widgets
- **NEVER** put business logic in screens
- **ALWAYS** validate forms in controllers
- **ALWAYS** use `Obx()` for reactive UI updates
- **NEVER** use `setState` when using GetX
- **ALWAYS** dispose controllers in `onClose()`
- **NEVER** hardcode strings - use constants

---

Happy Coding! 🚀
