class NewsModel {
  final String title;
  final String subtitle;
  final String imageUrl;
  final DateTime? publishDate;

  NewsModel({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.publishDate,
  });

  // Optional: Convert from JSON
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'],
      subtitle: json['subtitle'],
      imageUrl: json['imageUrl'],
      publishDate: json['publishDate'] != null
          ? DateTime.parse(json['publishDate'])
          : null,
    );
  }

  // Optional: Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'imageUrl': imageUrl,
      'publishDate': publishDate?.toIso8601String(),
    };
  }
}
