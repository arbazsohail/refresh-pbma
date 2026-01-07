import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';

class RedeemPointsDialog extends StatelessWidget {
  final int availablePoints;
  final int minimumPoints;
  final Future<bool> Function(int points) onRedeem;

  const RedeemPointsDialog({
    super.key,
    required this.availablePoints,
    required this.onRedeem,
    this.minimumPoints = 500,
  });

  @override
  Widget build(BuildContext context) {
    final RxDouble selectedPoints = (minimumPoints.toDouble()).obs;
    final RxDouble creditAmount = (minimumPoints / 10).obs;
    final RxBool isSubmitting = false.obs;

    return Dialog(
      insetPadding: EdgeInsets.all(15),
      backgroundColor: AppColors.lightBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              'Redeem Points',
              style: TextStyle(
                color: Color(0xFF141413),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'DMSans',
              ),
            ),
            const SizedBox(height: 20),

            // Points and Amount Display
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${selectedPoints.value.toInt()} points',
                    style: const TextStyle(
                      color: AppColors.secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'DMSans',
                    ),
                  ),
                  Text(
                    '\$${creditAmount.value.toInt()}',
                    style: const TextStyle(
                      color: AppColors.secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'DMSans',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Slider
            Obx(
              () => SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: AppColors.secondary,
                  inactiveTrackColor: const Color(0xFFE0E0E0),
                  thumbColor: AppColors.secondary,
                  overlayColor: AppColors.secondary.withValues(alpha: 0.2),
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 10,
                  ),
                  trackHeight: 4,
                ),
                child: Slider(
                  value: selectedPoints.value,
                  min: minimumPoints.toDouble(),
                  max: availablePoints.toDouble(),
                  divisions: ((availablePoints - minimumPoints) / 10).toInt(),
                  onChanged: (value) {
                    selectedPoints.value = value;
                    creditAmount.value = value / 10;
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Minimum text
            Text(
              'Minimum - $minimumPoints',
              style: const TextStyle(
                color: Color(0xFF888F9A),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontFamily: 'DMSans',
              ),
            ),
            const SizedBox(height: 24),

            // Submit Button
            Obx(
              () => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isSubmitting.value
                      ? null
                      : () async {
                          isSubmitting.value = true;

                          // Call the API through controller
                          final success = await onRedeem(selectedPoints.value.toInt());

                          isSubmitting.value = false;

                          // Only close dialog if the request was successful
                          if (success) {
                            Get.back();
                          }
                          // If failed, dialog stays open and snackbar is shown by controller
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.6),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: isSubmitting.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'Submit Redeem Request',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'DMSans',
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Contact message
            const Center(
              child: Text(
                'We\'ll contact with you within 24 hours',
                style: TextStyle(
                  color: Color(0xFF888F9A),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
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
