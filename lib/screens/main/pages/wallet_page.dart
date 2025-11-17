import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_refresh_header.dart';
import '../../../widgets/custom_refresh_footer.dart';
import '../../../widgets/shimmers/wallet_shimmer.dart';
import '../../../controllers/wallet_controller.dart';

class WalletPage extends GetView<WalletController> {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'Wallet',
        showNotification: true,
        showSettings: true,
       
       
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const WalletShimmer()
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
                      // Wallet Points Widget
                      Card(
                        elevation: 0.1,
                        color: AppColors.lightBackground,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              // Wallet Icon
                              SvgPicture.asset(
                                'assets/icons/filledWallet.svg',
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(height: 12),
                              // Points Display
                              Row(
                                children: [
                                  Obx(
                                    () => AnimatedDigitWidget(
                                      value: controller.totalPoints.value,
                                      textStyle: const TextStyle(
                                        color: Color(0xFF141413),
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'DMSans',
                                      ),
                                      fractionDigits: 0,
                                      enableSeparator: true,
                                      separateSymbol: ',',
                                    ),
                                  ),
                                  const Text(
                                    ' Points',
                                    style: TextStyle(
                                      color: Color(0xFF141413),
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'DMSans',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              // Credit Amount
                              Obx(
                                () => Text(
                                  '\$${controller.creditAmount.value.toStringAsFixed(0)} in service credit',
                                  style: const TextStyle(
                                    color: Color(0xFF888F9A),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'DMSans',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Redeem Points Button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: controller.redeemPoints,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Redeem Points',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'DMSans',
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Scan Card
                      GestureDetector(
                        onTap: controller.openScanner,
                        child: Card(
                          elevation: 0.1,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'Scan & Earn 10 Points Each\n Time You Visit!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF141413),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'DMSans',
                                  ),
                                ),
                                const SizedBox(height: 16),
                                // Scan Icon
                                Container(
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    color: AppColors.secondary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/icons/scan.svg',
                                      width: 32,
                                      height: 32,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  'Tap to Scan',
                                  style: TextStyle(
                                    color: AppColors.greyText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'DMSans',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Points History Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Points History',
                            style: TextStyle(
                              color: Color(0xFF141413),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'DMSans',
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
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
                      const SizedBox(height: 12),
                      // Points History List
                      Obx(
                        () => ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.pointsHistory.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final history = controller.pointsHistory[index];
                            return Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF6F6F6),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          history.status,
                                          style: const TextStyle(
                                            color: Color(0xFF141413),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'DMSans',
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          history.userName,
                                          style: const TextStyle(
                                            color: Color(0xFF888F9A),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'DMSans',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${history.points} Points',
                                        style: TextStyle(
                                          color: history.isRedeemed
                                              ? const Color(0xFFE41313)
                                              : const Color(0xFF27AE60),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'DMSans',
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        history.date,
                                        style: const TextStyle(
                                          color: Color(0xFF888F9A),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'DMSans',
                                        ),
                                      ),
                                    ],
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
              ),
      ),
    );
  }
}
