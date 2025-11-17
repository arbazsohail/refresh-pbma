class BlogModel {
  final String image;
  final String title;

  BlogModel({
    required this.image,
    required this.title,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      image: json['image'] ?? '',
      title: json['title'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
    };
  }
}
