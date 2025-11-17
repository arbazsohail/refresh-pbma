class HomeDataModel {
  final int totalReferrals;
  final int rewardsPoints;
  final double rewardsMoney;
  final String referralLink;

  HomeDataModel({
    required this.totalReferrals,
    required this.rewardsPoints,
    required this.rewardsMoney,
    required this.referralLink,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) {
    return HomeDataModel(
      totalReferrals: json['totalReferrals'] ?? 0,
      rewardsPoints: json['rewardsPoints'] ?? 0,
      rewardsMoney: (json['rewardsMoney'] ?? 0).toDouble(),
      referralLink: json['referralLink'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalReferrals': totalReferrals,
      'rewardsPoints': rewardsPoints,
      'rewardsMoney': rewardsMoney,
      'referralLink': referralLink,
    };
  }
}
