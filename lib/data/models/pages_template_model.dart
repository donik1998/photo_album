class AlbumPageTemplate {
  final String title;
  final String type;
  final List<String> downloadLinks;

  AlbumPageTemplate({
    required this.title,
    required this.type,
    required this.downloadLinks,
  });

  factory AlbumPageTemplate.fromJson(Map<String, dynamic> data) => AlbumPageTemplate(
        title: data['title'],
        type: data['type'],
        downloadLinks: data['links'].map<String>((link) => link.toString()).toList(),
      );
}
