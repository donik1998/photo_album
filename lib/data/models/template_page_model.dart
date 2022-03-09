class AlbumPageTemplate {
  final String title;
  final String docId;
  final String type;
  final List<String> imageLinks;

  AlbumPageTemplate({
    required this.title,
    required this.docId,
    required this.type,
    required this.imageLinks,
  });

  factory AlbumPageTemplate.fromJson(Map<String, dynamic> data) {
    print(data);
    return AlbumPageTemplate(
      title: data['title'],
      docId: data['id'],
      type: data['type'],
      imageLinks: data['links'].map<String>((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> get toMap => {
        'title': this.title,
        'type': this.type,
        'links': this.imageLinks,
      };

  AlbumPageTemplate copyWith({
    String? title,
    String? type,
    List<String>? imageLinks,
  }) =>
      AlbumPageTemplate(
        docId: this.docId,
        title: title ?? this.title,
        type: type ?? this.type,
        imageLinks: imageLinks ?? this.imageLinks,
      );
}
