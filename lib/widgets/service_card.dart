import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refresh_pbma/widgets/image_widget.dart';
import '../utils/app_colors.dart';

class ServiceCard extends StatelessWidget {
  final String image;
  final String label;
  final VoidCallback? onTap;

  const ServiceCard({
    super.key,
    required this.image,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width * 0.50,
        // Fill the parent height to ensure all cards are same height
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.lightBorder, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image - Use Expanded to fill available space and prevent overflow
              Expanded(
                child: ImageWidget(
                  image,
                  borderRadius: 12,
                  width: double.infinity,
                  height: double.infinity,
                  // fit: BoxFit.contain,
                ),
                // child: ClipRRect(
                //   borderRadius: BorderRadius.circular(12),
                //   child: SizedBox(
                //     width: double.infinity,
                //     height: double.infinity,
                //     child: image.startsWith('http')
                //         ? Image.network(
                //             image,
                //             width: double.infinity,
                //             height: double.infinity,
                //             fit: BoxFit.cover,
                //             loadingBuilder: (context, child, loadingProgress) {
                //               if (loadingProgress == null) return child;
                //               return Container(
                //                 color: const Color(0xFFF6F6F6),
                //                 child: const Center(
                //                   child: CircularProgressIndicator(
                //                     color: AppColors.primary,
                //                     strokeWidth: 2,
                //                   ),
                //                 ),
                //               );
                //             },
                //             errorBuilder: (context, error, stackTrace) {
                //               return Container(
                //                 color: const Color(0xFFF6F6F6),
                //                 child: const Icon(
                //                   Icons.image,
                //                   color: Color(0xFF888F9A),
                //                 ),
                //               );
                //             },
                //           )
                //         : Image.asset(
                //             image,
                //             width: double.infinity,
                //             height: double.infinity,
                //             fit: BoxFit.cover,
                //           ),
                //   ),
                // ),
              ),

              // Label
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.blackText,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'DMSans',
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
