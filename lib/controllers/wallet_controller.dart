import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../models/points_history_model.dart';
import '../routes/app_routes.dart';
import '../widgets/dialogs/redeem_points_dialog.dart';

class WalletController extends GetxController {
  final RxInt totalPoints = 0.obs;
  final RxDouble creditAmount = 0.0.obs;
  final RxList<PointsHistoryModel> pointsHistory = <PointsHistoryModel>[].obs;
  final RxBool isLoading = true.obs;
  final RefreshController refreshController = RefreshController();

  @override
  void onInit() {
    super.onInit();
    loadWalletData();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  Future<void> loadWalletData() async {
    isLoading.value = true;

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    totalPoints.value = 3200;
    creditAmount.value = 320.0;

    pointsHistory.value = [
      PointsHistoryModel(
        status: 'Redeemed',
        userName: 'Alex Carry',
        date: 'June 22, 2025',
        points: -50,
        isRedeemed: true,
      ),
      PointsHistoryModel(
        status: 'Redeemed',
        userName: 'Alex Carry',
        date: 'June 22, 2025',
        points: -50,
        isRedeemed: true,
      ),
      PointsHistoryModel(
        status: 'Redeemed',
        userName: 'Alex Carry',
        date: 'June 22, 2025',
        points: -50,
        isRedeemed: true,
      ),
      PointsHistoryModel(
        status: 'Redeemed',
        userName: 'Alex Carry',
        date: 'June 22, 2025',
        points: -50,
        isRedeemed: true,
      ),
    ];

    isLoading.value = false;
  }

  Future<void> onRefresh() async {
    await loadWalletData();
    refreshController.refreshCompleted();
  }

  Future<void> onLoading() async {
    // TODO: Implement pagination if needed
    refreshController.loadComplete();
  }

  void redeemPoints() {
    if (totalPoints.value < 500) {
      Get.snackbar(
        'Insufficient Points',
        'You need at least 500 points to redeem',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFE41313),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
      return;
    }

    Get.dialog(
      RedeemPointsDialog(

        availablePoints: totalPoints.value,
        minimumPoints: 500,
      ),
    );
  }

  void openScanner() {
    Get.toNamed(AppRoutes.qrScanner);
  }
}
