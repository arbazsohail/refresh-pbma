import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/signup_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/step_indicator.dart';
import '../../widgets/phone_number_field.dart';

class SignupScreen extends GetView<SignupController> {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConstants.lightSystemOverlay(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              // Header with back button
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    CustomBackButton(
                      onTap: () {
                        if (controller.currentStep.value == 2) {
                          controller.goBackToStep1();
                        } else {
                          Get.back();
                        }
                      },
                    ),
                  ],
                ),
              ),

              // Step indicator
              Obx(
                () => StepIndicator(
                  currentStep: controller.currentStep.value,
                  totalSteps: 2,
                ),
              ),

              const SizedBox(height: 32),

              // Content based on current step
              Expanded(
                child: Obx(
                  () =>
                      controller.currentStep.value == 1
                          ? _buildStep1()
                          : _buildStep2(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Step 1: Account Setup
  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Form(
        key: controller.step1FormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              "Let's Get Your Account Set Up",
              style: TextStyle(
                color: AppColors.blackText,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'DMSans',
              ),
            ),

            const SizedBox(height: 32),

            // First Name
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
              validation:
                  (value) => controller.validateName(value, 'first name'),
              filledColor: AppColors.lightGray,
              borderRadius: 50,
            ),

            const SizedBox(height: 20),

            // Last Name
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
              validation:
                  (value) => controller.validateName(value, 'last name'),
              filledColor: AppColors.lightGray,
              borderRadius: 50,
            ),

            const SizedBox(height: 20),

            // Date of Birth
            const Text(
              'Date of Birth',
              style: TextStyle(
                color: AppColors.blackText,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'DMSans',
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => controller.selectDOB(Get.context!),
              child: AbsorbPointer(
                child: CustomTextfield(
                  controller: controller.dobController,
                  text: 'YYYY/MM/DD',
                  textInputAction: TextInputAction.next,
                  validation: controller.validateDOB,
                  filledColor: AppColors.lightGray,
                  borderRadius: 50,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Email
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

            // Phone number
            const Text(
              'Phone number',
              style: TextStyle(
                color: AppColors.blackText,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'DMSans',
              ),
            ),
            const SizedBox(height: 8),
            PhoneNumberField(
              controller: controller.phoneController,
              validation: controller.validatePhone,
              selectedCountryCode: controller.selectedCountryCode,
            ),

            const SizedBox(height: 32),

            // Continue button
            Obx(
              () => CustomButton(
                title: 'Continue',
                onTap: controller.continueToStep2,
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

            // Already have account button
            GestureDetector(
              onTap: controller.goToSignIn,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.lightGray,
                  borderRadius: BorderRadius.circular(58),
                ),
                child: Center(
                  child: Text(
                    "Already have an account ? Sign in",
                    style: TextStyle(
                      color: AppColors.blackText,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'DMSans',
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // "or" divider
            const Row(
              children: [
                Expanded(
                  child: Divider(color: AppColors.lightBorder, thickness: 1),
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
                  child: Divider(color: AppColors.lightBorder, thickness: 1),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Continue with Google button
            Obx(
              () => CustomButton(
                title: 'Continue with Google',
                onTap: controller.signUpWithGoogle,
                height: 54,
                backgroundColor: AppColors.lightGray,
                textColor: AppColors.blackText,
                borderRadius: 58,
                margin: 0,
                horizontalPadding: 36,
                titleFontSize: 16,
                icon: 'assets/icons/google.svg',
                iconSpacing: 5,
                loading: controller.isLoading.value,
              ),
            ),

            const SizedBox(height: 16),

            // Continue with Apple button
            Obx(
              () => CustomButton(
                title: 'Continue with Apple',
                onTap: controller.signUpWithApple,
                height: 54,
                backgroundColor: AppColors.lightGray,
                textColor: AppColors.blackText,
                borderRadius: 58,
                margin: 0,
                horizontalPadding: 36,
                titleFontSize: 16,
                icon: 'assets/icons/apple.svg',
                iconSpacing: 5,
                loading: controller.isLoading.value,
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // Step 2: Password Setup
  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Form(
        key: controller.step2FormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              'Create Your Password',
              style: TextStyle(
                color: AppColors.blackText,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'DMSans',
              ),
            ),

            const SizedBox(height: 32),

            // Password
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
              text: 'Enter Password',
              obsecureText: true,
              showPasswordToggle: true,
              textInputAction: TextInputAction.next,
              validation: controller.validatePassword,
              filledColor: AppColors.lightGray,
              borderRadius: 50,
            ),

            const SizedBox(height: 20),

            // Confirm Password
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

            const SizedBox(height: 24),

            // Terms and conditions text
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                  color: AppColors.greyText,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'DMSans',
                  height: 1.5,
                ),
                children: [
                  const TextSpan(
                    text:
                        'By creating an account using email, Google, or Apple, I agree to the ',
                  ),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: controller.openTerms,
                      child: const Text(
                        'terms and Conditions',
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'DMSans',
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  const TextSpan(text: ' and acknowledge the '),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: controller.openPrivacyPolicy,
                      child: const Text(
                        'Privacy Policy',
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'DMSans',
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Sign up button
            Obx(
              () => CustomButton(
                title: 'Sign up',
                onTap: controller.signUp,
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

            // Already have account button
            GestureDetector(
              onTap: controller.goToSignIn,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.lightGray,
                  borderRadius: BorderRadius.circular(58),
                ),
                child: Text(
                  "Already have an account ? Sign in",
                  style: TextStyle(
                    color: AppColors.blackText,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'DMSans',
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
