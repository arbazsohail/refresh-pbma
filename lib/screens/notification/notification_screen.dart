import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../controllers/notification_controller.dart';
import '../../models/notification_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_refresh_header.dart';
import '../../widgets/custom_refresh_footer.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConstants.lightSystemOverlay(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const CustomAppBar(
          title: 'Notifications',
          showBackButton: true,
        ),
        body: Obx(() {
          if (controller.isLoading.value && controller.notifications.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.secondary,
              ),
            );
          }

          if (controller.notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: 0.3,
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'No notifications yet',
                    style: TextStyle(
                      color: AppColors.greyText,
                      fontSize: 16,
                      fontFamily: 'DMSans',
                    ),
                  ),
                ],
              ),
            );
          }

          final groupedNotifications = controller.groupedNotifications;

          return SmartRefresher(
            controller: controller.refreshController,
            enablePullDown: true,
            enablePullUp: true,
            header: const CustomRefreshHeader(),
            footer: const CustomRefreshFooter(),
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoadMore,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: groupedNotifications.length,
              itemBuilder: (context, index) {
                final dateLabel = groupedNotifications.keys.elementAt(index);
                final notifications = groupedNotifications[dateLabel]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date header
                    Padding(
                      padding: EdgeInsets.only(
                        left: 8,
                        top: index == 0 ? 8 : 24,
                        bottom: 16,
                      ),
                      child: Text(
                        dateLabel,
                        style: const TextStyle(
                          color: Color(0xFF7C8086),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'DMSans',
                        ),
                      ),
                    ),

                    // Notification items
                    ...notifications.map((notification) {
                      return _buildNotificationItem(notification);
                    }),
                  ],
                );
              },
            ),
          );
        }),
      ),
    );
  }

  Widget _buildNotificationItem(NotificationModel notification) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: notification.isRead
            ? AppColors.white
            : AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE8E8E8),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 24,
                height: 24,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Notification content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.message,
                  style: TextStyle(
                    color: AppColors.blackText,
                    fontSize: 14,
                    fontWeight: notification.isRead
                        ? FontWeight.w400
                        : FontWeight.w500,
                    fontFamily: 'DMSans',
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatTime(notification.timestamp),
                  style: const TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'DMSans',
                  ),
                ),
              ],
            ),
          ),

          // Unread indicator
          if (!notification.isRead)
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(top: 4),
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
