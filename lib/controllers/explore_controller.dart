import 'package:get/get.dart';
import '../models/blog_model.dart';
import '../models/faq_model.dart';

class ExploreController extends GetxController {
  final RxList<Map<String, String>> popularServices =
      <Map<String, String>>[].obs;
  final RxList<BlogModel> blogs = <BlogModel>[].obs;
  final RxList<FAQModel> faqs = <FAQModel>[].obs;
  final RxInt expandedFaqIndex = (-1).obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    // Popular Services
    popularServices.value = [
      {'image': 'assets/images/join1.png', 'label': 'Smooth fine lines'},
      {'image': 'assets/images/join2.png', 'label': 'Restore Volume'},
      {'image': 'assets/images/join3.png', 'label': 'Remove Unwanted Hair'},
      {'image': 'assets/images/join4.png', 'label': 'Lose Weight'},
    ];

    // Blogs
    blogs.value = [
      BlogModel(
        image:
            'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?w=400&h=300&fit=crop',
        title: 'Preventative Botox: Why Younger Clients Are Starting Early',
      ),
      BlogModel(
        image:
            'https://images.unsplash.com/photo-1516975080664-ed2fc6a32937?w=400&h=300&fit=crop',
        title: 'The Ultimate Guide to Skincare Treatments',
      ),
    ];

    // FAQs
    faqs.value = [
      FAQModel(
        question: 'Do you offer financing options?',
        answer:
            'Yes, we offer flexible financing options through our partners. Contact us for more details.',
        id: '1',
      ),
      FAQModel(
        question:
            'What\'s the best way to keep my skin looking its best long term?',
        answer:
            'Consistent skincare routine, sun protection, hydration, and regular professional treatments are key.',
        id: '2',
      ),
      FAQModel(
        question: 'Can I book my appointments online?',
        answer:
            'Yes, you can easily book appointments through our app or website.',
        id: '3',
      ),
      FAQModel(
        question: 'Can Refresh help with PCOS related concerns?',
        answer:
            'Yes, we offer specialized treatments for PCOS-related skin and hair concerns.',
        id: '4',
      ),
      FAQModel(
        question: 'Is laser hair removal safe for all skin types?',
        answer:
            'Our advanced laser technology is safe for most skin types. We recommend a consultation first.',
        id: '5',
      ),
    ];
  }

  void toggleFaq(int index) {
    if (expandedFaqIndex.value == index) {
      expandedFaqIndex.value = -1;
    } else {
      expandedFaqIndex.value = index;
    }
  }

  void bookNow() {
    // TODO: Implement booking logic
    Get.snackbar(
      'Book Now',
      'Booking feature coming soon!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void callUs() {
    // TODO: Implement call logic
  }

  void emailSupport() {
    // TODO: Implement email logic
  }
}
