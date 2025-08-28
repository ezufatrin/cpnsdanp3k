class BannerModel {
  final String imageUrl;
  final String? title;
  final String? subtitle;
  final String? actionUrl;

  BannerModel({
    required this.imageUrl,
    this.title,
    this.subtitle,
    this.actionUrl,
  });
}
