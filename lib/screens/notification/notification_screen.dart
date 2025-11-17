import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../controllers/notification_controller.dart';
import '../../models/notification_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/custom_refresh_header.dart';
import '../../widgets/custom_refresh_footer.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConstants.lightSystemOverlay(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF141413),
            ),
            onPressed: () => Get.back(),
          ),
          title: const Text(
            'Notifications',
            style: TextStyle(
              color: Color(0xFF141413),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'DMSans',
            ),
          ),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                        left: 4,
                        top: index == 0 ? 0 : 20,
                        bottom: 12,
                      ),
                      child: Text(
                        dateLabel,
                        style: const TextStyle(
                          color: Color(0xFF888F9A),
                          fontSize: 13,
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo icon
          Image.asset(
            'assets/images/logo.png',
            width: 48,
            height: 48,
          ),

          const SizedBox(width: 14),

          // Notification content
          Expanded(
            child: Text(
              notification.message,
              style: const TextStyle(
                color: Color(0xFF141413),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'DMSans',
                height: 1.5,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
