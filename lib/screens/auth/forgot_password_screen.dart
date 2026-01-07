import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/forgot_password_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/custom_back_button.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConstants.lightSystemOverlay(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button
                  const CustomBackButton(),

                  const SizedBox(height: 40),

                  // Title
                  const Center(
                    child: Text(
                      'Forgot Password?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.blackText,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'DMSans',
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Subtitle
                  const Center(
                    child: Text(
                      'Please enter the email address\nlinked with your account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.greyText,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'DMSans',
                        height: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Email label
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

                  // Email field
                  CustomTextfield(
                    controller: controller.emailController,
                    text: 'Enter email',
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    validation: controller.validateEmail,
                    filledColor: AppColors.lightGray,
                    borderRadius: 50,
                  ),

                  const SizedBox(height: 40),

                  // Send Code button
                  Obx(() => CustomButton(
                        title: 'Send Code',
                        onTap: controller.sendCode,
                        height: 54,
                        backgroundColor: AppColors.primary,
                        textColor: AppColors.white,
                        borderRadius: 50,
                        margin: 0,
                        horizontalPadding: 36,
                        titleFontSize: 16,
                        loading: controller.isLoading.value,
                      )),

                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
