import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';

class AdaptiveAnimatedToggle extends StatefulWidget {
  final List<String> values;
  final List<String?>? icons; // Optional SVG icon paths for each tab
  final ValueChanged<int> onToggleCallback;
  final int initialValue;
  final Color backgroundColor;
  final Color textColor;
  final Color? selectedColor;
  final Color? selectedTextColor;
  final bool isOnlyDisplayIOSTabView;

  const AdaptiveAnimatedToggle({
    super.key,
    required this.values,
    this.icons,
    required this.onToggleCallback,
    this.initialValue = 0,
    this.backgroundColor = const Color(0xFFe7e7e8),
    this.textColor = const Color(0xFF000000),
    this.selectedColor,
    this.selectedTextColor,
    this.isOnlyDisplayIOSTabView = false,
  });

  @override
  State<AdaptiveAnimatedToggle> createState() => _AdaptiveAnimatedToggleState();
}

class _AdaptiveAnimatedToggleState extends State<AdaptiveAnimatedToggle> {
  late int selectedIndex;

  @override
  void initState() {
    selectedIndex = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double toggleWidth = Get.width * 0.9;
    final double itemWidth = toggleWidth / widget.values.length;

    return Container(
      width: toggleWidth,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Stack(
        children: [
          if (widget.isOnlyDisplayIOSTabView || Platform.isIOS)
            // iOS Style Background
            Container(
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: widget.backgroundColor, width: 1),
              ),
            ),
          Row(
            children: List.generate(widget.values.length, (index) {
              bool isSelected = selectedIndex == index;

              final hasIcon = widget.icons != null &&
                              index < widget.icons!.length &&
                              widget.icons![index] != null;

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => selectedIndex = index);
                    widget.onToggleCallback(index);
                  },
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (hasIcon)
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: SvgPicture.asset(
                              widget.icons![index]!,
                              width: 16,
                              height: 16,
                              colorFilter: ColorFilter.mode(
                                isSelected
                                    ? widget.selectedTextColor ?? widget.textColor
                                    : widget.textColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        Text(
                          widget.values[index],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w500,
                            color:
                                isSelected
                                    ? widget.selectedTextColor ?? widget.textColor
                                    : widget.textColor,
                            fontFamily: 'Gilroy',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
          if (widget.isOnlyDisplayIOSTabView || Platform.isIOS)
            // iOS Style Highlight (selected background)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.decelerate,
              left: itemWidth * selectedIndex,
              child: IgnorePointer(
                child: Container(
                  width: itemWidth,
                  height: 50,
                  decoration: BoxDecoration(
                    color: widget.selectedColor ?? AppColors.secondary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.icons != null &&
                          selectedIndex < widget.icons!.length &&
                          widget.icons![selectedIndex] != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: SvgPicture.asset(
                            widget.icons![selectedIndex]!,
                            width: 16,
                            height: 16,
                            colorFilter: ColorFilter.mode(
                              widget.selectedTextColor ?? Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      Text(
                        widget.values[selectedIndex],
                        style: TextStyle(
                          fontSize: 14,
                          color: widget.selectedTextColor ?? Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Gilroy',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (!Platform.isIOS && !widget.isOnlyDisplayIOSTabView)
            // Android Style Underline
            Positioned(
              bottom: 0,
              left: itemWidth * selectedIndex,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: itemWidth,
                height: 2,
                color: widget.selectedColor ?? AppColors.secondary,
              ),
            ),
        ],
      ),
    );
  }
}
