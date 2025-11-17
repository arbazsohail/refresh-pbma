import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/faq_model.dart';

class FaqController extends GetxController {
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
  void loadFaqs() {
    isLoading.value = true;

    // Sample FAQ data
    faqs.value = [
      FAQModel(
        id: '1',
        question: 'How do I earn points?',
        answer: 'You can earn points by referring friends, completing purchases, and participating in special promotions. Each referral earns you 500 points!',
      ),
      FAQModel(
        id: '2',
        question: 'How do I redeem my points?',
        answer: 'Points can be redeemed for discounts on services or products. Go to the Wallet section to see available rewards and redeem your points.',
      ),
      FAQModel(
        id: '3',
        question: 'How long do points last?',
        answer: 'Points are valid for 12 months from the date they are earned. Make sure to use them before they expire!',
      ),
      FAQModel(
        id: '4',
        question: 'Can I transfer points to another account?',
        answer: 'No, points are non-transferable and can only be used by the account holder who earned them.',
      ),
      FAQModel(
        id: '5',
        question: 'How do I refer a friend?',
        answer: 'Go to the Referrals tab and share your unique referral link with friends. When they sign up and make their first purchase, you both earn points!',
      ),
      FAQModel(
        id: '6',
        question: 'What happens if I cancel a booking?',
        answer: 'Cancellation policies vary by service. Generally, if you cancel within 24 hours of booking, you will receive a full refund. After that, cancellation fees may apply.',
      ),
      FAQModel(
        id: '7',
        question: 'How do I update my profile information?',
        answer: 'Go to Settings > Profile Settings to update your name, email, phone number, and other personal information.',
      ),
      FAQModel(
        id: '8',
        question: 'Is my payment information secure?',
        answer: 'Yes, we use industry-standard encryption to protect your payment information. We never store your full credit card details on our servers.',
      ),
      FAQModel(
        id: '9',
        question: 'Can I use multiple payment methods?',
        answer: 'Yes, you can save multiple payment methods in your account and choose which one to use for each transaction.',
      ),
      FAQModel(
        id: '10',
        question: 'How do I contact customer support?',
        answer: 'You can contact us through the Contact Us option in Settings, or email us at support@refresh.com. We typically respond within 24 hours.',
      ),
    ];

    filteredFaqs.value = faqs;
    isLoading.value = false;
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
