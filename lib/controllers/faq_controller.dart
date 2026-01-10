import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/faq_model.dart';
import '../services/settings_service.dart';
import '../widgets/custom_snackbar.dart';

class FaqController extends GetxController {
  // Services
  final SettingsService _settingsService = Get.find<SettingsService>();

  // Search controller
  final searchController = TextEditingController();

  // FAQ list
  final RxList<FAQModel> faqs = <FAQModel>[].obs;
  final RxList<FAQModel> filteredFaqs = <FAQModel>[].obs;

  // Loading state
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadFaqs();
    // Listen to search changes
    searchController.addListener(() {
      searchFaqs(searchController.text);
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  // Load FAQs
  Future<void> loadFaqs() async {
    isLoading.value = true;

    try {
      // Fetch FAQs from API
      final response = await _settingsService.getFaqs();

      // Parse FAQ data
      final List<dynamic> faqData = response['data'] ?? [];
      faqs.value = faqData.map((json) => FAQModel.fromJson(json)).toList();
      filteredFaqs.value = faqs;

      isLoading.value = false;
    } on String catch (errorMessage) {
      isLoading.value = false;

      // Show error message
      CustomSnackbar.error(
        title: 'Error',
        message: errorMessage,
      );

      // Set empty list on error
      faqs.value = [];
      filteredFaqs.value = [];
    } catch (e) {
      isLoading.value = false;

      // Show error message
      CustomSnackbar.error(
        title: 'Error',
        message: 'Failed to load FAQs. Please try again.',
      );

      // Set empty list on error
      faqs.value = [];
      filteredFaqs.value = [];
    }
  }


  // Search FAQs
  void searchFaqs(String query) {
    if (query.isEmpty) {
      filteredFaqs.value = faqs;
    } else {
      filteredFaqs.value = faqs.where((faq) {
        return faq.question.toLowerCase().contains(query.toLowerCase()) ||
            faq.answer.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  // Toggle FAQ expansion
  void toggleFaq(int index) {
    filteredFaqs[index].isExpanded = !filteredFaqs[index].isExpanded;
    filteredFaqs.refresh();
  }
}
