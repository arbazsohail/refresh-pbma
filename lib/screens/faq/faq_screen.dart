import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/faq_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_textfield.dart';

class FaqScreen extends GetView<FaqController> {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConstants.lightSystemOverlay(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const CustomAppBar(
          title: 'FAQ',
          showBackButton: true,
          showNotification: false,
          showSettings: false,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(20),
              child: CustomTextfield(
                controller: controller.searchController,
                text: 'Search FAQs...',
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.search,
                filledColor: AppColors.lightGray,
                borderRadius: 50,
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 16, right: 12),
                  child: Icon(
                    Icons.search,
                    color: Color(0xFF4E555B),
                    size: 24,
                  ),
                ),
              ),
            ),

             const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Text(
                'FAQ\'s',
                style: TextStyle(
                  color: Color(0xFF141413),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DMSans',
                ),
              ),
            ),

            // FAQ list
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.secondary,
                    ),
                  );
                }

                if (controller.filteredFaqs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: AppColors.greyText.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'No FAQs found',
                          style: TextStyle(
                            color: AppColors.greyText,
                            fontSize: 16,
                            fontFamily: 'DMSans',
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: controller.filteredFaqs.length,
                  itemBuilder: (context, index) {
                    final faq = controller.filteredFaqs[index];
                    return _buildFaqItem(faq, index);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem(faq, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => controller.toggleFaq(index),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      faq.question,
                      style: const TextStyle(
                        color: AppColors.blackText,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'DMSans',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    faq.isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.secondary,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
          if (faq.isExpanded)
            Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                faq.answer,
                style: const TextStyle(
                  color: Color(0xFF7C8086),
                  fontSize: 14,
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
