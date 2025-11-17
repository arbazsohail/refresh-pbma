class RewardTierModel {
  final String points;
  final String referrals;
  final String title;
  final String value;

  RewardTierModel({
    required this.points,
    required this.referrals,
    required this.title,
    required this.value,
  });

  factory RewardTierModel.fromJson(Map<String, dynamic> json) {
    return RewardTierModel(
      points: json['points'] ?? '',
      referrals: json['referrals'] ?? '',
      title: json['title'] ?? '',
      value: json['value'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'points': points,
      'referrals': referrals,
      'title': title,
      'value': value,
    };
  }
}
