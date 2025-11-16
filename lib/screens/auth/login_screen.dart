import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/login_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/custom_back_button.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConstants.lightSystemOverlay(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back arrow
                  const CustomBackButton(),

                  const SizedBox(height: 32),

                  // Title
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      color: AppColors.blackText,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'DMSans',
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Email field
                  const Text(
                    'Email',
                    style: TextStyle(
                      color: AppColors.blackText,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'DMSans',
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextfield(
                    controller: controller.emailController,
                    text: 'Enter email',
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validation: controller.validateEmail,
                    filledColor: AppColors.lightGray,
                    borderRadius: 50,
                  ),

                  const SizedBox(height: 20),

                  // Password field
                  const Text(
                    'Password',
                    style: TextStyle(
                      color: AppColors.blackText,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'DMSans',
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextfield(
                    controller: controller.passwordController,
                    text: 'Enter password',
                    obsecureText: true,
                    showPasswordToggle: true,
                    textInputAction: TextInputAction.done,
                    validation: controller.validatePassword,
                    filledColor: AppColors.lightGray,
                    borderRadius: 50,
                  ),

                  const SizedBox(height: 20),

                  // Remember me & Forgot password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Remember me checkbox
                      Obx(
                        () => GestureDetector(
                          onTap:
                              () => controller.toggleRememberMe(
                                !controller.rememberMe.value,
                              ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color:
                                        controller.rememberMe.value
                                            ? AppColors.secondary
                                            : Colors.transparent,
                                    border: Border.all(
                                      color: AppColors.secondary,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child:
                                      controller.rememberMe.value
                                          ? const Icon(
                                            Icons.check,
                                            size: 16,
                                            color: AppColors.white,
                                          )
                                          : null,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Remember me',
                                  style: TextStyle(
                                    color: AppColors.blackText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'DMSans',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Forgot password
                      GestureDetector(
                        onTap: controller.goToForgotPassword,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: AppColors.secondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'DMSans',
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Sign in button
                  Obx(
                    () => CustomButton(
                      title: 'Sign in',
                      onTap: controller.signIn,
                      height: 54,
                      backgroundColor: AppColors.primary,
                      textColor: AppColors.white,
                      borderRadius: 50,
                      margin: 0,
                      horizontalPadding: 36,
                      titleFontSize: 16,
                      loading: controller.isLoading.value,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // "or" divider
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: AppColors.lightBorder,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'or',
                          style: TextStyle(
                            color: AppColors.greyText,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'DMSans',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: AppColors.lightBorder,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Continue with Google button
                  CustomButton(
                    title: 'Continue with Google',
                    onTap: controller.signInWithGoogle,
                    height: 54,
                    backgroundColor: AppColors.lightGray,
                    textColor: AppColors.blackText,
                    borderRadius: 58,
                    margin: 0,
                    horizontalPadding: 36,
                    titleFontSize: 16,
                    icon: 'assets/icons/google.svg',
                    iconSpacing: 10,
                  ),

                  const SizedBox(height: 16),

                  // Continue with Apple button
                  CustomButton(
                    title: 'Continue with Apple',
                    onTap: controller.signInWithApple,
                    height: 54,
                    backgroundColor: AppColors.lightGray,
                    textColor: AppColors.blackText,
                    borderRadius: 58,
                    margin: 0,
                    horizontalPadding: 36,
                    titleFontSize: 16,
                    icon: 'assets/icons/apple.svg',
                    iconSpacing: 10,
                  ),
                  SizedBox(height: Get.height*0.08),

                  // Sign up text
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: AppColors.greyText,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'DMSans',
                          ),
                        ),
                        GestureDetector(
                          onTap: controller.goToSignUp,
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              color: AppColors.secondary,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'DMSans',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
