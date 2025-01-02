enum MediaType { normal, live }

class Media {
  final String url;
  final MediaType type;

  const Media(this.url, {this.type = MediaType.normal});
}
