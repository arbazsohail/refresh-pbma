import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/auto_scroll_banner.dart';
import '../../../widgets/service_card.dart';
import '../../../controllers/explore_controller.dart';

class ExplorePage extends GetView<ExploreController> {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'Explore',
        showNotification: true,
        showSettings: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Popular Services Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Popular Services',
                style: TextStyle(
                  color: Color(0xFF141413),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DMSans',
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Auto-scrolling Popular Services
            Obx(
              () => AutoScrollBanner(
                height: Get.height * 0.15,
                padding: const EdgeInsets.only(left: 20),
                scrollDuration: const Duration(milliseconds: 800),
                pauseDuration: const Duration(seconds: 3),
                children:
                    controller.popularServices.asMap().entries.map((entry) {
                      final index = entry.key;
                      final service = entry.value;
                      return Padding(
                        padding: EdgeInsets.only(
                          right:
                              index < controller.popularServices.length - 1
                                  ? 16
                                  : 20,
                        ),
                        child: ServiceCard(
                          image: service['image']!,
                          label: service['label']!,
                        ),
                      );
                    }).toList(),
              ),
            ),

            SizedBox(height: 24),
            // Ready to Book? Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Bubbles decoration (background layer)
                    Positioned(
                      right: -10,
                      top: -10,
                      child: Opacity(
                        opacity: 0.2,
                        child: SvgPicture.asset(
                          'assets/icons/bubbles.svg',
                          color: Colors.white.withValues(alpha: 0.7),
                         
                        ),
                      ),
                    ),
                    // Content (foreground layer)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ready to Book?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'DMSans',
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Choose your preferred service and time.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'DMSans',
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: controller.bookNow,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Book Now',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'DMSans',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Latest From Our Blog Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Latest From Our Blog',
                style: TextStyle(
                  color: Color(0xFF141413),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DMSans',
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Blog Cards
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children:
                      controller.blogs.asMap().entries.map((entry) {
                        final index = entry.key;
                        final blog = entry.value;
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right:
                                  index < controller.blogs.length - 1 ? 12 : 0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    blog.image,
                                    width: double.infinity,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        width: double.infinity,
                                        height: 100,
                                        color: const Color(0xFFF6F6F6),
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            color: AppColors.primary,
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: double.infinity,
                                        height: 100,
                                        color: const Color(0xFFF6F6F6),
                                        child: const Icon(
                                          Icons.image,
                                          color: Color(0xFF888F9A),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  blog.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Color(0xFF141413),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'DMSans',
                                    height: 1.3,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Read more',
                                  style: TextStyle(
                                    color: AppColors.secondary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'DMSans',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // FAQ's Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
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
            const SizedBox(height: 16),

            // FAQ Items
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children:
                      controller.faqs.asMap().entries.map((entry) {
                        final index = entry.key;
                        final faq = entry.value;
                        final isExpanded =
                            controller.expandedFaqIndex.value == index;

                        return Column(
                          children: [
                            InkWell(
                              onTap: () => controller.toggleFaq(index),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF6F6F6),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            faq.question,
                                            style: const TextStyle(
                                              color: Color(0xFF4E555B),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'DMSans',
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          isExpanded ? Icons.remove : Icons.add,
                                          color: const Color(0xFF4E555B),
                                          size: 24,
                                        ),
                                      ],
                                    ),
                                    if (isExpanded) ...[
                                      const SizedBox(height: 12),
                                      Text(
                                        faq.answer,
                                        style: const TextStyle(
                                          color: Color(0xFF888F9A),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'DMSans',
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                            if (index < controller.faqs.length - 1)
                              const SizedBox(height: 12),
                          ],
                        );
                      }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Need Help? Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Need Help?',
                style: TextStyle(
                  color: Color(0xFF141413),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DMSans',
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Help Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  // Call Us Card
                  Expanded(
                    child: GestureDetector(
                      onTap: controller.callUs,
                      child: Container(
                        height: Get.height * 0.15,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/call.svg',
                              width: 32,
                              height: 32,
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Call Us',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'DMSans',
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Speak Directly',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'DMSans',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Email Support Card
                  Expanded(
                    child: GestureDetector(
                      onTap: controller.emailSupport,
                      child: Container(
                        height: Get.height * 0.15,

                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/mxg.svg',
                              width: 32,
                              height: 32,
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Email Support',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'DMSans',
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Get help via email',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'DMSans',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
