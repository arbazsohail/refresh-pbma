import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../utils/app_colors.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_refresh_header.dart';
import '../../../widgets/custom_refresh_footer.dart';
import '../../../widgets/shimmers/referrals_shimmer.dart';
import '../../../widgets/referral_card_widget.dart';
import '../../../controllers/referrals_controller.dart';

class ReferralsPage extends GetView<ReferralsController> {
  const ReferralsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'Referrals',
        showNotification: true,
        showSettings: true,
       
      ),
      body: Obx(
        () =>
            controller.isLoading.value
                ? const ReferralsShimmer()
                : SmartRefresher(
                  controller: controller.refreshController,
                  enablePullDown: true,
                  enablePullUp: false,
                  header: const CustomRefreshHeader(),
                  footer: const CustomRefreshFooter(),
                  onRefresh: controller.onRefresh,
                  onLoading: controller.onLoading,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // My Referrals Section
                        const Text(
                          'My Referrals',
                          style: TextStyle(
                            color: AppColors.blackText,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'DMSans',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Obx(
                          () => Text(
                            'You\'ve referred 5 people ${controller.totalReferrals.value}\npoints (\$250) earned',
                            style: const TextStyle(
                              color: Color(0xFF888F9A),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'DMSans',
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Reward Points Card
                        Obx(
                          () => Container(
                            padding: const EdgeInsets.fromLTRB(20, 20, 6, 18),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: const Border(
                                left: BorderSide(
                                  color: Color(0xFF195B91),
                                  width: 4,
                                ),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFFBCBCBC,
                                  ).withValues(alpha: 0.25),
                                  blurRadius: 20,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                    const SizedBox(width: 12),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Reward Points',
                                          style: TextStyle(
                                            color: AppColors.blackText,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'DMSans',
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            AnimatedDigitWidget(
                                              value: controller.totalReferrals.value,
                                              textStyle: const TextStyle(
                                                color: Color(0xFF141413),
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'DMSans',
                                              ),
                                              duration: const Duration(milliseconds: 1500),
                                              curve: Curves.easeOutCubic,
                                            ),
                                            Text(
                                              '/${controller.targetReferrals.value}',
                                              style: const TextStyle(
                                                color: Color(0xFF888F9A),
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'DMSans',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),

                                // Progress Bar
                                TweenAnimationBuilder<double>(
                                  duration: const Duration(milliseconds: 1500),
                                  curve: Curves.easeOutCubic,
                                  tween: Tween<double>(
                                    begin: 0,
                                    end:
                                        controller.totalReferrals.value /
                                        controller.targetReferrals.value,
                                  ),
                                  builder: (context, value, child) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: LinearProgressIndicator(
                                        value: value,
                                        minHeight: 8,
                                        backgroundColor: const Color(
                                          0xFFE8E8E8,
                                        ),
                                        valueColor:
                                            const AlwaysStoppedAnimation<Color>(
                                              AppColors.primary,
                                            ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 20),

                                const Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      color: Color(0xFF757D83),
                                      size: 16,
                                    ),
                                    SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        'Complete more 500 points to get surprise goodie bag!',
                                        style: TextStyle(
                                          color: Color(0xFF757D83),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'DMSans',
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Points Tiers and How to Earn Row
                        Row(
                          children: [
                            // Points Tiers Card
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.pointsTiers);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF6F6F6),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,

                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/medal.svg',
                                        width: 24,
                                        height: 24,
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'Points Tiers',
                                        style: TextStyle(
                                          color: Color(0xFF141413),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'DMSans',
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),

                            // How to Earn Card
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.howToEarn);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF6F6F6),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/bag.svg',
                                        width: 24,
                                        height: 24,
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'How to Earn',
                                        style: TextStyle(
                                          color: Color(0xFF141413),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'DMSans',
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // All Referrals Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'All Referrals',
                              style: TextStyle(
                                color: AppColors.blackText,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'DMSans',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                              },
                              child: const Text(
                                'View all',
                                style: TextStyle(
                                  color: AppColors.secondary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'DMSans',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Referrals List
                        Obx(
                          () => ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.allReferrals.length,
                            separatorBuilder:
                                (context, index) => const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final referral = controller.allReferrals[index];
                              return ReferralCardWidget(
                                referral: referral,
                                onTap: () {
                                  Get.toNamed(
                                    AppRoutes.referralDetails,
                                    arguments: referral,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
      ),
    );
  }
}
