class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;
  final String? icon;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false,
    this.icon,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
      isRead: json['isRead'] ?? false,
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'icon': icon,
    };
  }

  NotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    DateTime? timestamp,
    bool? isRead,
    String? icon,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      icon: icon ?? this.icon,
    );
  }
}
