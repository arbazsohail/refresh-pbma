# 📦 Flutter Base Template - Complete Package

## ✅ What's Included

### Complete Flutter Project Structure
```
base_project/
├── android/              # Android native code
├── ios/                  # iOS native code
├── web/                  # Web platform code
├── linux/                # Linux platform code
├── macos/                # macOS platform code
├── windows/              # Windows platform code
├── lib/                  # Your Dart code
│   ├── controllers/      # GetX controllers (business logic)
│   ├── models/          # Data models (add your models here)
│   ├── routes/          # Navigation routing
│   ├── screens/         # UI screens
│   ├── services/        # API & Storage services
│   ├── utils/           # Constants, themes, validators
│   └── widgets/         # 7 Custom reusable widgets
├── assets/              # Images, icons, fonts
│   ├── fonts/gilroy/    # Font files (add Gilroy fonts here)
│   ├── images/          # Your images
│   └── icons/           # Your SVG icons
├── .gitignore           # Comprehensive gitignore
├── pubspec.yaml         # All dependencies configured
├── README.md            # Project overview
├── PROJECT_SETUP.md     # Complete setup guide
└── TEMPLATE_GUIDE.md    # This file
```

---

## 🚀 How to Use This Template for Your New Project

### Step 1: Upload to Your Repository

```bash
cd /path/to/base_project

# Initialize git (if not already)
git init

# Add your remote repository
git remote add origin <YOUR_GITHUB_REPO_URL>

# Add all files
git add .

# Commit
git commit -m "Initial commit: Flutter base template"

# Push to your repo
git push -u origin main
```

---

### Step 2: Clone for Each New Project

When you start a new project:

```bash
# Clone your template
git clone <YOUR_GITHUB_REPO_URL> my_new_app

cd my_new_app

# Install dependencies
flutter pub get
```

---

### Step 3: Customize for Your Project

#### A. Rename Project (REQUIRED)

**Option 1: Using `rename` package (Recommended)**
```bash
# Install rename tool globally
dart pub global activate rename

# Set app name
dart pub global run rename setAppName --targets ios,android,web --value "My App Name"

# Set bundle ID
dart pub global run rename setBundleId --targets ios,android --value "com.mycompany.myapp"
```

**Option 2: Manual Rename**
1. Update `name:` in `pubspec.yaml`
2. Update `applicationId` in `android/app/build.gradle`
3. Update Bundle Identifier in Xcode (iOS)
4. Find & replace `base_project` with `your_project_name` in all Dart imports

#### B. Update API URL (REQUIRED)
Edit `lib/services/api_constants.dart`:
```dart
static const String baseUrl = 'https://your-actual-api.com/api';
```

#### C. Customize Theme & Colors
Edit `lib/utils/app_colors.dart`:
```dart
static const Color primary = Color(0xFFYOURCOLOR);
static const Color secondary = Color(0xFFYOURCOLOR);
```

#### D. Add Your Assets
1. Add logo: `assets/images/logo.png`
2. Add splash: `assets/images/splashBg.png`
3. Add fonts: `assets/fonts/gilroy/` (or remove Gilroy references)

---

## 📚 Custom Widgets Available

### 1. CustomButton
```dart
CustomButton(
  height: 56,
  title: 'Login',
  gradient: true,
  onTap: controller.handleLogin,
  loading: controller.isLoading.value,
)
```

### 2. CustomTextfield
```dart
CustomTextfield(
  controller: controller.emailController,
  text: 'Email',
  textInputType: TextInputType.emailAddress,
  validation: Validators.email,
  prefix: Icon(Icons.email),
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

### 3. CustomSnackbar
```dart
CustomSnackbar.success(title: 'Success', message: 'Done!');
CustomSnackbar.error(title: 'Error', message: 'Failed!');
CustomSnackbar.warning(title: 'Warning', message: 'Check this');
CustomSnackbar.info(title: 'Info', message: 'New update');
```

### 4. SocialButton
```dart
SocialButton(
  provider: 'Google',
  iconPath: 'assets/icons/google.svg',
  onTap: controller.signInWithGoogle,
  isLoading: controller.isGoogleLoading.value,
)
```

### 5. SmallLoader
```dart
SmallLoader(adaptive: true, color: AppColors.primary)
```

### 6. UserImageView
```dart
UserImageView(
  url: 'https://example.com/avatar.jpg',
  radius: 30,
)
```

### 7. AdaptiveAnimatedToggle
```dart
AdaptiveAnimatedToggle(
  values: ['Today', 'Yesterday'],
  onToggleCallback: (index) { /* handle */ },
)
```

---

## 🏗️ Architecture: GetX Pattern

### Creating a New Screen

**1. Create Controller** (`lib/controllers/my_controller.dart`):
```dart
import 'package:get/get.dart';

