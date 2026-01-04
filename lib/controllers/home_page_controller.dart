import 'package:get/get.dart';
import '../models/blog_model.dart';
import '../models/faq_model.dart';
import '../utils/app_constants.dart';
import '../services/storage_service.dart';

class HomePageController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();

  final List<Map<String, String>> popularServices = AppConstants.popularServices;
  final RxList<BlogModel> blogs = <BlogModel>[].obs;
  final RxList<FAQModel> faqs = <FAQModel>[].obs;
  final RxInt expandedFaqIndex = (-1).obs;
  final RxString userName = 'User'.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserName();
    loadData();
  }

  void loadUserName() {
    final name = _storageService.getUserName() ?? 'User';
    // Get first name only (split by space and take first part)
    userName.value = name.split(' ').first;
  }

  void loadData() {
    // Blogs - Real data from refreshpbma.com/blog/
    blogs.value = [
      BlogModel(
        image: 'https://refreshpbma.com/wp-content/uploads/2025/06/348s.jpg',
        title: 'Preventative Botox: Why Younger Clients Are Starting Sooner',
        url: 'https://refreshpbma.com/preventative-botox-why-younger-clients-are-starting-sooner/',
      ),
      BlogModel(
        image: 'https://refreshpbma.com/wp-content/uploads/2025/04/patient-consulting-doctor-scaled-1.jpg',
        title: 'Semaglutide & Tirzepatide: Breaking Down the Buzz Around Medical Weight Loss',
        url: 'https://refreshpbma.com/semaglutide-tirzepatide-breaking-down-the-buzz-around-medical-weight-loss/',
      ),
      BlogModel(
        image: 'https://refreshpbma.com/wp-content/uploads/2025/05/IMG_5728.jpg',
        title: 'Why Everyone\'s Talking About Sculptra',
        url: 'https://refreshpbma.com/why-everyones-talking-about-sculptra/',
      ),
      BlogModel(
        image: 'https://refreshpbma.com/wp-content/uploads/2025/06/Microneedling-scaled-1-768x1024-1.jpg',
        title: 'The Ultimate Guide to Microneedling with PRP',
        url: 'https://refreshpbma.com/the-ultimate-guide-to-microneedling-with-prp/',
      ),
      BlogModel(
        image: 'https://refreshpbma.com/wp-content/uploads/2025/06/cosmetic-scene_67_pyoeaz-scaled-1.jpg',
        title: 'Trap Tox Explained: What It Is and Why It\'s Trending',
        url: 'https://refreshpbma.com/trap-tox-explained-what-it-is-and-why-its-trending/',
      ),
      BlogModel(
        image: 'https://refreshpbma.com/wp-content/uploads/2025/06/Microneedling-with-PRP-What-to-Expect-After-PRP-Therapy.jpg',
        title: 'How Often Should You Get Microneedling with PRP Treatments?',
        url: 'https://refreshpbma.com/how-often-should-you-get-microneedling-with-prp-treatments/',
      ),
      BlogModel(
        image: 'https://refreshpbma.com/wp-content/uploads/2025/06/Why-Choose-Hydrafacial-Treatment.webp',
        title: 'Why Hydrafacial Is the Go-To Skincare Treatment for All Ages?',
        url: 'https://refreshpbma.com/why-hydrafacial-is-the-go-to-skincare-treatment-for-all-ages/',
      ),
      BlogModel(
        image: 'https://refreshpbma.com/wp-content/uploads/2025/06/chemical-peels-for-hyperpigmentation-things-you-need-to-know.webp',
        title: 'How Often Should You Get a Chemical Peel for Visible Results?',
        url: 'https://refreshpbma.com/beyond-the-face-comprehensive-wellness-at-refreshpbma/',
      ),
      BlogModel(
        image: 'https://refreshpbma.com/wp-content/uploads/2025/06/botox-treatmnet-process-1024x682-1.webp',
        title: 'Botox vs. Dysport vs. Xeomin: What\'s the Difference?',
        url: 'https://refreshpbma.com/botox-vs-dysport-vs-xeomin-whats-the-difference/',
      ),
      BlogModel(
        image: 'https://refreshpbma.com/wp-content/uploads/2024/11/Photofacial-4.webp',
        title: 'How Photofacials Minimize Age Spots and Freckles?',
        url: 'https://refreshpbma.com/how-photofacials-minimize-age-spots-and-freckles/',
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
    Get.snackbar(
      'Book Now',
      'Booking feature coming soon!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void applyPayment() {
    Get.toNamed('/payment-application');
  }

  void callUs() {
  }

  void emailSupport() {
  }
}
