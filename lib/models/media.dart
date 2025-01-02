enum MediaType { normal, live }

class Media {
  final String title;
  final String url;
  final MediaType type;

  const Media(this.url, {this.type = MediaType.normal, required this.title});
}
