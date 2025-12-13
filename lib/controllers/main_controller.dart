import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/main/pages/rewards_page.dart';
import '../screens/main/pages/referrals_page.dart';
import '../screens/main/pages/wallet_page.dart';
import '../screens/main/pages/homs_page.dart';

class MainController extends GetxController {
  final RxInt currentIndex = 0.obs;

  // List of pages for bottom navigation
  final List<Widget> pages = [
    const HomePage(),
    const ReferralsPage(),
    const WalletPage(),
    const RewardsPage(),
  ];

  // Change page
  void changePage(int index) {
    currentIndex.value = index;
  }
}
