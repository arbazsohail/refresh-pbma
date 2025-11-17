import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../models/referral_model.dart';

class ReferralCardWidget extends StatelessWidget {
  final ReferralModel referral;
  final VoidCallback? onTap;

  const ReferralCardWidget({
    super.key,
    required this.referral,
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
            // Logo
            Image.asset(
              'assets/images/logo.png',
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 12),

            // Name and Date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    referral.name,
                    style: const TextStyle(
                      color: Color(0xFF141413),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'DMSans',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    referral.date,
                    style: const TextStyle(
                      color: Color(0xFF888F9A),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'DMSans',
                    ),
                  ),
                ],
              ),
            ),

            // Status and Points
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: referral.isRewarded
                        ? AppColors.lightGreen
                        : AppColors.lightYellow,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Text(
                    referral.status,
                    style: TextStyle(
                      color: referral.isRewarded
                          ? AppColors.darkGreen
                          : AppColors.darkYellow,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'DMSans',
                    ),
                  ),
                ),
                if (referral.points.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    referral.points,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: AppColors.secondary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'DMSans',
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
