import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../controllers/points_tiers_controller.dart';

class PointsTiersScreen extends GetView<PointsTiersController> {
  PointsTiersScreen({super.key});

  final ScrollController _scrollController = ScrollController();
  final GlobalKey _otherTiersKey = GlobalKey();

  void _scrollToOtherTiers() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_otherTiersKey.currentContext != null) {
        Scrollable.ensureVisible(
          _otherTiersKey.currentContext!,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'Points Tiers',
        showBackButton: true,
        showNotification: true,
        showSettings: true,
        onBackTap: () => Get.back(),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            /// ---------------- TOP CARD ----------------
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
                      Positioned.fill(
                        right: 0,
                        left: 100,
                        child: Image.asset('assets/images/7 1.png'),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Joined\n08/24',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'DMSans',
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Elite',
                              style: TextStyle(
                                color: Color(0xFFFFAC33),
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'DMSans',
                              ),
                            ),
                            Spacer(),
                            const Text(
                              'Member Number\n5154223',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
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
                          'assets/icons/RLOGO.svg',
                          width: 59,
                          height: 78,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

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
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'DMSans',
                        ),
                      ),
                      Text(
                        'Diamond',
                        style: TextStyle(
                          color: AppColors.textHint,
                          fontSize: 16,
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
                        height: 8,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.lightBorder,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      Container(
                        height: 8,
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
                  const SizedBox(height: 7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        '773 Tiers Credits',
                        style: TextStyle(
                          color: Color(0xff888F9A),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'DMSans',
                        ),
                      ),
                      Text(
                        '2,499',
                        style: TextStyle(
                          color: Color(0xff888F9A),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'DMSans',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// ---------------- YOUR TIER ----------------
            Obx(() {
              if (controller.tiers.isEmpty) return const SizedBox.shrink();
              final activeTier = controller.activeTier;
              if (activeTier == null) return const SizedBox.shrink();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Your Tier',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackText,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: _buildTierCard(activeTier),
                  ),
                ],
              );
            }),

            const SizedBox(height: 16),

            /// ---------------- VIEW ALL / SHOW LESS BUTTON ----------------
            Obx(() {
              if (controller.tiers.isEmpty) return const SizedBox.shrink();

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () {
                    controller.toggleShowAllTiers();
                    if (controller.showAllTiers.value) {
                      _scrollToOtherTiers();
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        controller.showAllTiers.value
                            ? 'Show Less'
                            : 'View All Tiers',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontFamily: 'DMSans',
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 16),

            // Rewards Tier Terms of Use
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () => Get.toNamed('/rewards-terms'),
                child: const Center(
                  child: Text(
                    'Rewards Tier Terms of Use',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary,
                      fontFamily: 'DMSans',
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// ---------------- OTHER TIERS (EXPANDABLE) ----------------
            Obx(() {
              if (!controller.showAllTiers.value ||
                  controller.otherTiers.isEmpty) {
                return const SizedBox.shrink();
              }

              return Column(
                key: _otherTiersKey,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      'Other Tiers',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackText,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: controller.maxHeight.value,
                    child: PageView.builder(
                      controller: controller.otherTiersPageController,
                      onPageChanged: controller.updateOtherTiersIndex,
                      itemCount: controller.otherTiers.length,
                      itemBuilder: (context, index) {
                        final tier = controller.otherTiers[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              _buildTierCard(tier),
                              SizedBox(height: 20),
                              Obx(
                                () => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    controller.otherTiers.length,
                                    (i) => Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            controller.otherTiersIndex.value ==
                                                    i
                                                ? AppColors.primary
                                                : AppColors.lightBorder,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Indicators
                ],
              );
            }),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// ---------------- TIER CARD ----------------
  Widget _buildTierCard(TierModel tier) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xffF6F6F6),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.cardcolor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              /// ICON
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/RLOGO.svg',
                    width: 35,
                    height: 35,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// TITLE
              Text(
                tier.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackText,
                ),
              ),

              const SizedBox(height: 4),

              /// POINTS
              Text(
                tier.pointsRange,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.cardsecondarycolor,
                ),
              ),

              const SizedBox(height: 16),

              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: tier.benefits.length,
                itemBuilder: (context, i) {
                  var benefit = tier.benefits[i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Icon(
                            Icons.circle,
                            size: 3,
                            color: AppColors.blackText,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            benefit,
                            style: const TextStyle(
                              color: AppColors.cardtextcolor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'DMSans',
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
