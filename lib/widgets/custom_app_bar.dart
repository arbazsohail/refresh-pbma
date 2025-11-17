import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';
import '../routes/app_routes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? leadingText;
  final bool showBackButton;
  final bool showNotification;
  final bool showSettings;
  final VoidCallback? onBackTap;
  final Widget? customLeading;
  final List<Widget>? customActions;

  const CustomAppBar({
    super.key,
    this.title,
    this.leadingText,
    this.showBackButton = false,
    this.showNotification = false,
    this.showSettings = false,
    this.onBackTap,
    this.customLeading,
    this.customActions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(140);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child:
              title != null && leadingText == null
                  ? Stack(
                    children: [
                      // Centered title
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          title!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'DMSans',
                          ),
                        ),
                      ),
                      // Leading section (back button if needed)
                      if (showBackButton || customLeading != null)
                        Align(
                          alignment: Alignment.centerLeft,
                          child:
                              customLeading ??
                              GestureDetector(
                                onTap: onBackTap ?? () => Get.back(),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                        ),
                      // Trailing actions
                      Align(
                        alignment: Alignment.centerRight,
                        child:
                            customActions != null
                                ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: customActions!,
                                )
                                : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (showNotification) ...[
                                      GestureDetector(
                                        onTap:
                                            () => Get.toNamed(
                                              AppRoutes.notification,
                                            ),
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withValues(
                                              alpha: 0.2,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              'assets/icons/notification.svg',
                                              width: 20,
                                              height: 20,
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                    Colors.white,
                                                    BlendMode.srcIn,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                    ],
                                    if (showSettings)
                                      GestureDetector(
                                        onTap:
                                            () =>
                                                Get.toNamed(AppRoutes.settings),
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withValues(
                                              alpha: 0.2,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              'assets/icons/settings.svg',
                                              width: 20,
                                              height: 20,
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                    Colors.white,
                                                    BlendMode.srcIn,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                      ),
                    ],
                  )
                  : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Leading section for home page with leadingText
                      if (customLeading != null)
                        customLeading!
                      else if (leadingText != null)
                        Flexible(
                          child: Text(
                            leadingText!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'DMSans',
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.visible,
                          ),
                        ),

                      const Spacer(),

                      // Trailing actions
                      if (customActions != null)
                        ...customActions!
                      else
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (showNotification) ...[
                              GestureDetector(
                                onTap:
                                    () => Get.toNamed(AppRoutes.notification),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/icons/notification.svg',
                                      width: 20,
                                      height: 20,
                                      colorFilter: const ColorFilter.mode(
                                        Colors.white,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                            ],
                            if (showSettings)
                              GestureDetector(
                                onTap: () => Get.toNamed(AppRoutes.settings),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/icons/settings.svg',
                                      width: 20,
                                      height: 20,
                                      colorFilter: const ColorFilter.mode(
                                        Colors.white,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
        ),
      ),
    );
  }
}
