import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/onboarding_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConstants.lightSystemOverlay(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              // Skip Button (minimal padding)
              Obx(
                () => Padding(
                  padding: const EdgeInsets.only(top: 16, right: 16, bottom: 8),
                  child: Align(
                    alignment: Alignment.topRight,
                    child:
                        controller.currentPage.value < 2
                            ? SizedBox(
                              height: 40,
                              child: TextButton(
                                onPressed: controller.skipOnboarding,
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  'Skip',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                            : const SizedBox(height: 40),
                  ),
                ),
              ),

              // PageView with content
              SizedBox(
                height: Get.height * 0.55,
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  itemCount: controller.onboardingPages.length,
                  itemBuilder: (context, index) {
                    final page = controller.onboardingPages[index];
                    return _OnboardingPage(
                      image: page.image,
                      title: page.title,
                      description: page.description,
                    );
                  },
                ),
              ),

              // Page Indicators - Fixed position
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    controller.onboardingPages.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            controller.currentPage.value == index
                                ? AppColors.primary
                                : AppColors.primary.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),

              // Navigation Buttons at bottom
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back Button
                      if (controller.currentPage.value > 0)
                        TextButton(
                          onPressed: controller.previousPage,
                          child: Text(
                            'Back',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      else
                        const SizedBox(width: 60),

                      // Next/Get Started Button with Figma specs
                      Obx(() {
                        final isLastPage =
                            controller.currentPage.value ==
                            controller.onboardingPages.length - 1;

                        // Get Started has gradient, Next has solid color
                        if (isLastPage) {
                          // Get Started button with gradient
                          return Ink(
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: InkWell(
                              onTap: controller.nextPage,
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 36,
                                ),
                                child: const Text(
                                  'Get Started',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'DMSans',
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          // Next button with solid color
                          return ElevatedButton(
                            onPressed: controller.nextPage,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shadowColor: Colors.transparent,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 40,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  34,
                                ), // 34px border radius
                              ),
                              minimumSize: Size.zero,
                            ),
                            child: const Text(
                              'Next',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'DMSans',
                              ),
                            ),
                          );
                        }
                      }),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const _OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          // Image with Figma specs: 96px border radius, 3px border, cover
          Container(
            width: double.infinity,
            height: 280,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(96),
              border: Border.all(
                color: AppColors.secondary,
                width: 3,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(93), // 96 - 3 (border width)
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ),

          const SizedBox(height: 32),

          // Title - Figma specs
          Text(
            title,
            style: const TextStyle(
              color: AppColors.darkBlueText,
              fontSize: 23,
              fontWeight: FontWeight.w500,
              fontFamily: 'DMSans',
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12),

          // Description - Figma specs
          Text(
            description,
            style: const TextStyle(
              color: AppColors.greyText,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'DMSans',
              height: 1.5, // 150% line height
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
