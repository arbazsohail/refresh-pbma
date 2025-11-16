import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/app_colors.dart';
import 'custom_button.dart';

class VerificationSuccessDialog extends StatefulWidget {
  final VoidCallback onOkPressed;

  const VerificationSuccessDialog({
    super.key,
    required this.onOkPressed,
  });

  @override
  State<VerificationSuccessDialog> createState() =>
      _VerificationSuccessDialogState();
}

class _VerificationSuccessDialogState extends State<VerificationSuccessDialog> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    // Start confetti animation
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Dialog content
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Success icon with confetti
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Confetti widget
                    ConfettiWidget(
                      confettiController: _confettiController,
                      blastDirectionality: BlastDirectionality.explosive,
                      particleDrag: 0.05,
                      emissionFrequency: 0.05,
                      numberOfParticles: 20,
                      gravity: 0.1,
                      shouldLoop: false,
                      colors: const [
                        AppColors.secondary,
                        AppColors.primary,
                        AppColors.greyText,
                        Colors.blue,
                        Colors.green,
                      ],
                      createParticlePath: (size) {
                        final path = Path();
                        path.addOval(Rect.fromCircle(
                          center: Offset(size.width / 2, size.height / 2),
                          radius: 4,
                        ));
                        return path;
                      },
                    ),
                    // Success icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: AppColors.secondary,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: SvgPicture.asset("assets/icons/tick.svg"),
                      )
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Thank you text
                const Text(
                  'Thank you!',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DMSans',
                  ),
                ),

                const SizedBox(height: 12),

                // Description
                const Text(
                  'Your account is ready to use. You will be redirected to the main page',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.greyText,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'DMSans',
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 32),

                // Ok button
                CustomButton(
                  title: 'Ok',
                  onTap: widget.onOkPressed,
                  height: 54,
                  backgroundColor: AppColors.primary,
                  textColor: AppColors.white,
                  borderRadius: 50,
                  margin: 0,
                  horizontalPadding: 60,
                  titleFontSize: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
