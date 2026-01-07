import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/profile_settings_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class ProfileSettingsScreen extends GetView<ProfileSettingsController> {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConstants.darkSystemOverlay(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const CustomAppBar(
          title: 'Profile Settings',
          showBackButton: true,
          showNotification: false,
          showSettings: false,
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

                  // First Name field
                  const Text(
                    'First Name',
                    style: TextStyle(
                      color: AppColors.blackText,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'DMSans',
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextfield(
                    controller: controller.firstNameController,
                    text: 'Enter first name',
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validation: controller.validateFirstName,
                    filledColor: AppColors.lightGray,
                    borderRadius: 50,
                  ),

                  const SizedBox(height: 20),

                  // Last Name field
                  const Text(
                    'Last Name',
                    style: TextStyle(
                      color: AppColors.blackText,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'DMSans',
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextfield(
                    controller: controller.lastNameController,
                    text: 'Enter last name',
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validation: controller.validateLastName,
                    filledColor: AppColors.lightGray,
                    borderRadius: 50,
                  ),

                  const SizedBox(height: 20),

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

                  // Phone Number field
                  const Text(
                    'Phone Number',
                    style: TextStyle(
                      color: AppColors.blackText,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'DMSans',
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextfield(
                    controller: controller.phoneController,
                    text: 'Enter phone number',
                    textInputType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    validation: controller.validatePhone,
                    filledColor: AppColors.lightGray,
                    borderRadius: 50,
                  ),

                  const SizedBox(height: 32),

                  // Save Changes button
                  Obx(
                    () => CustomButton(
                      title: 'Save Changes',
                      onTap: controller.saveChanges,
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

                  const SizedBox(height: 16),

                  // Delete Account button
                  Center(
                    child: TextButton(
                      onPressed: controller.deleteAccount,
                      child: const Text(
                        'Delete Account',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'DMSans',
                        ),
                      ),
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
