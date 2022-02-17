import 'dart:io';

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
    this.x = 0,
    this.y = 0,
  });

  factory DecorationElement.fromMap(Map<String, dynamic> data) => DecorationElement(
        downloadLink: data['download_link'],
        title: data['title'],
        height: data['height'],
        width: data['width'],
      );

  bool get isCached => localPath.isNotEmpty;

  Map<String, dynamic> get toMap => {
        'download_link': this.downloadLink,
        'height': this.height,
        'width': this.width,
        'title': this.title,
      };
}

class TextDecorationElement extends DecorationElement {
  final File font;
  final double fontSize;

  TextDecorationElement({
    required String downloadLink,
    required String title,
    required double height,
    required double width,
    required this.font,
    required this.fontSize,
    double x = 0,
    double y = 0,
    String localPath = '',
  }) : super(downloadLink: downloadLink, title: title, height: height, width: width, localPath: localPath, x: x, y: y);
}

class DecorationElementTypes {
  DecorationElementTypes._();

  static const STICKER = 'sticker';
  static const ANIMATION = 'animation';
  static const FONT = 'font';
}
