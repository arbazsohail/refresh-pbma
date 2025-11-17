import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../models/home_data_model.dart';
import '../models/referral_model.dart';

class HomeController extends GetxController {
  final RxBool isLoading = true.obs;
  final Rx<HomeDataModel> homeData = HomeDataModel(
    totalReferrals: 1200,
    rewardsPoints: 3500,
    rewardsMoney: 350,
    referralLink: 'https://app.com/ref?code=Jayy123',
  ).obs;
  final RxList<ReferralModel> recentReferrals = <ReferralModel>[].obs;
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
      fetchHomeData(),
      fetchRecentReferrals(),
    ]);
    isLoading.value = false;
  }

  Future<void> fetchHomeData() async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      // Simulated data - replace with actual API response
      homeData.value = HomeDataModel(
        totalReferrals: 1237,
        rewardsPoints: 9990,
        rewardsMoney: 350,
        referralLink: 'https://app.com/ref?code=Jayy123',
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch home data: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> fetchRecentReferrals() async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      // Simulated data - replace with actual API response
      recentReferrals.value = [
        ReferralModel(
          name: 'Alex Carry',
          date: 'Date: 24 June, 2025',
          status: 'Rewarded',
          points: '3,500 points',
          isRewarded: true,
        ),
        ReferralModel(
          name: 'Alex Carry',
          date: 'Date: 24 June, 2025',
          status: 'Pending',
          points: '',
          isRewarded: false,
        ),
        ReferralModel(
          name: 'Alex Carry',
          date: 'Date: 24 June, 2025',
          status: 'Rewarded',
          points: '3,500 points',
          isRewarded: true,
        ),
        ReferralModel(
          name: 'Alex Carry',
          date: 'Date: 24 June, 2025',
          status: 'Pending',
          points: '',
          isRewarded: false,
        ),
      ];
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch referrals: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> onRefresh() async {
    try {
      await Future.wait([
        fetchHomeData(),
        fetchRecentReferrals(),
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

  void navigateToAllReferrals() {
    Get.snackbar(
      'Navigation',
      'Navigate to all referrals',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void shareReferralLink() {
    Get.snackbar(
      'Share',
      'Share referral link functionality coming soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
