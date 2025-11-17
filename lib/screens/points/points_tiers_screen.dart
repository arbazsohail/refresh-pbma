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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Point Conversion Section
            Card(
              color: Color(0xffFFFFFF),

              elevation: 0.2,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Point Conversion',
                      style: TextStyle(
                        color: AppColors.blackText,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'DMSans',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2F6FA),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/icons/star.svg',
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            '10 points = \$100 credit\ntoward any service',
                            style: TextStyle(
                              color: AppColors.blackText,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'DMSans',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/minimum.svg',
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Minimum redemption: 500 points ( \$50 )',
                          style: TextStyle(
                            color: Color(0xff91989E),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'DMSans',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Ways to Earn Points Section
            Card(
              color: Color(0xffFFFFFF),
              elevation: 0.2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ways to Earn Points',
                      style: TextStyle(
                        color: AppColors.blackText,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'DMSans',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        // Refer Someone Card
                        Expanded(
                          child: Container(
                            height: Get.height * 0.15,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xffF6F6F6),
                              borderRadius: BorderRadius.circular(8),
                              border: const Border(
                                left: BorderSide(
                                  color: AppColors.secondary,
                                  width: 3,
                                ),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFFB4B4B4,
                                  ).withValues(alpha: 0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                SvgPicture.asset(
                                  'assets/icons/clip.svg',
                                  height: 24,
                                  width: 24,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.secondary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  textAlign: TextAlign.center,
                                  'Refer a Friend Who Purchase',
                                  style: TextStyle(
                                    color: Color(0xff475159),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'DMSans',
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "500 Points",
                                  style: const TextStyle(
                                    color: AppColors.secondary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'DMSans',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        // Share Link Card
                        Expanded(
                          child: Container(
                            height: Get.height * 0.15,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xffF6F6F6),
                              borderRadius: BorderRadius.circular(8),
                              border: const Border(
                                left: BorderSide(
                                  color: AppColors.secondary,
                                  width: 3,
                                ),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFFB4B4B4,
                                  ).withValues(alpha: 0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                SvgPicture.asset(
                                  'assets/icons/scan.svg',
                                  height: 24,
                                  width: 24,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.secondary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  textAlign: TextAlign.center,
                                  'Scan QR code in office at every visit',
                                  style: TextStyle(
                                    color: Color(0xff475159),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'DMSans',
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "10 Points",
                                  style: const TextStyle(
                                    color: AppColors.secondary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'DMSans',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Points Tiers & Rewards Section
            const Text(
              'Points Tiers & Rewards',
              style: TextStyle(
                color: AppColors.blackText,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'DMSans',
              ),
            ),
            const SizedBox(height: 16),

            // Reward Tiers Grid
            Obx(
              () => GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.80,
                ),
                itemCount: controller.rewardTiers.length,
                itemBuilder: (context, index) {
                  final tier = controller.rewardTiers[index];
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFB4B4B4).withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Gift icon
                        SvgPicture.asset(
                          'assets/icons/gift.svg',
                          width: 32,
                          height: 32,
                        ),
                        const SizedBox(height: 12),

                        // Points
                        Text(
                          tier.points,
                          style: const TextStyle(
                            color: AppColors.secondary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'DMSans',
                          ),
                        ),
                        const SizedBox(height: 4),

                        // Referrals
                        Text(
                          tier.referrals,
                          style: const TextStyle(
                            color: Color(0xFF888F9A),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'DMSans',
                          ),
                        ),

                        // Title
                        Text(
                          tier.title,
                          style: const TextStyle(
                            color: AppColors.blackText,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'DMSans',
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Value
                        Text(
                          tier.value,
                          style: const TextStyle(
                            color: Color(0xFF888F9A),
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'DMSans',
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
