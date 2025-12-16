import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_textfield.dart';
import '../../controllers/payment_questionnaire_controller.dart';

class PaymentQuestionnaireScreen
    extends GetView<PaymentQuestionnaireController> {
  const PaymentQuestionnaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConstants.darkSystemOverlay(
      child: Obx(
        () => Scaffold(
          backgroundColor: AppColors.white,
          appBar: CustomAppBar(
            title:
                controller.showConsentScreen.value
                    ? 'Payment Terms Application'
                    : 'Question ${controller.currentQuestionIndex.value + 1}',
            showBackButton: true,

            onBackTap: () {
              if (controller.showConsentScreen.value) {
                controller.showConsentScreen.value = false;
              } else if (controller.currentQuestionIndex.value > 0) {
                controller.previousQuestion();
              } else {
                Get.back();
              }
            },
          ),
          body: Obx(
            () =>
                controller.showConsentScreen.value
                    ? _buildConsentScreen()
                    : Column(
                      children: [
                        const SizedBox(height: 20),

                        // Progress counter and bar
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            children: [
                              // Counter
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '${controller.currentQuestionIndex.value + 1}',
                                    style: const TextStyle(
                                      color: Color(0xFF141413),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'DMSans',
                                    ),
                                  ),
                                  Text(
                                    '/${controller.questions.length}',
                                    style: const TextStyle(
                                      color: Color(0xFFA6A6A6),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'DMSans',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Progress bar
                              _buildProgressBar(),
                            ],
                          ),
                        ),

                        // Question content with animated transition
                        Expanded(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            switchInCurve: Curves.easeOutCubic,
                            switchOutCurve: Curves.easeInCubic,
                            transitionBuilder: (child, animation) {
                              final offsetAnimation = Tween<Offset>(
                                begin: const Offset(0.15, 0),
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeOutCubic,
                                ),
                              );

                              final fadeAnimation = Tween<double>(
                                begin: 0.0,
                                end: 1.0,
                              ).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: const Interval(
                                    0.0,
                                    0.8,
                                    curve: Curves.easeOut,
                                  ),
                                ),
                              );

                              return FadeTransition(
                                opacity: fadeAnimation,
                                child: SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                ),
                              );
                            },
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: SingleChildScrollView(
                                key: ValueKey(
                                  controller.currentQuestionIndex.value,
                                ),
                                padding: const EdgeInsets.fromLTRB(
                                  24,
                                  24,
                                  24,
                                  24,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Question text
                                    Text(
                                      controller.currentQuestion?.question ??
                                          '',
                                      style: const TextStyle(
                                        color: Color(0xFF141413),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'DMSans',
                                        height: 1.3,
                                      ),
                                    ),

                                    const SizedBox(height: 24),

                                    // Text Input Field (for Question 4)
                                    if (controller
                                            .currentQuestion
                                            ?.hasTextInput ==
                                        true)
                                      _buildTextInputField(),

                                    // Text Area (for Question 12)
                                    if (controller
                                            .currentQuestion
                                            ?.isTextArea ==
                                        true)
                                      _buildTextArea(),

                                    // Options
                                    if (controller
                                            .currentQuestion
                                            ?.options
                                            .isNotEmpty ==
                                        true)
                                      ...controller.currentQuestion!.options.map(
                                        (option) {
                                          final isSelected =
                                              controller
                                                  .currentQuestion
                                                  ?.selectedAnswer ==
                                              option;

                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 12,
                                            ),
                                            child: InkWell(
                                              onTap:
                                                  () => controller.selectAnswer(
                                                    option,
                                                  ),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Container(
                                                width: double.infinity,
                                                height: 53,
                                                padding: const EdgeInsets.all(
                                                  10,
                                                ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      isSelected
                                                          ? AppColors.primary
                                                          : const Color(
                                                            0xFFF6F6F6,
                                                          ),
                                                  borderRadius:
                                                      BorderRadius.circular(58),
                                                  border:
                                                      isSelected
                                                          ? Border.all(
                                                            color:
                                                                AppColors
                                                                    .primary,
                                                            width: 1,
                                                          )
                                                          : null,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      option,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color:
                                                            isSelected
                                                                ? Colors.white
                                                                : const Color(
                                                                  0xFF141413,
                                                                ),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: 'DMSans',
                                                      ),
                                                    ),
                                                    if (isSelected) ...[
                                                      const SizedBox(width: 8),
                                                      Container(
                                                        width: 20,
                                                        height: 20,
                                                        decoration:
                                                            const BoxDecoration(
                                                              color:
                                                                  Colors.green,
                                                              shape:
                                                                  BoxShape
                                                                      .circle,
                                                            ),
                                                        child: const Icon(
                                                          Icons.check,
                                                          color: Colors.white,
                                                          size: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),

                                    const SizedBox(height: 24),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Navigation buttons at bottom
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x0A000000),
                                blurRadius: 10,
                                offset: Offset(0, -2),
                              ),
                            ],
                          ),
                          child: SafeArea(
                            top: false,
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed:
                                    controller.isLoading.value
                                        ? null
                                        : controller.nextQuestion,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  disabledBackgroundColor: AppColors.primary
                                      .withValues(alpha: 0.6),
                                ),
                                child:
                                    controller.isLoading.value
                                        ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  Colors.white,
                                                ),
                                          ),
                                        )
                                        : const Text(
                                          'Next',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'DMSans',
                                          ),
                                        ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Obx(
      () => Container(
        height: 8,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFE8E8E8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: controller.progress,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextInputField() {
    return CustomTextfield(
      text: 'Enter Your Amount',
      textInputType: TextInputType.number,
      filledColor: AppColors.lightGray,
      borderRadius: 50,
      onChange: controller.updateTextInput,
      textInputAction: TextInputAction.done,
    );
  }

  Widget _buildTextArea() {
    return Obx(() {
      final textLength = controller.currentQuestion?.textInput?.length ?? 0;
      final maxLength = controller.currentQuestion?.maxLength ?? 300;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextfield(
            text: 'Write...',
            maxLines: 8,
            filledColor: AppColors.lightGray,
            borderRadius: 20,
            onChange: controller.updateTextInput,
            textInputAction: TextInputAction.newline,
            contentPadding: 20,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                '$textLength/$maxLength',
                style: const TextStyle(
                  color: Color(0xFFA6A6A6),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'DMSans',
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildConsentScreen() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Consent & Submission',
                  style: TextStyle(
                    color: Color(0xFF141413),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'DMSans',
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'By submitting this form, you agree to allow Refresh Palm Beach Medical Aesthetics and/ or its affiliates (Refresh Port St Lucie Medical Aesthetics & Refresh Vero Beach Medical Aesthetics)  to review your application, contact you regarding payment options, and conduct a soft credit inquiry if applicable.',
                  style: TextStyle(
                    color: Color(0xFF585D61),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'DMSans',
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                _buildCheckbox(
                  value: controller.agreeConsent.value,
                  onChanged: controller.toggleAgreeConsent,
                  label: 'I agree and authorize',
                ),
                const SizedBox(height: 16),
                _buildCheckbox(
                  value: controller.certifyInfo.value,
                  onChanged: controller.toggleCertifyInfo,
                  label:
                      'I certify that all information provided is accurate to the best of my knowledge.',
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Obx(
              () => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      controller.isLoading.value
                          ? null
                          : (controller.canSubmit
                              ? controller.submitQuestionnaire
                              : null),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    disabledBackgroundColor: AppColors.primary.withValues(
                      alpha: 0.6,
                    ),
                  ),
                  child:
                      controller.isLoading.value
                          ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                          : const Text(
                            'Submit Application',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'DMSans',
                            ),
                          ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckbox({
    required bool value,
    required VoidCallback onChanged,
    required String label,
  }) {
    return InkWell(
      onTap: onChanged,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: value ? AppColors.secondary : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: value ? AppColors.secondary : const Color(0xFFE8E8E8),
                width: 2,
              ),
            ),
            child:
                value
                    ? const Icon(Icons.check, color: Colors.white, size: 16)
                    : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF141413),
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'DMSans',
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
