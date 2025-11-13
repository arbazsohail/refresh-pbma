# 🚀 Flutter Base Template

A production-ready Flutter starter template with **GetX state management**, **custom reusable widgets**, **clean architecture**, and **best practices** baked in.

---

## ✨ Features

### 🎨 **Custom Widgets**
- ✅ **CustomButton** - Gradient support, loading states, disabled states, SVG icons
- ✅ **CustomTextfield** - Password toggle, validation, input formatters, icons
- ✅ **CustomSnackbar** - Success, error, warning, info with animations
- ✅ **SocialButton** - Consistent styling for Google, Apple, Facebook logins
- ✅ **SmallLoader** - Platform-adaptive loading indicator
- ✅ **UserImageView** - Cached network images with fallbacks
- ✅ **AdaptiveAnimatedToggle** - iOS/Android adaptive tab toggles

### 🏗️ **Architecture**
- ✅ **GetX State Management** - Reactive, lightweight, and powerful
- ✅ **Clean Architecture** - Controllers, Services, Screens separation
- ✅ **Repository Pattern** - Ready for implementation
- ✅ **Dependency Injection** - Services initialized before app start

### 🌐 **Network & Storage**
- ✅ **Dio HTTP Client** - With interceptors, error handling, auto-token injection
- ✅ **SharedPreferences Wrapper** - Type-safe local storage service
- ✅ **401 Auto-Logout** - Automatic token refresh and logout handling

### 🎨 **UI/UX**
- ✅ **Dark Theme** - Beautiful dark theme with customizable colors
- ✅ **Gold Accent Colors** - Professional color palette (easily customizable)
- ✅ **System UI Overlays** - Status bar and navigation bar configurations
- ✅ **Gilroy Font** - Premium font family (easily replaceable)

### 📦 **Pre-configured**
- ✅ **Form Validators** - Email, password, phone, required fields
- ✅ **Native Splash Screen** - Flutter Native Splash integration
- ✅ **Image & File Pickers** - Ready to use
- ✅ **SVG Support** - Flutter SVG package included
- ✅ **Comprehensive .gitignore** - Protects sensitive files

---

## 📁 Project Structure

```
lib/
├── controllers/          # Business logic & state management
├── models/              # Data models (add your models here)
├── routes/              # Navigation routing
│   ├── app_routes.dart
│   └── app_pages.dart
├── screens/             # UI screens (presentation only)
├── services/            # External service integrations
│   ├── api_service.dart
│   ├── storage_service.dart
│   └── api_constants.dart
├── utils/               # Constants, themes, helpers
│   ├── app_colors.dart
│   ├── app_theme.dart
│   ├── app_constants.dart
│   └── validators.dart
├── widgets/             # Custom reusable widgets
│   ├── custom_button.dart
│   ├── custom_textfield.dart
│   ├── custom_snackbar.dart
│   ├── social_button.dart
│   ├── small_loader.dart
│   ├── user_image_view.dart
│   └── adaptive_animated_toggle.dart
└── main.dart            # App entry point
```

---

## 🚀 Quick Start

### 1. Clone This Template
```bash
# Clone or download this repository
git clone <your-repo-url> my_new_project
cd my_new_project
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Run the App
```bash
flutter run
```

---

## 📖 Full Setup Guide

For comprehensive setup instructions, please read **[PROJECT_SETUP.md](PROJECT_SETUP.md)**

This includes:
- ✅ Renaming your project
- ✅ Customizing colors and theme
- ✅ Configuring API endpoints
- ✅ Using custom widgets
- ✅ Architecture best practices
- ✅ Native splash screen setup
- ✅ Deployment guides (Android & iOS)

---

## 🎨 Custom Widgets Quick Reference

### CustomButton
```dart
CustomButton(
  height: 56,
  title: 'Sign Up',
  gradient: true,
  onTap: controller.handleSignUp,
  loading: controller.isLoading.value,
)
```

### CustomTextfield
```dart
CustomTextfield(
  controller: controller.emailController,
  text: 'Email Address',
  textInputType: TextInputType.emailAddress,
  prefix: const Icon(Icons.email_outlined),
  validation: Validators.email,
)
```

### CustomSnackbar
```dart
CustomSnackbar.success(
  title: 'Success',
  message: 'Operation completed!',
);
```

---

## 🏗️ Architecture Pattern

```
Screen (UI Only)
  ↓
