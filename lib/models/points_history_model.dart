class PointsHistoryModel {
  final String status;
  final String userName;
  final String date;
  final int points;
  final bool isRedeemed;

  PointsHistoryModel({
    required this.status,
    required this.userName,
    required this.date,
    required this.points,
    required this.isRedeemed,
  });

  factory PointsHistoryModel.fromJson(Map<String, dynamic> json) {
    return PointsHistoryModel(
      status: json['status'] ?? '',
      userName: json['userName'] ?? '',
      date: json['date'] ?? '',
      points: json['points'] ?? 0,
      isRedeemed: json['isRedeemed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'userName': userName,
      'date': date,
      'points': points,
      'isRedeemed': isRedeemed,
    };
  }
}
