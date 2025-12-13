import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../controllers/points_tiers_controller.dart';

class PointsTiersScreen extends GetView<PointsTiersController> {
  const PointsTiersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'Points Tiers',
        showBackButton: true,
        showNotification: false,
        showSettings: false,
        onBackTap: () => Get.back(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Top Member Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      // Background Pattern
                      Positioned.fill(
                        child: SvgPicture.asset(
                          'assets/icons/points_ties_bg.svg',
                          fit: BoxFit.cover,
                          placeholderBuilder:
                              (context) => Container(color: AppColors.primary),
                        ),
                      ),
                      // Content
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Joined\n08/24',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'DMSans',
                                height: 1.4,
                              ),
                            ),
                            const Spacer(),
                            const Text(
                              'Elite',
                              style: TextStyle(
                                color: Color(
                                  0xFFFF9900,
                                ), // Orange/Gold color from screenshot
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'DMSans',
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Member Number\n5154223',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'DMSans',
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Logo Top Right
                      Positioned(
                        top: 24,
                        right: 24,
                        child: SvgPicture.asset(
                          'assets/icons/new_point_tiers.svg',
                          width: 48,
                          height: 48,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Progress Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Elite',
                        style: TextStyle(
                          color: AppColors.blackText,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'DMSans',
                        ),
                      ),
                      Text(
                        'Diamond',
                        style: TextStyle(
                          color: AppColors.textHint,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'DMSans',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Progress Bar
                  Stack(
                    children: [
                      Container(
                        height: 6,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.lightBorder,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      Container(
                        height: 6,
                        width:
                            MediaQuery.of(context).size.width *
                            0.4, // Mock 40% progress
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        '773 Tiers Credits',
                        style: TextStyle(
                          color: AppColors.textHint,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'DMSans',
                        ),
                      ),
                      Text(
                        '2,499',
                        style: TextStyle(
                          color: AppColors.textHint,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'DMSans',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Your Tiers',
                style: TextStyle(
                  color: AppColors.blackText,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DMSans',
                ),
              ),
            ),
            const SizedBox(height: 16),

            // PageView of Tiers
            Obx(() {
              if (controller.tiers.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return SizedBox(
                height: 550, // Fixed height for carousel
                child: PageView.builder(
                  controller: controller.pageController,
                  itemCount: controller.tiers.length,
                  onPageChanged: controller.updateIndex,
                  itemBuilder: (context, index) {
                    final tier = controller.tiers[index];
                    return _buildTierCard(tier);
                  },
                ),
              );
            }),
            const SizedBox(height: 20),
            // Page Indicator
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.tiers.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          controller.currentIndex.value == index
                              ? AppColors.primary
                              : AppColors.lightBorder,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ), // Column
      ), // SingleChildScrollView
    ); // Scaffold
  }

  Widget _buildTierCard(TierModel tier) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white, // Always white
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/new_point_tiers.svg',
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Tier Name
          Text(
            tier.name,
            style: const TextStyle(
              color: AppColors.blackText,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'DMSans',
            ),
          ),
          const SizedBox(height: 4),

          // Points Range
          Text(
            tier.pointsRange,
            style: const TextStyle(
              color: AppColors.textHint,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'DMSans',
            ),
          ),

          const SizedBox(height: 16),

          // Benefits List
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    tier.benefits.map((benefit) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Icon(
                                Icons.circle,
                                size: 4,
                                color: AppColors.blackText,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                benefit,
                                style: const TextStyle(
                                  color: AppColors.blackText,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'DMSans',
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
