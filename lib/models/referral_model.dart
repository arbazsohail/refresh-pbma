class ReferralModel {
  final String name;
  final String date;
  final String status;
  final String points;
  final bool isRewarded;

  ReferralModel({
    required this.name,
    required this.date,
    required this.status,
    required this.points,
    required this.isRewarded,
  });

  factory ReferralModel.fromJson(Map<String, dynamic> json) {
    return ReferralModel(
      name: json['name'] ?? '',
      date: json['date'] ?? '',
      status: json['status'] ?? '',
      points: json['points'] ?? '',
      isRewarded: json['isRewarded'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date,
      'status': status,
      'points': points,
      'isRewarded': isRewarded,
    };
  }
}
