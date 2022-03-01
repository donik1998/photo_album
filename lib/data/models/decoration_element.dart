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
    height: data['height'],
    width: data['width'],
    x: data['x'],
    y: data['y'],
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