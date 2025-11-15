import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  final double size;
  final Color? borderColor;
  final Color? backgroundColor;
  final String? iconPath;

  const CustomBackButton({
    super.key,
    this.onTap,
    this.size = 38,
    this.borderColor,
    this.backgroundColor,
    this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? Colors.transparent,
        border: Border.all(
          color: borderColor ?? AppColors.borderGrey,
        ),
      ),
      child: GestureDetector(
        onTap: onTap ?? () => Get.back(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(
            iconPath ?? 'assets/icons/arrowBack.svg',
            height: 24,
            width: 24,
          ),
        ),
      ),
    );
  }
}
