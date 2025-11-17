class HowToEarnModel {
  final String iconPath;
  final String title;
  final String description;
  final String status;
  final bool isCompleted;

  HowToEarnModel({
    required this.iconPath,
    required this.title,
    required this.description,
    required this.status,
    required this.isCompleted,
  });

  factory HowToEarnModel.fromJson(Map<String, dynamic> json) {
    return HowToEarnModel(
      iconPath: json['iconPath'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iconPath': iconPath,
      'title': title,
      'description': description,
      'status': status,
      'isCompleted': isCompleted,
    };
  }
}
