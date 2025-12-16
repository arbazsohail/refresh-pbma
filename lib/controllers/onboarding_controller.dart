import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../services/storage_service.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  final List<OnboardingData> onboardingPages = [
    OnboardingData(
      image: 'assets/images/onboarding1_new.jpg',
      title: 'Earn Rewards For Referring',
      description:
          'Invite your friends, clients, or network \n and get rewarded for every \n successful referral.',
    ),
    OnboardingData(
      image: 'assets/images/onboarding2.jpg',
      title: 'Track Referrals Easily',
      description: 'See when your friends book and\n complete appointments.',
    ),
    OnboardingData(
      image: 'assets/images/onboarding3_new.jpg',
      title: 'Redeem Points For Perks',
      description:
          'Use your points towards treatments and earn exclusive gifts!',
    ),
    OnboardingData(
      image: 'assets/images/onboarding4.jpg',
      title: 'Everything In One Place',
      description:
          'Apply for payment plans, book appointments, explore services, and manage your Refresh experience all from one simple app.',
    ),
    OnboardingData(
      image: 'assets/images/onboarding5.jpg',
      title: 'Refresh Wellness Programs',
      description:
          'Discover our personalized wellness programs designed to support your health, longevity, and confidence, with streamlined medication management and easy reordering built in for your convenience.',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      currentPage.value = pageController.page?.round() ?? 0;
    });
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < onboardingPages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      completeOnboarding();
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipOnboarding() {
    completeOnboarding();
  }

  Future<void> completeOnboarding() async {
    // Mark onboarding as completed in storage
    final storage = Get.find<StorageService>();
    await storage.saveBool('onboarding_completed', true);

    // Navigate to join screen
    Get.offAllNamed(AppRoutes.join);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class OnboardingData {
  final String image;
  final String title;
  final String description;

  OnboardingData({
    required this.image,
    required this.title,
    required this.description,
  });
}
