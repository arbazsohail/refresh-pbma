import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:refresh_pbma/widgets/custom_button.dart';
import 'package:animated_digit/animated_digit.dart';
import '../../../utils/app_colors.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_refresh_header.dart';
import '../../../widgets/custom_refresh_footer.dart';
import '../../../widgets/shimmers/home_shimmer.dart';
import '../../../widgets/referral_card_widget.dart';
import '../../../controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        leadingText: 'Welcome Back,\nJayy!',
        showNotification: true,
        showSettings: true,
        
       
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const HomeShimmer()
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
            // Overview Section Title
            const Text(
              'Overview',
              style: TextStyle(
                color: AppColors.blackText,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'DMSans',
              ),
            ),
            const SizedBox(height: 16),

            // Overview Cards
            Row(
              children: [
                // Total Referrals Card
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: const Border(
                        left: BorderSide(color: Color(0xFF195B91), width: 3),
                      ),
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
                        SvgPicture.asset(
                          'assets/icons/referrals.svg',
                          width: 20,
                          height: 20,
                          colorFilter: const ColorFilter.mode(
                            AppColors.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Total Referrals',
                          style: TextStyle(
                            color: Color(0xff475159),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'DMSans',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Obx(
                          () => AnimatedDigitWidget(
                            value: controller.homeData.value.totalReferrals,
                            textStyle: const TextStyle(
                              color: AppColors.secondary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'DMSans',
                            ),
                            duration: const Duration(milliseconds: 1500),
                            curve: Curves.easeOutCubic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Rewards Earned Card
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: const Border(
                        left: BorderSide(color: Color(0xFF195B91), width: 3),
                      ),
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
                        SvgPicture.asset(
                          'assets/icons/trophy.svg',
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Rewards Earned',
                          style: TextStyle(
                            color: Color(0xff475159),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'DMSans',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Obx(
                          () => Row(
                            children: [
                              AnimatedDigitWidget(
                                value: controller.homeData.value.rewardsPoints,
                                textStyle: const TextStyle(
                                  color: AppColors.secondary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'DMSans',
                                ),
                                duration: const Duration(milliseconds: 1500),
                                curve: Curves.easeOutCubic,
                              ),
                              const Text(
                                ' Points',
                                style: TextStyle(
                                  color: AppColors.secondary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'DMSans',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Share Referral Link',
              style: TextStyle(
                color: AppColors.blackText,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'DMSans',
              ),
            ),
            const SizedBox(height: 10),

            // Share Referral Link Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
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
                  // Referral Link Input
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F4F8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => Text(
                              controller.homeData.value.referralLink,
                              style: const TextStyle(
                                color: Color(0xff141413),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(
                                text: controller.homeData.value.referralLink,
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Referral link copied to clipboard',
                                ),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.copy,
                            color: AppColors.secondary,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  CustomButton(
                    title: 'Share Link',
                    onTap: controller.shareReferralLink,
                    height: 50,
                    backgroundColor: const Color(0xff2D5F9B),
                    textColor: AppColors.white,
                    borderRadius: 8,
                    margin: 0,
                    horizontalPadding: 36,
                    titleFontSize: 16,
                    icon: 'assets/icons/share.svg',
                    iconSpacing: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Recent Referrals Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Referrals',
                  style: TextStyle(
                    color: AppColors.blackText,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DMSans',
                  ),
                ),
                GestureDetector(
                  onTap: controller.navigateToAllReferrals,
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

            // Recent Referrals List
            Obx(
              () => ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.recentReferrals.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final referral = controller.recentReferrals[index];
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
