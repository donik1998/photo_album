class AlbumDecoration {
  final String downloadLink;
  final String title;
  final String localPath;
  final String fontFamily;
  final double height, width, x, y;
  final bool isLocal;
  final bool isText;

  AlbumDecoration({
    required this.downloadLink,
    this.isLocal = false,
    this.isText = false,
    this.fontFamily = '',
    required this.title,
    this.localPath = '',
    required this.height,
    required this.width,
    required this.x,
    required this.y,
  });

  factory AlbumDecoration.local({
    required String downloadLink,
    required String title,
    required String localPath,
    required double height,
    required double width,
    required double x,
    required double y,
  }) =>
      AlbumDecoration(
        downloadLink: downloadLink,
        title: title,
        localPath: localPath,
        height: height,
        width: width,
        x: x,
        y: y,
        isLocal: true,
      );

  factory AlbumDecoration.text({
    required String title,
    required String family,
    required double height,
    required double width,
    required double x,
    required double y,
  }) =>
      AlbumDecoration(
        downloadLink: '',
        title: title,
        localPath: '',
        height: height,
        width: width,
        x: x,
        y: y,
        isLocal: false,
        fontFamily: family,
        isText: true,
      );

  factory AlbumDecoration.fromMap(Map<String, dynamic> data) => AlbumDecoration(
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

  AlbumDecoration copyWith({
    String? downloadLink,
    String? title,
    String? localPath,
    double? height,
    double? width,
    double? x,
    double? y,
    bool? isLocal,
  }) =>
      AlbumDecoration(
        downloadLink: downloadLink ?? this.downloadLink,
        title: title ?? this.title,
        localPath: localPath ?? this.localPath,
        width: width ?? this.width,
        height: height ?? this.height,
        x: x ?? this.x,
        y: y ?? this.y,
        isLocal: isLocal ?? this.isLocal,
      );
}
