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
  final RxDouble maxHeight = 300.0.obs;
  final RxBool showAllTiers = false.obs;
  final RxInt otherTiersIndex = 0.obs;
  final RxDouble currentOtherTierHeight = 400.0.obs;
  final List<double> otherTierHeights = [];
  late PageController pageController;
  late PageController otherTiersPageController;

  /// Get user's active tier
  TierModel? get activeTier => tiers.firstWhereOrNull((t) => t.isActive);

  /// Get other tiers (excluding active)
  List<TierModel> get otherTiers => tiers.where((t) => !t.isActive).toList();

  /// Toggle show all tiers
  void toggleShowAllTiers() {
    showAllTiers.value = !showAllTiers.value;
    if (!showAllTiers.value) {
      otherTiersIndex.value = 0;
    }
  }

  /// Update other tiers index and height
  void updateOtherTiersIndex(int index) {
    otherTiersIndex.value = index;
    if (otherTierHeights.isNotEmpty && index < otherTierHeights.length) {
      currentOtherTierHeight.value = otherTierHeights[index];
    }
  }

  /// Calculate height for a specific tier
  double _calculateTierHeight(TierModel tier) {
    // Base height: icon(55) + spacing(16) + title(26) + spacing(4) + points(20) + spacing(16) + padding(40) = ~177
    // Each benefit: ~35 height (text + padding)
    return 180 + (tier.benefits.length * 35);
  }

  /// Calculate heights for other tiers
  void _calculateOtherTierHeights() {
    otherTierHeights.clear();
    for (var tier in otherTiers) {
      otherTierHeights.add(_calculateTierHeight(tier));
    }
    if (otherTierHeights.isNotEmpty) {
      currentOtherTierHeight.value = otherTierHeights[0];
    }
  }

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(viewportFraction: 0.95, initialPage: 0);
    otherTiersPageController = PageController(viewportFraction: 0.9, initialPage: 0);
    loadRewardTiers();
    loadTiers();
    calculateMaxHeight();
    _calculateOtherTierHeights();
  }

  void calculateMaxHeight() {
    double maxBenefits = 0;
    for (var tier in tiers) {
      if (tier.benefits.length > maxBenefits) {
        maxBenefits = tier.benefits.length.toDouble();
      }
    }
    // Base height for card padding, icons, titles (approx 200) + height per benefit (approx 35)
    maxHeight.value = 240 + (maxBenefits * 40);
  }

  @override
  void onClose() {
    pageController.dispose();
    otherTiersPageController.dispose();
    super.onClose();
  }

  void updateIndex(int index) {
    currentIndex.value = index;
  }

  void loadTiers() {
    tiers.value = [
      // Tiers in order: Refresh, Glow, Radiance, Luminary, Elite, Icon, Platinum, Diamond, Refresh X
      TierModel(
        name: 'Refresh',
        pointsRange: '0–2,499 points',
        benefits: [
          'First skincare product 10% off',
          'Free monthly trial of the Fill & Flourish Membership',
          'First IV Therapy treatment 5% off',
        ],
      ),
      TierModel(
        name: 'Glow',
        pointsRange: '2,500–4,999 points',
        benefits: [
          'First skincare product 10% off',
          'Free monthly trial of the Fill & Flourish Membership',
          'First IV Therapy treatment 5% off',
          '5% off any skincare product',
          '\$100 off your first Hydrafacial',
          'Free goodie bag (\$100 value) - 250 points',
        ],
      ),
      TierModel(
        name: 'Radiance',
        pointsRange: '5,000–9,999 points',
        benefits: [
          '5% off any skincare product',
          'Free monthly trial of the Fill & Flourish Membership',
          'First IV Therapy treatment 5% off',
          '\$100 off your first Hydrafacial',
          'Free goodie bag (\$100 value)',
          'All IV Therapy upgrades 10% off',
          'Two free skincare products up to \$150 total - 500 points',
        ],
      ),
      TierModel(
        name: 'Luminary',
        pointsRange: '10,000–12,499 points',
        benefits: [
          '5% off any skincare product',
          'Free monthly trial of the Fill & Flourish Membership',
          'First IV Therapy treatment 5% off',
          '\$100 off your first Hydrafacial',
          'Free goodie bag (\$100 value)',
          'All IV Therapy upgrades 10% off',
          'Two free skincare products up to \$150 total',
          '5% off all skincare treatments',
          'Free small-area laser hair removal package of 6 (\$199 value) - 1000 points',
        ],
      ),
      TierModel(
        name: 'Elite',
        pointsRange: '12,500–14,999 points',
        isActive: true, // Currently active
        benefits: [
          '5% off any skincare product',
          'Free monthly trial of the Fill & Flourish Membership',
          'First IV Therapy treatment 5% off',
          '\$100 off your first Hydrafacial',
          'Free goodie bag (\$100 value)',
          'All IV Therapy upgrades 10% off',
          'Two free skincare products up to \$150 total',
          '5% off all skincare treatments',
          'Free small-area laser hair removal package of 6 (\$199 value)',
          'Free Hydrafacial (\$289 value) - 625 points',
          'Free R.Power IV Therapy treatment (\$99 value) - 625 points',
        ],
      ),
      TierModel(
        name: 'Icon',
        pointsRange: '15,000–19,999 points',
        benefits: [
          '5% off any skincare product',
          'Free monthly trial of the Fill & Flourish Membership',
          'First IV Therapy treatment 5% off',
          '\$100 off your first Hydrafacial',
          'Free goodie bag (\$100 value)',
          'All IV Therapy upgrades 10% off',
          'Two free skincare products up to \$150 total',
          '5% off all skincare treatments',
          'Free small-area laser hair removal package of 6 (\$199 value)',
          'Free Hydrafacial (\$289 value)',
          'Free R.Power IV Therapy treatment (\$99 value)',
          'Large-area laser hair removal package of 6 (\$499 value) - 1500 points',
        ],
      ),
      TierModel(
        name: 'Platinum',
        pointsRange: '20,000–24,999 points',
        benefits: [
          '5% off any skincare product',
          'Free monthly trial of the Fill & Flourish Membership',
          'First IV Therapy treatment 5% off',
          '\$100 off your first Hydrafacial',
          'Free goodie bag (\$100 value)',
          'All IV Therapy upgrades 10% off',
          'Two free skincare products up to \$150 total',
          '5% off all skincare treatments',
          'Free small-area laser hair removal package of 6 (\$199 value)',
          'Free Hydrafacial (\$289 value)',
          'Free R.Power IV Therapy treatment (\$99 value)',
          'Large-area laser hair removal package of 6 (\$499 value)',
          '50 units of Botox or equivalent neuromodulator (\$700 value) - 2000 points',
        ],
      ),
      TierModel(
        name: 'Diamond',
        pointsRange: '25,000–39,999 points',
        benefits: [
          '5% off any skincare product',
          'Free monthly trial of the Fill & Flourish Membership',
          'First IV Therapy treatment 5% off',
          '\$100 off your first Hydrafacial',
          'Free goodie bag (\$100 value)',
          'All IV Therapy upgrades 10% off',
          'Two free skincare products up to \$150 total',
          '5% off all skincare treatments',
          'Free small-area laser hair removal package of 6 (\$199 value)',
          'Free Hydrafacial (\$289 value)',
          'Free R.Power IV Therapy treatment (\$99 value)',
          'Large-area laser hair removal package of 6 (\$499 value)',
          '50 units of Botox or equivalent neuromodulator (\$700 value)',
          'One free syringe of dermal filler (\$799+ value) - 2500 points',
        ],
      ),
      TierModel(
        name: 'Refresh X',
        pointsRange: '39,999+ points',
        benefits: [
          'Welcome to the inner circle. Your status is private and exclusive for your eyes only. Access may be revoked at any time if privileges are misused or shared. Your personal care coordinator will contact you within 24 hours upon successful induction of this tier.',
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
