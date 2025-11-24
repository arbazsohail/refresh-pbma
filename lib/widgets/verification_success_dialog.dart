import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/app_colors.dart';
import 'custom_button.dart';

class CustomSuccessDialog extends StatefulWidget {
  final VoidCallback onOkPressed;
  final String title;
  final String description;
  final String buttonText;
  final bool showConfetti;
  final String? iconAsset;
  final Color? iconBackgroundColor;

  const CustomSuccessDialog({
    super.key,
    required this.onOkPressed,
    this.title = 'Thank you!',
    this.description = 'Your account is ready to use. You will be redirected to the main page',
    this.buttonText = 'Ok',
    this.showConfetti = true,
    this.iconAsset = 'assets/icons/tick.svg',
    this.iconBackgroundColor = AppColors.secondary,
  });

  @override
  State<CustomSuccessDialog> createState() =>
      _CustomSuccessDialogState();
}

class _CustomSuccessDialogState extends State<CustomSuccessDialog> {
  late ConfettiController? _confettiController;

  @override
  void initState() {
    super.initState();
    if (widget.showConfetti) {
      _confettiController = ConfettiController(duration: const Duration(seconds: 3));
      // Start confetti animation
      _confettiController!.play();
    } else {
      _confettiController = null;
    }
  }

  @override
  void dispose() {
    _confettiController?.dispose();
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Success icon with optional confetti
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Confetti widget (if enabled)
                    if (widget.showConfetti && _confettiController != null)
                      ConfettiWidget(
                        confettiController: _confettiController!,
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
                      decoration: BoxDecoration(
                        color: widget.iconBackgroundColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: widget.iconAsset != null
                            ? Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: SvgPicture.asset(widget.iconAsset!),
                              )
                            : const Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: 30,
                              ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Title text
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DMSans',
                  ),
                ),

                const SizedBox(height: 12),

                // Description
                Text(
                  widget.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.greyText,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'DMSans',
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 32),

                // Button
                CustomButton(
                  title: widget.buttonText,
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

// Convenience constructor for verification success
class VerificationSuccessDialog extends CustomSuccessDialog {
  const VerificationSuccessDialog({
    super.key,
    required super.onOkPressed,
  }) : super(
          title: 'Thank you!',
          description: 'Your account is ready to use. You will be redirected to the main page',
          buttonText: 'Ok',
          showConfetti: true,
          iconAsset: 'assets/icons/tick.svg',
          iconBackgroundColor: AppColors.secondary,
        );
}
