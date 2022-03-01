class AlbumPageTemplate {
  final String title;
  final String type;
  final String downloadLink;

  AlbumPageTemplate({
    required this.title,
    required this.type,
    required this.downloadLink,
  });

  factory AlbumPageTemplate.fromJson(Map<String, dynamic> data) => AlbumPageTemplate(
        title: data['title'],
        type: data['type'],
        downloadLink: data['link'],
      );
}
