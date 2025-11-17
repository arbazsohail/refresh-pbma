import 'package:get/get.dart';
import '../models/reward_tier_model.dart';

class PointsTiersController extends GetxController {
  final RxList<RewardTierModel> rewardTiers = <RewardTierModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadRewardTiers();
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
