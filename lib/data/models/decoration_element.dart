class DecorationElement {
  final String downloadLink;
  final String title;
  final String localPath;
  final double height, width, x, y;

  DecorationElement({
    required this.downloadLink,
    required this.title,
    this.localPath = '',
    required this.height,
    required this.width,
    required this.x,
    required this.y,
  });

  factory DecorationElement.fromMap(Map<String, dynamic> data) => DecorationElement(
        downloadLink: data['download_link'],
        title: data['title'],
        height: data['height'].toDouble(),
        width: data['width'].toDouble(),
        x: data['x']?.toDouble() ?? 0,
        y: data['y']?.toDouble() ?? 0,
      );

  bool get isCached => localPath.isNotEmpty;

  Map<String, dynamic> get toMap => {
        'download_link': this.downloadLink,
        'height': this.height,
        'width': this.width,
        'x': this.x,
        'y': this.y,
        'title': this.title,
        'local_path': this.localPath,
      };
}
