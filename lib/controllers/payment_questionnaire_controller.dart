import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/payment_question_model.dart';
import '../widgets/custom_snackbar.dart';
import '../widgets/verification_success_dialog.dart';

class PaymentQuestionnaireController extends GetxController {
  // Current question index
  final RxInt currentQuestionIndex = 0.obs;

  // Loading state
  final RxBool isLoading = false.obs;

  // Questions list
  final RxList<PaymentQuestionModel> questions = <PaymentQuestionModel>[].obs;

  // Consent checkboxes
  final RxBool agreeConsent = false.obs;
  final RxBool certifyInfo = false.obs;

  // Show consent screen
  final RxBool showConsentScreen = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadQuestions();
  }

  void loadQuestions() {
    questions.value = [
      // Question 1
      PaymentQuestionModel(
        id: 1,
        question: 'Have you previously received services at Refresh?',
        options: ['Yes', 'No'],
      ),

      // Question 2
      PaymentQuestionModel(
        id: 2,
        question: 'Which location are you applying through?',
        options: ['Jupiter', 'Port St. Lucie', 'Vero Beach', 'Other'],
      ),

      // Question 3
      PaymentQuestionModel(
        id: 3,
        question: 'What type of services are you seeking financing for?',
        options: [
          'Injectables',
          'Laser or Skin Treatments',
          'Weight Loss / Wellness',
          'Plastic Surgery ',
          'Other',
        ],
      ),

      // Question 4
      PaymentQuestionModel(
        id: 4,
        question: 'Estimated total amount you\'d like financed',
        options: [],
        hasTextInput: true,
      ),

      // Question 5
      PaymentQuestionModel(
        id: 5,
        question: 'Desired monthly payment amount?',
        options: ['Under \$100', '\$100-\$200', '\$200-\$500', '\$500+'],
      ),

      // Question 6
      PaymentQuestionModel(
        id: 6,
        question: 'Preferred payment term duration?',
        options: ['1-3 Months', '3-6 Months', '6-12 Months', '12+ Months'],
      ),

      // Question 7
      PaymentQuestionModel(
        id: 7,
        question: 'Employment Status',
        options: [
          'Employed-Full Time',
          'Employed-Part Time',
          'Self-Employed',
          'Student',
          'Retired',
        ],
      ),

      // Question 8
      PaymentQuestionModel(
        id: 8,
        question: 'Approximate monthly income (before taxes)?',
        options: [
          'Under \$2000',
          '\$2000-\$4000',
          '\$4000-\$6000',
          'Over \$6000',
        ],
      ),

      // Question 9
      PaymentQuestionModel(
        id: 9,
        question: 'How long have you been at your current employer (in years)?',
        options: [
          'Less Than 6 Months',
          '6-12 Months',
          '1-3 Years',
          'Over 3 Years',
        ],
      ),

      // Question 10
      PaymentQuestionModel(
        id: 10,
        question: 'Have you finished with us at Refresh services?',
        options: ['Yes', 'No'],
      ),

      // Question 11
      PaymentQuestionModel(
        id: 11,
        question: 'How soon are you looking to start treatment?',
        options: [
          'Immediately',
          'Within 1-2 Weeks',
          '1-3 Months',
          'Over 3 Months',
        ],
      ),

      // Question 12
      PaymentQuestionModel(
        id: 12,
        question:
            'Is there anything you\'d like our financial concierge team to know about your payment needs or goals?',
        options: [],
        isTextArea: true,
        maxLength: 300,
      ),
    ];
  }

  // Get progress percentage
  double get progress {
    if (questions.isEmpty) return 0.0;
    return (currentQuestionIndex.value + 1) / questions.length;
  }

  // Get current question
  PaymentQuestionModel? get currentQuestion {
    if (currentQuestionIndex.value < questions.length) {
      return questions[currentQuestionIndex.value];
    }
    return null;
  }

  // Select answer for current question
  void selectAnswer(String answer) {
    if (currentQuestion != null) {
      final question = questions[currentQuestionIndex.value];
      if (question.allowMultiple) {
        question.selectedAnswers ??= [];
        if (question.selectedAnswers!.contains(answer)) {
          question.selectedAnswers!.remove(answer);
        } else {
          question.selectedAnswers!.add(answer);
        }
      } else {
        question.selectedAnswer = answer;
      }
      questions.refresh();
    }
  }

  // Update text input for current question
  void updateTextInput(String value) {
    if (currentQuestion != null) {
      final question = questions[currentQuestionIndex.value];
      question.textInput = value;
      questions.refresh();
    }
  }

  // Go to next question
  void nextQuestion() {
    if (currentQuestion != null && !currentQuestion!.isAnswered) {
      CustomSnackbar.warning(
        title: 'Answer Required',
        message: 'Please provide an answer before continuing',
      );
      return;
    }

    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
    } else {
      // Last question - show consent screen
      showConsentScreen.value = true;
    }
  }

  // Toggle consent checkboxes
  void toggleAgreeConsent() {
    agreeConsent.value = !agreeConsent.value;
  }

  void toggleCertifyInfo() {
    certifyInfo.value = !certifyInfo.value;
  }

  // Check if can submit
  bool get canSubmit => agreeConsent.value && certifyInfo.value;

  // Go to previous question
  void previousQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
    }
  }

  // Submit questionnaire
  void submitQuestionnaire() {
    isLoading.value = true;

    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;

      // Show success dialog using CustomSuccessDialog
      Get.dialog(
        CustomSuccessDialog(
          title: 'Application Submitted!',
          description:
              'Thank you for submitting your payment application. We\'ll review your information and get back to you soon.',
          buttonText: 'Done',
          showConfetti: true,
          iconAsset: 'assets/icons/tick.svg',
          iconBackgroundColor: Colors.green,
          onOkPressed: () {
            Get.back(); // Close dialog
            Get.until((route) => route.settings.name == '/main'); // Go back to main
          },
        ),
        barrierDismissible: false,
      );
    });
  }
}
