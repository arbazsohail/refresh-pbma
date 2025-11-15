import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepIndicator({
    super.key,
    required this.currentStep,
    this.totalSteps = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        final stepNumber = index + 1;
        final isActive = stepNumber <= currentStep;
        final isLast = index == totalSteps - 1;

        return Row(
          children: [
            // Step circle
            Column(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isActive ? AppColors.secondary : AppColors.lightGray,
                  ),
                  child: Center(
                    child: Text(
                      '$stepNumber',
                      style: TextStyle(
                        color: isActive ? AppColors.white : AppColors.blackText,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'DMSans',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Step $stepNumber',
                  style: TextStyle(
                    color: isActive ? AppColors.secondary : AppColors.greyText,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'DMSans',
                  ),
                ),
              ],
            ),

            // Connecting line (if not last step)
            if (!isLast)
              Container(
                width: Get.width * 0.40,
                height: 2,
                margin: const EdgeInsets.only(bottom: 20),
                child: Stack(
                  children: [
                    // Background grey line
                    Container(
                      width: Get.width * 0.40,
                      height: 2,
                      color: AppColors.lightGray,
                    ),
                    // Animated blue progress line
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      width: currentStep > stepNumber
                          ? Get.width * 0.40
                          : 0,
                      height: 2,
                      color: AppColors.secondary,
                    ),
                  ],
                ),
              ),
          ],
        );
      }),
    );
  }
}
