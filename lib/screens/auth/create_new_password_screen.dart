import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/create_new_password_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/custom_back_button.dart';

class CreateNewPasswordScreen extends GetView<CreateNewPasswordController> {
  const CreateNewPasswordScreen({super.key});

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

                  // New Password label
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

                  // New Password field
                  CustomTextfield(
                    controller: controller.newPasswordController,
                    text: 'Enter new password',
                    obsecureText: true,
                    showPasswordToggle: true,
                    textInputAction: TextInputAction.next,
                    validation: controller.validatePassword,
                    filledColor: AppColors.lightGray,
                    borderRadius: 50,
                  ),

                  const SizedBox(height: 20),

                  // Confirm Password label
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

                  // Confirm Password field
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

                  const SizedBox(height: 40),

                  // Change Password button
                  Obx(
                    () => CustomButton(
                      title: 'Change Password',
                      onTap: controller.changePassword,
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
