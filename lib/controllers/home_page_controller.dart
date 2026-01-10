import 'package:get/get.dart';
import '../models/blog_model.dart';
import '../models/faq_model.dart';
import '../models/service_model.dart';
import '../services/storage_service.dart';
import '../services/api_service.dart';
import '../services/api_constants.dart';
import '../services/settings_service.dart';

class HomePageController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();
  final ApiService _apiService = Get.find<ApiService>();
  final SettingsService _settingsService = Get.find<SettingsService>();

  final RxList<ServiceModel> services = <ServiceModel>[].obs;
  final RxList<BlogModel> blogs = <BlogModel>[].obs;
  final RxList<FAQModel> faqs = <FAQModel>[].obs;
  final RxInt expandedFaqIndex = (-1).obs;
  final RxString userName = 'User'.obs;
  final RxBool isLoadingServices = false.obs;
  final RxBool isLoadingFaqs = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserName();
    loadData();
    fetchServices();
    fetchFAQs();
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

    // FAQs will be loaded from API via fetchFAQs()
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

  // Fetch services from API
  Future<void> fetchServices() async {
    try {
      isLoadingServices.value = true;

      final response = await _apiService.get(ApiConstants.getServices);

      print('📥 Get Services Response: ${response.data}');

      if (response.data['code'] == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        services.value = data.map((json) => ServiceModel.fromJson(json)).toList();
        print('✅ Loaded ${services.length} services');
      }
    } catch (e) {
      print('❌ Error fetching services: $e');
      // Keep services empty on error
      services.value = [];
    } finally {
      isLoadingServices.value = false;
    }
  }

  // Fetch FAQs from API
  Future<void> fetchFAQs() async {
    try {
      isLoadingFaqs.value = true;

      final response = await _settingsService.getFaqs();

      print('📥 Get FAQs for Home Response: ${response['data']}');

      if (response['code'] == 200) {
        final List<dynamic> data = response['data'] ?? [];
        // Get first 5 FAQs for home page
        final allFaqs = data.map((json) => FAQModel.fromJson(json)).toList();
        faqs.value = allFaqs.take(5).toList();
        print('✅ Loaded ${faqs.length} FAQs for home page');
      }
    } catch (e) {
      print('❌ Error fetching FAQs: $e');
      // Keep FAQs empty on error
      faqs.value = [];
    } finally {
      isLoadingFaqs.value = false;
    }
  }
}
