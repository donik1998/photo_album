import 'dart:ui';

class AlbumDecoration {
  final String downloadLink;
  final String title;
  final String localPath;
  final String fontFamily;
  final double height, width, x, y;
  final int fontSize;
  final bool isLocal;
  final bool isText;

  AlbumDecoration({
    required this.downloadLink,
    this.isLocal = false,
    this.isText = false,
    this.fontFamily = '',
    this.fontSize = 12,
    required this.title,
    this.localPath = '',
    this.height = 0,
    this.width = 0,
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
    required double x,
    required double y,
  }) =>
      AlbumDecoration(
        downloadLink: '',
        title: title,
        localPath: '',
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
        localPath: data['local_path'] ?? '',
        isLocal: data['is_local'] ?? false,
        isText: data['is_text'] ?? false,
        fontFamily: data['font_family'] ?? '',
        fontSize: data['font_size'] ?? 12,
      );

  Map<String, dynamic> get asMap => {
        'download_link': this.downloadLink,
        'height': this.height,
        'width': this.width,
        'x': this.x,
        'y': this.y,
        'title': this.title,
        'local_path': this.localPath,
        'is_text': this.isText,
        'is_local': this.isLocal,
        'font_family': this.fontFamily,
        'font_size': this.fontSize,
      };

  AlbumDecoration copyWith({
    String? downloadLink,
    String? fontFamily,
    String? title,
    String? localPath,
    double? height,
    double? width,
    double? x,
    double? y,
    bool? isLocal,
    bool? isText,
    int? fontSize,
  }) =>
      AlbumDecoration(
        downloadLink: downloadLink ?? this.downloadLink,
        title: title ?? this.title,
        localPath: localPath ?? this.localPath,
        width: width ?? this.width,
        fontFamily: fontFamily ?? this.fontFamily,
        height: height ?? this.height,
        x: x ?? this.x,
        y: y ?? this.y,
        isLocal: isLocal ?? this.isLocal,
        isText: isText ?? this.isText,
        fontSize: fontSize ?? this.fontSize,
      );

  Size get size => Size(width, height);
}
