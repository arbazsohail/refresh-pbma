import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/app_colors.dart';

class ActionCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String buttonText;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? btnTextColor;
  final Color? imageBgColor;

  final String? secondButtonText;
  final VoidCallback? onSecondButtonPressed;
  final double? buttonWidth;
  final double? buttonHeight;
  final String? decorationIcon;
  final bool useOriginalDecoration;

  const ActionCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.btnTextColor,
    required this.buttonText,
    required this.onPressed,
    this.secondButtonText,
    this.onSecondButtonPressed,
    this.buttonWidth,
    this.buttonHeight,
    this.backgroundColor,
    this.imageBgColor,

    this.decorationIcon,
    this.useOriginalDecoration = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Decoration icon (background layer) - positioned on the right
          if (decorationIcon != null)
            Positioned(
              right: -10,
              top: 2,
              child: SvgPicture.asset(
                decorationIcon!,
                colorFilter:
                    useOriginalDecoration
                        ? null
                        : ColorFilter.mode(
                          imageBgColor ?? Colors.white,
                          BlendMode.srcIn,
                        ),
              ),
            ),
          // Content (foreground layer)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DMSans',
                ),
              ),
              const SizedBox(height: 8),
              subtitle == null
                  ? SizedBox()
                  : Text(
                    subtitle ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'DMSans',
                    ),
                  ),
              subtitle == null ? SizedBox() : SizedBox(height: 16),
              subtitle == null ? SizedBox() : SizedBox(height: 16),
              if (secondButtonText != null)
                Row(
                  children: [
                    if (buttonWidth != null)
                      SizedBox(
                        width: buttonWidth,
                        height: buttonHeight ?? 41,
                        child: ElevatedButton(
                          onPressed: onPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            buttonText,
                            style: TextStyle(
                              color: btnTextColor ?? AppColors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'DMSans',
                            ),
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: SizedBox(
                          height: buttonHeight ?? 41,
                          child: ElevatedButton(
                            onPressed: onPressed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              buttonText,
                              style: TextStyle(
                                color: btnTextColor ?? AppColors.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'DMSans',
                              ),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(width: 5), // Gap 5px
                    if (buttonWidth != null)
                      SizedBox(
                        width: buttonWidth,
                        height: buttonHeight ?? 41,
                        child: ElevatedButton(
                          onPressed: onSecondButtonPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            secondButtonText!,
                            style: TextStyle(
                              color: btnTextColor ?? AppColors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'DMSans',
                            ),
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: SizedBox(
                          height: buttonHeight ?? 41,
                          child: ElevatedButton(
                            onPressed: onSecondButtonPressed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              secondButtonText!,
                              style: TextStyle(
                                color: btnTextColor ?? AppColors.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'DMSans',
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                )
              else
                ElevatedButton(
                  onPressed: onPressed,
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
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      color: btnTextColor ?? AppColors.primary,
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
    );
  }
}
