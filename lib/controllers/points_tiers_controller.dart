import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/reward_tier_model.dart';

class TierModel {
  final String name;
  final String pointsRange;
  final List<String> benefits;
  final bool isActive;

  TierModel({
    required this.name,
    required this.pointsRange,
    required this.benefits,
    this.isActive = false,
  });
}

class PointsTiersController extends GetxController {
  final RxList<RewardTierModel> rewardTiers = <RewardTierModel>[].obs;
  final RxList<TierModel> tiers = <TierModel>[].obs;
  final RxInt currentIndex = 0.obs;
  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(viewportFraction: 0.95, initialPage: 0);
    loadRewardTiers();
    loadTiers();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void updateIndex(int index) {
    currentIndex.value = index;
  }

  void loadTiers() {
    tiers.value = [
      TierModel(
        name: 'Elite',
        pointsRange: '12,500 - 14,999 points',
        isActive: true, // Currently active
        benefits: [
          '5% off any skincare product',
          'Free monthly modal skin fit & Flourish Membership',
          'First IV Therapy treatment 5% off',
          '\$100 off your first Hydrafacial',
          'Free goodie bag (\$150 value)',
          'All IV Therapy upgrades 10% off',
          '5% off all skincare treatments',
          'Two free skincare products up to \$150 total',
          'Free small area later hair removal package (\$250 value) - 625 points',
          'Free Hydrafacial (\$250 value) 4125 points',
          'Free 1 area IV Therapy treatment (\$50 value) - 825 points',
        ],
      ),
      TierModel(
        name: 'Diamond',
        pointsRange: '12,500 - 14,999 points',
        benefits: [
          '5% off any skincare product',
          'Free monthly modal skin fit & Flourish Membership',
          'First IV Therapy treatment 5% off',
          '\$100 off your first Hydrafacial',
          'Free goodie bag (\$150 value)',
          'All IV Therapy upgrades 10% off',
          'Two free skincare products up to \$150 total',
          '5% off all skincare treatments',
          'Free small area later hair removal package of (\$250 value)',
          'Free Hydrafacial (\$250 value) - 4125 points',
          'Free 1 area IV Therapy treatment (\$50 value) - 825 points',
        ],
      ),
      TierModel(
        name: 'Refresh',
        pointsRange: '0 - 2,499 points',
        benefits: [
          'First skincare product 10% off',
          'Free monthly modal skin fit & Flourish Membership',
          'First IV Therapy treatment 5% off',
        ],
      ),
      TierModel(
        name: 'Radiance',
        pointsRange: '5,000 - 9,999 points',
        benefits: [
          '10% off any skincare product',
          'Free monthly modal skin fit & Flourish Membership',
          'First IV Therapy treatment 5% off',
          '\$100 off your first Hydrafacial',
          'Free goodie bag (\$150 value)',
          'All IV Therapy upgrades 10% off',
          'Two free skincare products up to \$150 total - 1500 points',
        ],
      ),
      TierModel(
        name: 'Glow',
        pointsRange: '2,500 - 4,999 points',
        benefits: [
          'First skincare product 10% off',
          'Free monthly modal skin fit & Flourish Membership',
          'First IV Therapy treatment 5% off',
          '5% off any skincare product',
          '\$100 off your first Hydrafacial',
          'Free goodie bag (\$150 value) - 250 points',
        ],
      ),
      TierModel(
        name: 'Luminary',
        pointsRange: '10,000 - 12,499 points',
        benefits: [
          '10% off any skincare product',
          'Free monthly modal skin fit & Flourish Membership',
          'First IV Therapy treatment 5% off',
          '\$100 off your first Hydrafacial',
          'Free goodie bag (\$150 value)',
          'All IV Therapy upgrades 10% off',
          'Two free skincare products up to \$150 total',
          '5% off all skincare treatments',
          'Free small area laser hair removal package of (\$250 value) - 1000 points',
        ],
      ),
      TierModel(
        name: 'Icon',
        pointsRange: '15,000 - 19,999 points',
        benefits: [
          '5% off any skincare product',
          'Free monthly modal skin fit & Flourish Membership',
          'First IV Therapy treatment 5% off',
          '\$100 off your first Hydrafacial',
          'Free goodie bag (\$150 value)',
          'All IV Therapy upgrades 10% off',
          'Two free skincare products up to \$150 total',
          '5% off all skincare treatments',
          'Free small area laser hair removal package of (\$250 value)',
          'Free Hydrafacial (\$250 value)',
          'Free 1 area IV Therapy treatment (\$50 value)',
          'Large area laser hair removal package of (\$500 value) - 1200 points',
        ],
      ),
      TierModel(
        name: 'Platinum',
        pointsRange: '20,000 - 24,999 points',
        benefits: [
          '5% off any skincare product',
          'Free monthly modal skin fit & Flourish Membership',
          'First IV Therapy treatment 5% off',
          '\$100 off your first Hydrafacial',
          'Free goodie bag (\$150 value)',
          'All IV Therapy upgrades 10% off',
          'Two free skincare products up to \$150 total',
          '5% off all skincare treatments',
          'Free small area laser hair removal package of (\$250 value)',
          'Free Hydrafacial (\$250 value)',
          'Free 1 area IV Therapy treatment (\$50 value)',
          'Large area laser hair removal package of (\$500 value)',
          '3D Visia of Body, Abdomen, Mounjaro or Ozempic (\$150 value) - 2000 points',
        ],
      ),
      TierModel(
        name: 'Refresh X',
        pointsRange: '30,000+ points',
        benefits: [
          'Welcome to the inner circle. Your status is private and exclusive for you eyes only. Access may be revoked at any time if privileges are misused or shared. Your personal care coordinator will contact you within 24 hours upon successful induction of this tier.',
        ],
      ),
    ];
  }

  void loadRewardTiers() {
    rewardTiers.value = [
      RewardTierModel(
        points: '2500 points',
        referrals: '(5 referrals)',
        title: 'Free Goodie Bag',
        value: '(\$9000+ value)',
      ),
      RewardTierModel(
        points: '5,000 points',
        referrals: '(10 referrals)',
        title: 'Luxury Spa',
        value: '(\$9500+ value)',
      ),
      RewardTierModel(
        points: '10,000 points',
        referrals: '(20 referrals)',
        title: 'Medium area laser hair removal package',
        value: '(\$9900+ value)',
      ),
      RewardTierModel(
        points: '12,500 points',
        referrals: '(25 referrals)',
        title: 'Deluxe Hydrafacial & Refresh Luxury IV',
        value: '(\$9800+ value)',
      ),
      RewardTierModel(
        points: '18,000 points',
        referrals: '(36 referrals)',
        title: 'Large area laser hair removal package',
        value: '(\$9900+ value)',
      ),
      RewardTierModel(
        points: '20,000 points',
        referrals: '(40 referrals)',
        title: '3D Visia of Body, Abdomen, Mounjaro, or Ozempic',
        value: '(\$9900+ value)',
      ),
      RewardTierModel(
        points: '28,000 points',
        referrals: '(50 referrals)',
        title: 'One free syringe of dermal filler',
        value: '(\$9500+ value)',
      ),
      RewardTierModel(
        points: '37,500 points',
        referrals: '(75 referrals)',
        title: 'Linoleum area laser hair removal package',
        value: '(\$9,900+ value)',
      ),
    ];
  }
}