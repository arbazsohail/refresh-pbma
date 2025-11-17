import 'package:get/get.dart';
import '../models/earn_step_model.dart';

class HowToEarnController extends GetxController {
  final RxList<EarnOptionModel> earnOptions = <EarnOptionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadEarnOptions();
  }

  void loadEarnOptions() {
    earnOptions.value = [
      EarnOptionModel(
        optionTitle: 'Option 1: Refer a Friend',
        steps: [
          EarnStepModel(
            stepNumber: 'Step 1',
            title: 'Share Your Referral Link',
            description:
                'Send your unique referral link to friends, family, or anyone interested in our services.',
          ),
          EarnStepModel(
            stepNumber: 'Step 2',
            title: 'Friend Submits the Form',
            description:
                'Your referred friend completes and submits a referral form on your site to be eligible.',
          ),
          EarnStepModel(
            stepNumber: 'Step 3',
            title: 'Admin Follow-Up',
            description:
                'Our patient success coordinators will follow up with your referral and help book a service or appointment.',
          ),
          EarnStepModel(
            stepNumber: 'Step 4',
            title: 'Earn Your Rewards',
            description:
                'You\'ll gain reward points once your referred friend completes a booking or purchases.',
          ),
        ],
      ),
      EarnOptionModel(
        optionTitle: 'Option 2: Check In at Each Visit',
        steps: [
          EarnStepModel(
            stepNumber: 'Step 1',
            title: 'Scan the QR Code in Office',
            description:
                'Use your device\'s camera to scan the available at the front desk.',
          ),
          EarnStepModel(
            stepNumber: 'Step 2',
            title: 'Earn 10 Points Per Visit',
            description:
                'Each successful QR code scan earns 10 points for your account. Keep scanning each visit for coming back!',
          ),
        ],
      ),
    ];
  }
}
