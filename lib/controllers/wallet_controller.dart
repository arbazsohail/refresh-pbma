import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../models/points_history_model.dart';
import '../routes/app_routes.dart';
import '../widgets/dialogs/redeem_points_dialog.dart';
import '../services/wallet_service.dart';

class WalletController extends GetxController {
  final WalletService _walletService = Get.find<WalletService>();
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
        onRedeem: submitRedeemRequest,
      ),
    );
  }

  /// Submit redeem request to API
  /// Returns true on success, false on error
  Future<bool> submitRedeemRequest(int points) async {
    try {
      print('🔄 Submitting redeem request for $points points');

      final response = await _walletService.submitRedeemRequest(
        points: points,
      );

      print('✅ Redeem request submitted successfully: ${response['message']}');

      // Show success message
      Get.snackbar(
        'Request Submitted',
        response['message'] ?? 'Your redeem request has been submitted successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF27AE60),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
        duration: const Duration(seconds: 3),
      );

      // Refresh wallet data to get updated points
      await loadWalletData();

      return true; // Success
    } catch (e) {
      print('❌ Failed to submit redeem request: $e');

      // Parse error message
      String errorMessage = 'Failed to submit redeem request. Please try again.';

      if (e.toString().contains('Insufficient points')) {
        errorMessage = 'You don\'t have enough points in your wallet. Please earn more points to redeem.';
      } else if (e.toString().contains('Exception:')) {
        errorMessage = e.toString().replaceAll('Exception:', '').trim();
      }

      // Show error message
      Get.snackbar(
        'Unable to Redeem',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFE41313),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
        duration: const Duration(seconds: 3),
      );

      return false; // Error
    }
  }

  void openScanner() {
    Get.toNamed(AppRoutes.qrScanner);
  }
}
