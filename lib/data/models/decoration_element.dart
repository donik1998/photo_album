import 'package:cloud_firestore/cloud_firestore.dart';

class DecorationElement {
  final String thumbnailLink;
  final double height;
  final double width;

  DecorationElement({
    required this.thumbnailLink,
    required this.height,
    required this.width,
  });

  factory DecorationElement.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> data) => DecorationElement(
        thumbnailLink: data['thumbnail_link'],
        height: data['height'],
        width: data['width'],
      );
}
