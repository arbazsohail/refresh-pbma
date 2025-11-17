import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../controllers/how_to_earn_controller.dart';

class HowToEarnScreen extends GetView<HowToEarnController> {
  const HowToEarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'How to Earn',
        showBackButton: true,
        showNotification: false,
        showSettings: false,
        onBackTap: () => Get.back(),
        
       
      ),
      body: Obx(
        () => ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: controller.earnOptions.length,
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemBuilder: (context, optionIndex) {
            final option = controller.earnOptions[optionIndex];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Option Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    option.optionTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'DMSans',
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Steps
                ...option.steps.asMap().entries.map((entry) {
                  final step = entry.value;
                  final isLastStep = entry.key == option.steps.length - 1;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Step Number
                      Text(
                        step.stepNumber,
                        style: const TextStyle(
                          color: Color(0xFF141413),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'DMSans',
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6F6F6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title with Icon
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/pin.svg',
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    step.title,
                                    style: const TextStyle(
                                      color: Color(0xFF141413),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'DMSans',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Description
                            Padding(
                              padding: const EdgeInsets.only(left: 28),
                              child: Text(
                                step.description,
                                style: const TextStyle(
                                  color: Color(0xFF888F9A),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'DMSans',
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!isLastStep) const SizedBox(height: 16),
                    ],
                  );
                }),
              ],
            );
          },
        ),
      ),
    );
  }
}
