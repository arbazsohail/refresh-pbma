import 'package:flutter/material.dart';

class ReferralStepIndicator extends StatelessWidget {
  final int currentStep;
  final List<String> stepLabels;

  const ReferralStepIndicator({
    super.key,
    required this.currentStep,
    required this.stepLabels,
  });

  List<double> _calculateStops() {
    // final segmentSize = 1.0 / (stepLabels.length - 1);
    final completedProgress = (currentStep - 1) / (stepLabels.length - 1);

    List<double> stops = [];
    if (completedProgress > 0) {
      stops.addAll([0.0, completedProgress, completedProgress]);
    } else {
      stops.add(0.0);
    }
    stops.add(1.0);
    return stops;
  }

  List<Color> _calculateColors() {
    final completedProgress = (currentStep - 1) / (stepLabels.length - 1);

    List<Color> colors = [];
    if (completedProgress > 0) {
      colors.addAll([
        const Color(0xFF195B91),
        const Color(0xFF195B91),
        const Color(0xFFD9D9D9),
      ]);
    } else {
      colors.add(const Color(0xFFD9D9D9));
    }
    colors.add(const Color(0xFFD9D9D9));
    return colors;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Continuous connecting line (behind everything)
        Positioned(
          top: 12, // Center line with circles (24px / 2)
          left: 0,
          right: 0,
          child: Row(
            children: [
              // Continuous line with segments colored based on progress
              Expanded(
                child: Container(
                  height: 3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      stops: _calculateStops(),
                      colors: _calculateColors(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Step columns (circles + labels) - each in Expanded for equal spacing
        Row(
          children: List.generate(stepLabels.length, (index) {
            final isCompleted = index < currentStep;
            return Expanded(
              child: Column(
                children: [
                  // Circle
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCompleted ? const Color(0xFF195B91) : const Color(0xFFD9D9D9),
                    ),
                    child: Icon(
                      Icons.check,
                      color: isCompleted ? Colors.white : const Color(0xFFB0B0B0),
                      size: 14,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Label
                  Text(
                    stepLabels[index],
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                      color: Color(0xFF141413),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'DMSans',
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
