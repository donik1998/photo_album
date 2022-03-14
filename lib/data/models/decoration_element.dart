class DecorationElement {
  final String downloadLink;
  final String title;
  final String localPath;
  final double height, width, x, y;
  final bool isLocal;

  DecorationElement({
    required this.downloadLink,
    this.isLocal = false,
    required this.title,
    this.localPath = '',
    required this.height,
    required this.width,
    required this.x,
    required this.y,
  });

  factory DecorationElement.local({
    required String downloadLink,
    required String title,
    required String localPath,
    required double height,
    required double width,
    required double x,
    required double y,
  }) =>
      DecorationElement(
        downloadLink: downloadLink,
        title: title,
        localPath: localPath,
        height: height,
        width: width,
        x: x,
        y: y,
        isLocal: true,
      );

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

  DecorationElement copyWith({
    String? downloadLink,
    String? title,
    String? localPath,
    double? height,
    double? width,
    double? x,
    double? y,
    bool? isLocal,
  }) =>
      DecorationElement(
        downloadLink: downloadLink ?? this.downloadLink,
        title: title ?? this.title,
        localPath: localPath ?? this.localPath,
        height: height ?? this.height,
        width: width ?? this.width,
        x: x ?? this.x,
        y: y ?? this.y,
        isLocal: isLocal ?? this.isLocal,
      );
}
