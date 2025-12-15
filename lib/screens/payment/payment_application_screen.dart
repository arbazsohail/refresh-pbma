import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../controllers/payment_application_controller.dart';

class PaymentApplicationScreen extends GetView<PaymentApplicationController> {
  const PaymentApplicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConstants.darkSystemOverlay(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const CustomAppBar(
          title: '',
          showBackButton: true,
          showNotification: false,
          showSettings: false,
        ),
        bottomNavigationBar: Container(
          child: // Continue button
              Padding(
            padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.04,
              horizontal: Get.width * 0.05,
            ),
            child: Obx(
              () => CustomButton(
                title: 'Continue',
                onTap: controller.continueToForm,
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
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              // Title
              Center(
                child: const Text(
                  textAlign: TextAlign.center,
                  'Rewards Payment Terms\nApplication',
                  style: TextStyle(
                    color: Color(0xFF141413),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'DMSans',
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Subtitle
              Center(
                child: const Text(
                  textAlign: TextAlign.center,
                  'Thank you for your interest in Refresh\'s in-house payment options.',
                  style: TextStyle(
                    color: Color(0xFF141413),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'DMSans',
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Terms content
              _buildParagraph(
                'We proudly offer in-house payment terms as a courtesy to all our valued clients. This means you can enjoy your desired services and pay over time directly through Refresh, without needing third-party lenders. All financing is administered internally and approved based on eligibility, payment history, and account standing. By applying, you understand that this is a private, financial agreement between you and Refresh Palm Beach Medical Aesthetics and/or its affiliates (Refresh Port St. Lucie Medical Aesthetics, Refresh Vero Beach Medical Aesthetics), not a loan through an external bank or credit institution. Terms, payment schedules, and service authorizations are subject to approval and may vary based on individual circumstances.',
              ),

              const SizedBox(height: 12),

              _buildParagraph(
                'Continuing with this application does not initiate a credit check or any kind of whether soft or hard and does not obligate you to any agreement or purchase.',
              ),

              const SizedBox(height: 12),

              _buildParagraph(
                'Please complete the following brief questionnaire that will help us tailor the right payment terms for your needs. Your responses are confidential and will help us provide you the most convenient plan (if applicable).',
              ),

              const SizedBox(height: 32),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF585D61),
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'DMSans',
        height: 1.5,
      ),
    );
  }
}
