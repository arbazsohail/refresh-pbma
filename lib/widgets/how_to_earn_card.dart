import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/app_colors.dart';

class HowToEarnCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String description;
  final String status;
  final bool isCompleted;
  final VoidCallback? onTap;

  const HowToEarnCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.description,
    required this.status,
    required this.isCompleted,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: SvgPicture.asset(
                  iconPath,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Title and Description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF141413),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'DMSans',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Color(0xFF888F9A),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'DMSans',
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // Status Badge
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: isCompleted
                    ? AppColors.lightGreen
                    : AppColors.lightYellow,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: isCompleted
                      ? AppColors.darkGreen
                      : AppColors.darkYellow,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'DMSans',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
