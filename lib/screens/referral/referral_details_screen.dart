import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/referral_step_indicator.dart';
import '../../controllers/referral_details_controller.dart';

class ReferralDetailsScreen extends GetView<ReferralDetailsController> {
  const ReferralDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'Refer Status',
        showBackButton: true,
        showNotification: false,
        showSettings: false,
        onBackTap: () => Get.back(),
      
       
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              'Referral Status',
              style: TextStyle(
                color: AppColors.blackText,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'DMSans',
              ),
            ),
            const SizedBox(height: 24),

            // Referral Info Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFB4B4B4).withValues(alpha: 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    controller.referral.name,
                    style: const TextStyle(
                      color: AppColors.blackText,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'DMSans',
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Date
                  Text(
                    'Referred on ${controller.referral.date.replaceAll('Date: ', '')}',
                    style: const TextStyle(
                      color: Color(0xFF888F9A),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'DMSans',
                    ),
                  ),
                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color:
                          controller.referral.isRewarded
                              ? AppColors.lightGreen
                              : AppColors.lightYellow,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Text(
                      controller.referral.status,
                      style: TextStyle(
                        color:
                            controller.referral.isRewarded
                                ? AppColors.darkGreen
                                : AppColors.darkYellow,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'DMSans',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Step Indicator
                  Obx(
                    () => ReferralStepIndicator(
                      currentStep: controller.currentStep.value,
                      stepLabels: controller.stepLabels,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
