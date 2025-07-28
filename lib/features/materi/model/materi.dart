class Materi {
  final String title;
  final String url;

  Materi({required this.title, required this.url});

  String get fileName => "${title.replaceAll(' ', '_').toLowerCase()}.pdf";
}
