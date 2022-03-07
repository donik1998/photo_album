class AlbumPageTemplate {
  final String title;
  final String type;
  final List<String> imageLinks;

  AlbumPageTemplate({
    required this.title,
    required this.type,
    required this.imageLinks,
  });

  factory AlbumPageTemplate.fromJson(Map<String, dynamic> data) {
    print(data);
    return AlbumPageTemplate(
      title: data['title'],
      type: data['type'],
      imageLinks: data['links'],
    );
  }
}
