import 'dart:io';

class DecorationElement {
  final String downloadLink;
  final String docId;
  final String type;
  final String title;
  final String localPath;
  final double height, width, x, y;

  DecorationElement({
    required this.downloadLink,
    required this.type,
    required this.title,
    this.localPath = '',
    required this.height,
    this.docId = '',
    required this.width,
    this.x = 0,
    this.y = 0,
  });

  factory DecorationElement.fromMap(Map<String, dynamic> data) => DecorationElement(
        downloadLink: data['download_link'],
        title: data['title'],
        height: data['height'],
        width: data['width'],
        type: data['type'],
        docId: data['id'],
      );

  bool get isCached => localPath.isNotEmpty;

  Map<String, dynamic> get toMap => {
        'download_link': this.downloadLink,
        'height': this.height,
        'width': this.width,
        'title': this.title,
        'type': this.type,
      };

  DecorationElement copyWith({
    String? downloadLink,
    String? type,
    String? title,
    double? width,
    double? height,
  }) =>
      DecorationElement(
        docId: this.docId,
        downloadLink: downloadLink ?? this.downloadLink,
        type: type ?? this.type,
        title: title ?? this.title,
        height: height ?? this.height,
        width: width ?? this.width,
      );
}

class TextDecorationElement extends DecorationElement {
  final File font;
  final double fontSize;

  TextDecorationElement({
    required String downloadLink,
    required String title,
    required String docId,
    required double height,
    required double width,
    required this.font,
    required this.fontSize,
    double x = 0,
    double y = 0,
    String localPath = '',
  }) : super(
          docId: docId,
          downloadLink: downloadLink,
          title: title,
          height: height,
          width: width,
          localPath: localPath,
          x: x,
          y: y,
          type: DecorationElementTypes.FONT,
        );
}

class DecorationElementTypes {
  DecorationElementTypes._();

  static const STICKER = 'sticker';
  static const ANIMATION = 'animation';
  static const FONT = 'font';
}
