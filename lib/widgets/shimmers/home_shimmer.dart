import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../utils/app_colors.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Overview Title Shimmer
          _buildShimmerBox(width: 100, height: 20),
          const SizedBox(height: 16),

          // Overview Cards Shimmer
          Row(
            children: [
              Expanded(child: _buildOverviewCardShimmer()),
              const SizedBox(width: 12),
              Expanded(child: _buildOverviewCardShimmer()),
            ],
          ),
          const SizedBox(height: 24),

          // Share Referral Link Title Shimmer
          _buildShimmerBox(width: 150, height: 20),
          const SizedBox(height: 10),

          // Share Referral Link Card Shimmer
          _buildShareCardShimmer(),
          const SizedBox(height: 24),

          // Recent Referrals Header Shimmer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildShimmerBox(width: 150, height: 20),
              _buildShimmerBox(width: 60, height: 16),
            ],
          ),
          const SizedBox(height: 16),

          // Recent Referrals List Shimmer
          _buildReferralItemShimmer(),
          const SizedBox(height: 12),
          _buildReferralItemShimmer(),
          const SizedBox(height: 12),
          _buildReferralItemShimmer(),
        ],
      ),
    );
  }

  Widget _buildShimmerBox({required double width, required double height, double? borderRadius}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius ?? 4),
        ),
      ),
    );
  }

  Widget _buildOverviewCardShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: const Border(
            left: BorderSide(color: Color(0xFF195B91), width: 3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: 80,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 20,
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

  Widget _buildShareCardShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
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
          borderRadius: BorderRadius.circular(12),
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
                    borderRadius: BorderRadius.circular(12),
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
