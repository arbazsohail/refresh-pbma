import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../utils/app_colors.dart';

class ReferralsShimmer extends StatelessWidget {
  const ReferralsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // My Referrals Title Shimmer
          _buildShimmerBox(width: 150, height: 24),
          const SizedBox(height: 8),

          // Subtitle Shimmer
          _buildShimmerBox(width: double.infinity, height: 16),
          _buildShimmerBox(width: 200, height: 16),
          const SizedBox(height: 16),

          // Reward Points Card Shimmer
          _buildRewardPointsCardShimmer(),
          const SizedBox(height: 20),

          // Points Tiers and How to Earn Row Shimmer
          Row(
            children: [
              Expanded(child: _buildButtonShimmer()),
              const SizedBox(width: 12),
              Expanded(child: _buildButtonShimmer()),
            ],
          ),
          const SizedBox(height: 24),

          // All Referrals Header Shimmer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildShimmerBox(width: 120, height: 20),
              _buildShimmerBox(width: 60, height: 16),
            ],
          ),
          const SizedBox(height: 16),

          // Referral Items Shimmer
          _buildReferralItemShimmer(),
          const SizedBox(height: 12),
          _buildReferralItemShimmer(),
          const SizedBox(height: 12),
          _buildReferralItemShimmer(),
        ],
      ),
    );
  }

  Widget _buildShimmerBox({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  Widget _buildRewardPointsCardShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 6, 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: const Border(
            left: BorderSide(
              color: Color(0xFF195B91),
              width: 4,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFBCBCBC).withValues(alpha: 0.25),
              blurRadius: 20,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Circle Icon Shimmer
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F6FA),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // "Reward Points" Text Shimmer
                    Container(
                      width: 120,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Points Counter Shimmer
                    Container(
                      width: 80,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Progress Bar Shimmer
            Container(
              width: double.infinity,
              height: 8,
              decoration: BoxDecoration(
                color: const Color(0xFFE8E8E8),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),

            // Info Text Shimmer
            Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Container(
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 80,
              height: 14,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReferralItemShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.lightBorder),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 150,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 70,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: 60,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
