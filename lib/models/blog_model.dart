class BlogModel {
  final String image;
  final String title;
  final String url;

  BlogModel({
    required this.image,
    required this.title,
    required this.url,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'url': url,
    };
  }
}
