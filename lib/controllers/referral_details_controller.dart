import 'package:get/get.dart';
import '../models/referral_model.dart';

class ReferralDetailsController extends GetxController {
  late ReferralModel referral;
  final RxInt currentStep = 1.obs;
  final RxList<String> stepLabels = <String>[].obs;

  @override
  void onInit() {
    super.onInit();

    // Get referral data passed from previous screen
    referral = Get.arguments as ReferralModel;

    // Define step labels
    stepLabels.value = [
      'Form\nSent',
      'Form\nFilled',
      'Booking\nConfirmed',
      'Rewards\nEarned',
    ];

    // Determine current step based on status
    if (referral.isRewarded) {
      currentStep.value = 4; // All steps completed
    } else {
      currentStep.value = 2; // Form filled, waiting for booking
    }
  }
}
