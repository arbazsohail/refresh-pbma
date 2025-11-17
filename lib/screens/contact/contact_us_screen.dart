import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/contact_us_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class ContactUsScreen extends GetView<ContactUsController> {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConstants.darkSystemOverlay(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const CustomAppBar(
          title: 'Contact Us',
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

                  // Title
                  const Text(
                    'Contact Us',
                    style: TextStyle(
                      color: AppColors.blackText,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'DMSans',
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Name field
                  CustomTextfield(
                    controller: controller.nameController,
                    text: 'Enter your name',
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validation: controller.validateName,
                    filledColor: AppColors.lightGray,
                    borderRadius: 50,
                  ),

                  const SizedBox(height: 20),

                  // Email field
                  CustomTextfield(
                    controller: controller.emailController,
                    text: 'Enter your email',
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validation: controller.validateEmail,
                    filledColor: AppColors.lightGray,
                    borderRadius: 50,
                  ),

                  const SizedBox(height: 20),

                  // Message field
                  CustomTextfield(
                    controller: controller.messageController,
                    text: 'Enter your message',
                    textInputType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    validation: controller.validateMessage,
                    filledColor: AppColors.lightGray,
                    borderRadius: 12,
                    maxLines: 6,
                  ),

                  const SizedBox(height: 32),

                  // Submit button
                  Obx(
                    () => CustomButton(
                      title: 'Submit',
                      onTap: controller.submitContactForm,
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
