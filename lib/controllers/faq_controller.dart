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

    // All FAQs from Refresh PBMA
    faqs.value = [
      FAQModel(
        id: '1',
        question: 'Do you offer financing options?',
        answer: 'Yes, we offer flexible financing options through our partners including CareCredit and Cherry. Contact us or speak with our staff during your visit for more details on available payment plans.',
      ),
      FAQModel(
        id: '2',
        question: 'What\'s the best way to keep my skin looking its best long term?',
        answer: 'Consistent skincare routine, daily sun protection with SPF 30+, proper hydration, regular professional treatments like facials and peels, and maintaining a healthy lifestyle with balanced nutrition and adequate sleep.',
      ),
      FAQModel(
        id: '3',
        question: 'Can I book my appointment online?',
        answer: 'Yes, you can easily book appointments through our app or website 24/7. Simply select your desired service, choose an available time slot, and confirm your booking.',
      ),
      FAQModel(
        id: '4',
        question: 'Can Refresh help with PCOS related concerns?',
        answer: 'Yes, we offer specialized treatments for PCOS-related skin and hair concerns including hormonal acne treatment, laser hair removal for excess hair growth, and customized skincare plans.',
      ),
      FAQModel(
        id: '5',
        question: 'Is laser hair removal safe for all skin types?',
        answer: 'Our advanced laser technology is safe for most skin types including darker skin tones. We use state-of-the-art equipment that can be customized to your specific skin type. We recommend a consultation to determine the best approach for you.',
      ),
      FAQModel(
        id: '6',
        question: 'How does your weight loss program work?',
        answer: 'Our medical weight loss program includes FDA-approved medications like Semaglutide and Tirzepatide, combined with personalized nutrition guidance and ongoing support. We create customized plans based on your health goals and medical history.',
      ),
      FAQModel(
        id: '7',
        question: 'What is the difference between Botox and fillers?',
        answer: 'Botox relaxes muscles to reduce dynamic wrinkles (like frown lines and crow\'s feet), while dermal fillers add volume to areas that have lost fullness (like cheeks and lips). Both are complementary treatments that can be used together.',
      ),
      FAQModel(
        id: '8',
        question: 'How long do Botox results last?',
        answer: 'Botox results typically last 3-4 months for most patients. With regular treatments, some patients find their results last longer over time as the muscles become trained to relax.',
      ),
      FAQModel(
        id: '9',
        question: 'Are your treatments painful?',
        answer: 'Most of our treatments involve minimal discomfort. We use topical numbing creams, ice, and other comfort measures to ensure your experience is as pleasant as possible. Our team is trained to prioritize your comfort.',
      ),
      FAQModel(
        id: '10',
        question: 'What is a HydraFacial?',
        answer: 'HydraFacial is a multi-step facial treatment that cleanses, exfoliates, extracts impurities, and hydrates your skin using patented technology. It\'s suitable for all skin types and provides immediate visible results.',
      ),
      FAQModel(
        id: '11',
        question: 'How often should I get a HydraFacial?',
        answer: 'For optimal results, we recommend getting a HydraFacial every 4-6 weeks. This allows enough time between treatments for your skin to fully benefit while maintaining consistent results.',
      ),
      FAQModel(
        id: '12',
        question: 'What is IV therapy and what are its benefits?',
        answer: 'IV therapy delivers vitamins, minerals, and hydration directly into your bloodstream for maximum absorption. Benefits include increased energy, improved immunity, better hydration, and faster recovery from illness or fatigue.',
      ),
      FAQModel(
        id: '13',
        question: 'Do you offer chemical peels?',
        answer: 'Yes, we offer a range of chemical peels from light to deep, customized to address your specific concerns including acne, hyperpigmentation, fine lines, and uneven texture.',
      ),
      FAQModel(
        id: '14',
        question: 'What should I do before my appointment?',
        answer: 'Arrive with clean skin free of makeup. Avoid sun exposure and certain skincare products like retinol before treatments. Specific pre-treatment instructions will be provided when you book your appointment.',
      ),
      FAQModel(
        id: '15',
        question: 'What is microneedling?',
        answer: 'Microneedling is a collagen-stimulating treatment that creates tiny punctures in the skin to trigger natural healing. It improves skin texture, reduces scars, minimizes pores, and enhances overall skin quality.',
      ),
      FAQModel(
        id: '16',
        question: 'Can I combine treatments?',
        answer: 'Yes, many treatments can be combined for enhanced results. Our providers will create a customized treatment plan based on your goals and recommend the best combination of services.',
      ),
      FAQModel(
        id: '17',
        question: 'What are the side effects of Botox?',
        answer: 'Common side effects include mild bruising, swelling, or redness at injection sites, which typically resolve within a few days. More serious side effects are rare when administered by trained professionals.',
      ),
      FAQModel(
        id: '18',
        question: 'How do I prepare for laser hair removal?',
        answer: 'Avoid sun exposure, tanning, and waxing for 2-4 weeks before treatment. Shave the treatment area 24 hours before your appointment. Avoid using certain skincare products as advised.',
      ),
      FAQModel(
        id: '19',
        question: 'How many laser hair removal sessions do I need?',
        answer: 'Most patients need 6-8 sessions for optimal results, spaced 4-6 weeks apart. The number of sessions depends on hair color, thickness, and the treatment area.',
      ),
      FAQModel(
        id: '20',
        question: 'What is Sculptra and how does it work?',
        answer: 'Sculptra is a collagen stimulator that gradually restores facial volume over time. Unlike traditional fillers, it works by stimulating your body\'s own collagen production for natural-looking, long-lasting results.',
      ),
      FAQModel(
        id: '21',
        question: 'Are consultations free?',
        answer: 'Yes, we offer complimentary consultations for most services. This allows you to discuss your goals, learn about treatment options, and receive a customized treatment plan.',
      ),
      FAQModel(
        id: '22',
        question: 'What is the cancellation policy?',
        answer: 'We require 24-48 hours notice for cancellations. Late cancellations or no-shows may be subject to a cancellation fee. Please contact us as soon as possible if you need to reschedule.',
      ),
      FAQModel(
        id: '23',
        question: 'Do you offer gift cards?',
        answer: 'Yes, we offer gift cards in any denomination. They make perfect gifts for special occasions and can be used for any of our services or products.',
      ),
      FAQModel(
        id: '24',
        question: 'What skincare products do you recommend?',
        answer: 'We carry medical-grade skincare lines including ZO Skin Health, SkinMedica, and others. Our providers can recommend products based on your specific skin concerns and treatment goals.',
      ),
      FAQModel(
        id: '25',
        question: 'How do I earn and redeem rewards points?',
        answer: 'Earn points with every purchase and referral. Points can be redeemed for discounts on services and products. Check your Wallet in the app to see your balance and available rewards.',
      ),
      FAQModel(
        id: '26',
        question: 'What is the downtime for most treatments?',
        answer: 'Downtime varies by treatment. Botox and fillers have minimal downtime, while laser treatments and peels may require 3-7 days of recovery. Your provider will discuss expected downtime during your consultation.',
      ),
      FAQModel(
        id: '27',
        question: 'Can I wear makeup after my treatment?',
        answer: 'This depends on the treatment. For injectables, we recommend waiting at least 4 hours. For facials and peels, you may need to wait 24-48 hours. Specific aftercare instructions will be provided.',
      ),
      FAQModel(
        id: '28',
        question: 'Do you treat men?',
        answer: 'Absolutely! We welcome patients of all genders. Many of our treatments including Botox, laser hair removal, and skincare services are popular among men.',
      ),
      FAQModel(
        id: '29',
        question: 'What age should I start preventative treatments?',
        answer: 'Many patients begin preventative Botox in their mid-20s to early 30s. However, the right time depends on your individual skin concerns and goals. A consultation can help determine what\'s right for you.',
      ),
      FAQModel(
        id: '30',
        question: 'Are your providers licensed and trained?',
        answer: 'Yes, all our providers are licensed medical professionals with specialized training in aesthetic treatments. We maintain the highest standards of safety and expertise.',
      ),
      FAQModel(
        id: '31',
        question: 'What is PRP and how is it used?',
        answer: 'PRP (Platelet-Rich Plasma) is derived from your own blood and contains growth factors that promote healing and collagen production. It\'s used with microneedling, for hair restoration, and in facial rejuvenation.',
      ),
      FAQModel(
        id: '32',
        question: 'How do I know which treatment is right for me?',
        answer: 'Schedule a consultation with one of our providers. They will assess your concerns, discuss your goals, and recommend a personalized treatment plan tailored to your needs.',
      ),
      FAQModel(
        id: '33',
        question: 'What makes Refresh different from other med spas?',
        answer: 'We combine medical expertise with a luxury spa experience. Our personalized approach, state-of-the-art technology, and commitment to patient satisfaction set us apart.',
      ),
      FAQModel(
        id: '34',
        question: 'Do treatments hurt?',
        answer: 'Most treatments involve minimal discomfort. We use various comfort measures including topical numbing, ice, and careful technique to ensure your experience is as comfortable as possible.',
      ),
      FAQModel(
        id: '35',
        question: 'Can I exercise after treatment?',
        answer: 'We typically recommend avoiding strenuous exercise for 24-48 hours after most treatments to minimize swelling and optimize results. Specific guidelines vary by treatment.',
      ),
      FAQModel(
        id: '36',
        question: 'What is lip filler and how long does it last?',
        answer: 'Lip filler is hyaluronic acid-based dermal filler used to add volume and shape to lips. Results typically last 6-12 months depending on the product used and individual metabolism.',
      ),
      FAQModel(
        id: '37',
        question: 'Do you offer memberships?',
        answer: 'Yes, we offer the Fill & Flourish Membership which provides monthly benefits, discounts on treatments, and exclusive perks. Ask about our membership options during your visit.',
      ),
      FAQModel(
        id: '38',
        question: 'What should I avoid after Botox?',
        answer: 'Avoid lying down for 4 hours, rubbing the treated area, strenuous exercise, and excessive heat (saunas, hot tubs) for 24 hours. These precautions help ensure optimal results.',
      ),
      FAQModel(
        id: '39',
        question: 'How do I refer a friend?',
        answer: 'Share your unique referral code or link found in the app. When your friend completes their first service, you\'ll both earn rewards points. It\'s a win-win!',
      ),
      FAQModel(
        id: '40',
        question: 'What areas can be treated with laser hair removal?',
        answer: 'We can treat most areas of the body including face, underarms, arms, legs, bikini area, back, and chest. Schedule a consultation to discuss your specific needs.',
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