Controller (Business Logic)
  ↓
Service (API/Storage)
  ↓
Backend/Local Storage
```

**Key Principles:**
- ✅ **NO business logic in screens**
- ✅ **ALL logic in controllers**
- ✅ **Use Obx() for reactive updates**
- ✅ **Always use custom widgets**
- ✅ **Dispose resources in onClose()**

---

## 📦 Included Packages

| Package | Purpose |
|---------|---------|
| `get` | State management & navigation |
| `dio` | HTTP client |
| `shared_preferences` | Local storage |
| `image_picker` | Pick images from gallery/camera |
| `file_picker` | Pick files |
| `cached_network_image` | Image caching |
| `flutter_svg` | SVG support |
| `pinput` | OTP input |
| `flutter_native_splash` | Native splash screens |
| `intl` | Date formatting |

---

## 🎯 What to Do Next

1. **Read [PROJECT_SETUP.md](PROJECT_SETUP.md)** - Complete setup guide
2. **Rename your project** - Change bundle ID, app name
3. **Update API URL** - Configure your backend in `api_constants.dart`
4. **Customize colors** - Edit `app_colors.dart`
5. **Add your assets** - Logo, images, fonts
6. **Build your features** - Follow the controller pattern

---

## 🔒 Security Features

- ✅ Comprehensive `.gitignore` (protects API keys, certificates, credentials)
- ✅ Automatic token management
- ✅ 401 unauthorized auto-logout
- ✅ Secure local storage

---

## 📝 Best Practices Enforced

✅ **Separation of Concerns** - UI, Logic, Services are separate
✅ **Reusable Components** - DRY principle with custom widgets
✅ **Type Safety** - Proper typing throughout
✅ **Error Handling** - Comprehensive error management
✅ **Loading States** - User feedback for async operations
✅ **Form Validation** - Input validation built-in
✅ **Resource Management** - Proper disposal of controllers

---

## 🚫 What NOT to Do

- ❌ Don't use `TextField` directly - use `CustomTextfield`
- ❌ Don't use `ElevatedButton` - use `CustomButton`
- ❌ Don't put logic in screens - use controllers
- ❌ Don't use `setState` - use GetX observables
- ❌ Don't skip validation - always validate forms
- ❌ Don't forget to dispose - use `onClose()`

---

## 🔧 Configuration Files

### `pubspec.yaml`
- All dependencies pre-configured
- Assets directories defined
- Gilroy font configured (add your fonts)

### `.gitignore`
- Protects sensitive files (API keys, certificates, etc.)
- Excludes build artifacts
- Ready for version control

### `main.dart`
- Services initialization
- Theme configuration
- Route setup

---

## 📱 Platform Support

- ✅ **Android** (API 21+)
- ✅ **iOS** (iOS 12+)
- ⚠️ **Web** (requires additional configuration)

---

## 🤝 Contributing

This template is designed to be a starting point. Feel free to customize it for your needs!

---

## 📄 License

This template is free to use for personal and commercial projects.

---

## 🙏 Credits

Built with:
- Flutter & Dart
- GetX State Management
- Dio HTTP Client
- Community packages

---

## 📬 Support

For issues, questions, or feature requests, please refer to [PROJECT_SETUP.md](PROJECT_SETUP.md) or create an issue in your repository.

---

## ⚡ Quick Tips

1. **Always read PROJECT_SETUP.md first**
2. **Don't skip renaming your project**
3. **Update API URLs before deploying**
4. **Add your fonts or remove Gilroy references**
5. **Test on both platforms before release**

---

**Happy Coding! 🚀**

Made with ❤️ for the Flutter community
