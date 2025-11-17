import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/change_password_settings_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class ChangePasswordSettingsScreen extends GetView<ChangePasswordSettingsController> {
  const ChangePasswordSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConstants.darkSystemOverlay(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const CustomAppBar(
          title: 'Change Password',
          showBackButton: true,
          showNotification: true,
          showSettings: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  // Title
                  const Text(
                    'Change your password',
                    style: TextStyle(
                      color: AppColors.blackText,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'DMSans',
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Old Password field
                  const Text(
                    'Old Password',
                    style: TextStyle(
                      color: AppColors.blackText,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'DMSans',
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextfield(
                    controller: controller.oldPasswordController,
                    text: 'Enter Password',
                    obsecureText: true,
                    showPasswordToggle: true,
                    textInputAction: TextInputAction.next,
                    validation: controller.validateOldPassword,
                    filledColor: AppColors.lightGray,
                    borderRadius: 50,
                  ),

                  const SizedBox(height: 20),

                  // New Password field
                  const Text(
                    'New Password',
                    style: TextStyle(
                      color: AppColors.blackText,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'DMSans',
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextfield(
                    controller: controller.newPasswordController,
                    text: 'Enter confirm password',
                    obsecureText: true,
                    showPasswordToggle: true,
                    textInputAction: TextInputAction.next,
                    validation: controller.validateNewPassword,
                    filledColor: AppColors.lightGray,
                    borderRadius: 50,
                  ),

                  const SizedBox(height: 20),

                  // Confirm Password field
                  const Text(
                    'Confirm Password',
                    style: TextStyle(
                      color: AppColors.blackText,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'DMSans',
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextfield(
                    controller: controller.confirmPasswordController,
                    text: 'Enter confirm password',
                    obsecureText: true,
                    showPasswordToggle: true,
                    textInputAction: TextInputAction.done,
                    validation: controller.validateConfirmPassword,
                    filledColor: AppColors.lightGray,
                    borderRadius: 50,
                  ),

                  const SizedBox(height: 32),

                  // Save Password button
                  Obx(
                    () => CustomButton(
                      title: 'Save Password',
                      onTap: controller.savePassword,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
