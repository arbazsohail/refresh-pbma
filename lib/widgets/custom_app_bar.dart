import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? leadingText;
  final bool showBackButton;
  final bool showNotification;
  final bool showSettings;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onSettingsTap;
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
    this.onNotificationTap,
    this.onSettingsTap,
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Leading section
              if (customLeading != null)
                customLeading!
              else if (showBackButton)
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
                )
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

              // Spacer for centering title or for leading text
              if (title != null && leadingText == null && !showBackButton)
                const Spacer(),

              // Center title (only if no leading text)
              if (title != null && leadingText == null)
                Text(
                  title!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DMSans',
                  ),
                ),

              // Spacer
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
                        onTap: onNotificationTap ?? () {},
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
                        onTap: onSettingsTap ?? () {},
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
