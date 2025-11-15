import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/app_colors.dart';
import 'small_loader.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.height,
    this.width,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.icon,
    required this.title,
    this.onTap,
    this.margin = 50,
    this.horizontalPadding = 10,
    this.borderRadius = 42,
    this.titleFontSize = 18,
    this.loading = false,
    this.disabled = false,
    this.gradient = false,
    this.borderColor,
    this.overrideDisableCondition = false,
    this.fontWeight,
    this.colorizeIcon = false,
    this.iconSpacing = 10,
  });

  final double height;
  final double? width;
  final Color backgroundColor;
  final Color textColor;
  final String? icon;
  final String title;
  final double? titleFontSize;
  final VoidCallback? onTap;
  final double margin;
  final double horizontalPadding;
  final bool loading;
  final bool disabled;
  final bool gradient;
  final double borderRadius;
  final Color? borderColor;
  final FontWeight? fontWeight;
  final bool overrideDisableCondition;
  final bool colorizeIcon;
  final double iconSpacing;

  @override
  State<CustomButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<CustomButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (details) {
        if (widget.loading || widget.disabled) return;
        setState(() {
          pressed = true;
        });
      },
      onPanEnd: (_) {
        if (widget.loading || widget.disabled) return;
        setState(() {
          pressed = false;
        });
      },
      onPanCancel: () {
        if (widget.loading || widget.disabled) return;
        setState(() {
          pressed = false;
        });
      },
      onTap: () {
        if ((widget.loading || widget.disabled) &&
            !widget.overrideDisableCondition) {
          return;
        }
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: AnimatedOpacity(
        opacity: pressed ? 0.8 : 1,
        duration: const Duration(milliseconds: 250),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            border: widget.borderColor != null
                ? Border.all(color: widget.borderColor!)
                : null,
            gradient: widget.gradient && !widget.disabled
                ? AppColors.primaryGradient
                : null,
            color: widget.gradient
                ? null
                : widget.disabled
                    ? const Color(0XFFAFADB0).withValues(alpha: 0.75)
                    : widget.backgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: [
              BoxShadow(
                color: widget.disabled
                    ? Colors.transparent
                    : widget.gradient
                        ? AppColors.lightPrimary.withValues(alpha: 0.3)
                        : widget.backgroundColor.withValues(alpha: 0.1),
                spreadRadius: widget.gradient ? 0 : 1.5,
                blurRadius: widget.gradient ? 15 : 4,
                offset: widget.gradient ? const Offset(0, 5) : const Offset(0, 2),
              ),
            ],
          ),
          height: widget.height,
          width: widget.width,
          margin: EdgeInsets.symmetric(horizontal: widget.margin),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null && !widget.loading)
                SvgPicture.asset(
                  widget.icon!,
                  height: 20,
                  colorFilter: widget.colorizeIcon
                      ? ColorFilter.mode(widget.textColor, BlendMode.srcIn)
                      : null,
                ),
              if (widget.icon != null && !widget.loading)
                SizedBox(width: widget.iconSpacing),
              if (!widget.loading)
                Text(
                  widget.title,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: widget.fontWeight ?? FontWeight.w600,
                    color: widget.gradient ? Colors.white : widget.textColor,
                    fontSize: widget.titleFontSize,
                  ),
                ),
              if (widget.loading)
                const SmallLoader(color: Colors.white, adaptive: true),
            ],
          ),
        ),
      ),
    );
  }
}
