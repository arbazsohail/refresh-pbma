import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../models/how_to_earn_model.dart';
import '../models/referral_model.dart';

class ReferralsController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxInt totalReferrals = 0.obs;
  final RxInt targetReferrals = 0.obs;
  final RxList<HowToEarnModel> howToEarnList = <HowToEarnModel>[].obs;
  final RxList<ReferralModel> allReferrals = <ReferralModel>[].obs;
  final RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  Future<void> loadInitialData() async {
    isLoading.value = true;
    await Future.wait([
      fetchReferralsData(),
      fetchHowToEarnData(),
      fetchAllReferrals(),
    ]);
    isLoading.value = false;
  }

  Future<void> fetchReferralsData() async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      // Simulated data
      totalReferrals.value = 1890;
      targetReferrals.value = 2500;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch referrals data: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> fetchHowToEarnData() async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      // Simulated data
      howToEarnList.value = [
        HowToEarnModel(
          iconPath: 'assets/icons/star.svg',
          title: 'Share App',
          description: 'Share app with your friends and earn rewards',
          status: 'Completed',
          isCompleted: true,
        ),
        HowToEarnModel(
          iconPath: 'assets/icons/medal.svg',
          title: 'Get Payment',
          description: 'Complete payment to unlock rewards',
          status: 'Pending',
          isCompleted: false,
        ),
        HowToEarnModel(
          iconPath: 'assets/icons/bag.svg',
          title: 'Start Invest',
          description: 'Start investing and earn more rewards',
          status: 'Pending',
          isCompleted: false,
        ),
      ];
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch how to earn data: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> fetchAllReferrals() async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      // Simulated data - more referrals for the all referrals list
      allReferrals.value = List.generate(
        10,
        (index) => ReferralModel(
          name: 'Alex Carry ${index + 1}',
          date: 'Date: 24 June, 2025',
          status: index % 2 == 0 ? 'Rewarded' : 'Pending',
          points: index % 2 == 0 ? '3,500 points' : '',
          isRewarded: index % 2 == 0,
        ),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch all referrals: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> onRefresh() async {
    try {
      await Future.wait([
        fetchReferralsData(),
        fetchHowToEarnData(),
        fetchAllReferrals(),
      ]);
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.refreshFailed();
    }
  }

  Future<void> onLoading() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      refreshController.loadComplete();
    } catch (e) {
      refreshController.loadFailed();
    }
  }
}
