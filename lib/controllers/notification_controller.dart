import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../models/notification_model.dart';

class NotificationController extends GetxController {
  final RefreshController refreshController = RefreshController();
  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  // Load notifications
  void loadNotifications() {
    isLoading.value = true;

    // Sample notifications data
    notifications.value = [
      NotificationModel(
        id: '1',
        title: 'Referral Reward',
        message: 'Hi [First Name]! Your referral link was just sent. You\'ll earn 500 points...',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: false,
      ),
      NotificationModel(
        id: '2',
        title: 'Referral Reward',
        message: 'Hi [First Name]! Your referral link was just sent. You\'ll earn 500 points...',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        isRead: false,
      ),
      NotificationModel(
        id: '3',
        title: 'Referral Reward',
        message: 'Hi [First Name]! Your referral link was just sent. You\'ll earn 500 points...',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
        isRead: false,
      ),
      NotificationModel(
        id: '4',
        title: 'Referral Reward',
        message: 'Hi [First Name]! Your referral link was just sent. You\'ll earn 500 points...',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 8)),
        isRead: false,
      ),
      NotificationModel(
        id: '5',
        title: 'Referral Reward',
        message: 'Hi [First Name]! Your referral link was just sent. You\'ll earn 500 points...',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 12)),
        isRead: false,
      ),
    ];

    isLoading.value = false;
  }

  // Pull to refresh
  Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    loadNotifications();
    refreshController.refreshCompleted();
  }

  // Load more notifications
  Future<void> onLoadMore() async {
    await Future.delayed(const Duration(seconds: 1));
    // In a real app, you would load more notifications from API
    refreshController.loadComplete();
  }

  // Mark notification as read
  void markAsRead(String notificationId) {
    final index = notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      notifications[index] = notifications[index].copyWith(isRead: true);
      notifications.refresh();
    }
  }

  // Mark all as read
  void markAllAsRead() {
    notifications.value = notifications.map((n) => n.copyWith(isRead: true)).toList();
  }

  // Get notifications grouped by date
  Map<String, List<NotificationModel>> get groupedNotifications {
    final Map<String, List<NotificationModel>> grouped = {};

    for (var notification in notifications) {
      final date = _getDateLabel(notification.timestamp);
      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }
      grouped[date]!.add(notification);
    }

    return grouped;
  }

  // Get date label (Today, Yesterday, or date)
  String _getDateLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final notificationDate = DateTime(date.year, date.month, date.day);

    if (notificationDate == today) {
      return 'Today, ${_formatDate(date)}';
    } else if (notificationDate == yesterday) {
      return 'Yesterday, ${_formatDate(date)}';
    } else {
      return _formatDate(date);
    }
  }

  // Format date
  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}';
  }
}
