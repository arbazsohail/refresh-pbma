import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'storage_service.dart';

/// Firebase Cloud Messaging Service
/// Handles FCM token management and push notifications
class FirebaseService extends GetxService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final StorageService _storageService = Get.find<StorageService>();

  String? _fcmToken;

  /// Get current FCM token
  String? get fcmToken => _fcmToken;

  @override
  void onInit() {
    super.onInit();
    _initializeFCM();
  }

  /// Initialize Firebase Cloud Messaging
  Future<void> _initializeFCM() async {
    try {
      // Request permission for iOS
      NotificationSettings settings = await _messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      print('📱 FCM Permission Status: ${settings.authorizationStatus}');

      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        // Get FCM token
        await _getFCMToken();

        // Listen to token refresh
        _messaging.onTokenRefresh.listen((newToken) {
          print('🔄 FCM Token Refreshed: $newToken');
          _fcmToken = newToken;
          _storageService.saveString('fcm_token', newToken);
        });

        // Handle foreground messages
        FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

        // Handle background messages
        FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

        // Handle notification tap when app is in background
        FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

        // Check if app was opened from a notification
        RemoteMessage? initialMessage = await _messaging.getInitialMessage();
        if (initialMessage != null) {
          _handleNotificationTap(initialMessage);
        }

        print('✅ Firebase Messaging initialized successfully');
      } else {
        print('⚠️ FCM Permission denied');
      }
    } catch (e) {
      print('❌ Firebase Messaging Error: $e');
    }
  }

  /// Get FCM token
  /// Uses getToken() for Android and getAPNSToken() for iOS
  Future<void> _getFCMToken() async {
    try {
      String? token;

      // For iOS, we need both APNS token and FCM token
      if (Platform.isIOS) {
        // Get APNS token first (required for iOS)
        String? apnsToken = await _messaging.getAPNSToken();
        if (apnsToken != null) {
          print('📱 APNS Token: $apnsToken');
          // Now get FCM token
          token = await _messaging.getToken();
        } else {
          print('⚠️ APNS token not available yet, retrying...');
          // Retry after a delay
          await Future.delayed(const Duration(seconds: 1));
          apnsToken = await _messaging.getAPNSToken();
          if (apnsToken != null) {
            token = await _messaging.getToken();
          }
        }
      } else {
        // For Android, directly get FCM token
        token = await _messaging.getToken();
      }

      if (token != null) {
        _fcmToken = token;
        await _storageService.saveString('fcm_token', token);
        print('📱 FCM Token: $token');
      } else {
        print('⚠️ FCM Token is null');
      }
    } catch (e) {
      print('❌ Error getting FCM token: $e');
    }
  }

  /// Handle foreground messages
  void _handleForegroundMessage(RemoteMessage message) {
    print('📬 Foreground Message: ${message.notification?.title}');

    // TODO: Show local notification or update UI
    // You can use a package like flutter_local_notifications
    // to show notifications when app is in foreground

    if (message.notification != null) {
      print('Notification Title: ${message.notification!.title}');
      print('Notification Body: ${message.notification!.body}');
    }

    if (message.data.isNotEmpty) {
      print('Message Data: ${message.data}');
    }
  }

  /// Handle notification tap
  void _handleNotificationTap(RemoteMessage message) {
    print('🔔 Notification Tapped: ${message.notification?.title}');

    // TODO: Navigate to specific screen based on notification data
    // Example:
    // if (message.data['type'] == 'order') {
    //   Get.toNamed('/order-details', arguments: message.data['order_id']);
    // }

    if (message.data.isNotEmpty) {
      print('Notification Data: ${message.data}');
    }
  }

  /// Delete FCM token
  Future<void> deleteToken() async {
    try {
      await _messaging.deleteToken();
      _fcmToken = null;
      await _storageService.remove('fcm_token');
      print('🗑️ FCM Token deleted');
    } catch (e) {
      print('❌ Error deleting FCM token: $e');
    }
  }
}

/// Handle background messages
/// This must be a top-level function
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('📭 Background Message: ${message.notification?.title}');

  // TODO: Handle background notification
  // Note: You cannot update UI here, only process data
}