class MyController extends GetxController {
  // Observable state
  final isLoading = false.obs;

  // Controllers
  final textController = TextEditingController();

  // Business logic
  Future<void> doSomething() async {
    isLoading.value = true;
    // Your logic here
    isLoading.value = false;
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
```

**2. Create Screen** (`lib/screens/my_screen.dart`):
```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyScreen extends GetView<MyController> {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>  // Reactive rebuild
        CustomButton(
          title: 'Click Me',
          loading: controller.isLoading.value,
          onTap: controller.doSomething,
        ),
      ),
    );
  }
}
```

**3. Add Route** (`lib/routes/app_routes.dart`):
```dart
static const String myScreen = '/my-screen';
```

**4. Register Page** (`lib/routes/app_pages.dart`):
```dart
GetPage(
  name: AppRoutes.myScreen,
  page: () => const MyScreen(),
  binding: BindingsBuilder(() {
    Get.lazyPut<MyController>(() => MyController());
  }),
)
```

---

## 📦 All Dependencies Included

✅ get (State Management)
✅ dio (HTTP Client)
✅ shared_preferences (Local Storage)
✅ image_picker (Camera/Gallery)
✅ file_picker (File Selection)
✅ cached_network_image (Image Caching)
✅ flutter_svg (SVG Support)
✅ pinput (OTP Input)
✅ flutter_native_splash (Splash Screens)
✅ intl (Date Formatting)

---

## ⚠️ Important Notes

### Before You Start:
1. **READ [PROJECT_SETUP.md](PROJECT_SETUP.md)** - Complete setup instructions
2. **Rename your project** - Don't keep `base_project` name
3. **Update API URL** - Configure your backend endpoint
4. **Add fonts OR remove Gilroy** - The template references Gilroy font

### NEVER Do This:
❌ Put business logic in screens
❌ Use `TextField` directly (use `CustomTextfield`)
❌ Use `ElevatedButton` (use `CustomButton`)
❌ Use `setState` (use GetX `.obs`)
❌ Skip validation on forms
❌ Forget to dispose controllers

### ALWAYS Do This:
✅ Put all logic in controllers
✅ Use custom widgets
✅ Use `Obx()` for reactive UI
✅ Validate user inputs
✅ Dispose resources in `onClose()`
✅ Use AppColors instead of hardcoded colors

---

## 🔐 Security

The `.gitignore` protects:
- ✅ API keys & secrets
- ✅ Firebase config files
- ✅ Signing certificates (.jks, .keystore, .p12)
- ✅ Environment variables (.env)
- ✅ Credentials & tokens

---

## 📱 Testing

```bash
# Run on connected device
flutter run

# Run on specific device
flutter devices
flutter run -d <device-id>

# Build release
flutter build apk --release  # Android
flutter build ipa            # iOS
```

---

## 🎯 Checklist for Each New Project

- [ ] Clone this template repository
- [ ] Rename project (bundle ID, app name)
- [ ] Update `api_constants.dart` with your API URL
- [ ] Customize colors in `app_colors.dart`
- [ ] Add your logo and assets
- [ ] Add Gilroy fonts OR change font family
- [ ] Update app name in `main.dart` and `app_constants.dart`
- [ ] Test on both Android and iOS
- [ ] Setup Firebase (if needed)
- [ ] Configure native splash screen
- [ ] Remove template TODOs from code
- [ ] Update README for your specific project

---

## 📖 Documentation

- **README.md** - Overview of template features
- **PROJECT_SETUP.md** - Complete step-by-step setup guide
- **TEMPLATE_GUIDE.md** - This file (how to use template)

---

## 🤝 Workflow

1. Upload template to GitHub/GitLab
2. For each new project: clone → customize → develop
3. Never modify the original template directly
4. Pull template updates when needed

---

## 💡 Pro Tips

1. **Keep template updated** - Add common features you use often
2. **Remove unused widgets** - If you never use a widget, remove it
3. **Add your patterns** - Add helper functions you commonly use
4. **Document changes** - Keep notes on customizations
5. **Test before committing** - Ensure template works before pushing

---

## 🚀 Next Steps

1. Read **PROJECT_SETUP.md** for detailed instructions
2. Upload to your repository
3. Start building amazing apps!

---

**Repository URL**: [Add your GitHub repo URL here]

**Happy Coding! 🎉**
