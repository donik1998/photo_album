class AlbumPageTemplate {
  final String title;
  final String type;
  final String imageLink;

  AlbumPageTemplate({
    required this.title,
    required this.type,
    required this.imageLink,
  });

  factory AlbumPageTemplate.fromJson(Map<String, dynamic> data) {
    print(data);
    return AlbumPageTemplate(
      title: data['title'],
      type: data['type'],
      imageLink: data['link'],
    );
  }
}
