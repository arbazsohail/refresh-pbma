import 'package:get/get.dart';

class PaymentApplicationController extends GetxController {
  // Loading state
  final RxBool isLoading = false.obs;

  // Continue to questionnaire
  void continueToForm() {
    Get.toNamed('/payment-questionnaire');
  }
}
