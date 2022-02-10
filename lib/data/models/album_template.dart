import 'package:cloud_firestore/cloud_firestore.dart';

class Album {
  final String title;
  final String type;
  final String thumbnailLink;
  final double widthCm;
  final double heightCm;
  final double widthInch;
  final double heightInch;

  Album({
    required this.title,
    required this.thumbnailLink,
    required this.type,
    required this.widthCm,
    required this.heightCm,
    required this.widthInch,
    required this.heightInch,
  });

  factory Album.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> data) => Album(
        title: data['title'],
        type: data['type'],
        thumbnailLink: data['thumbnail_link'],
        widthCm: data['width_cm'],
        heightCm: data['height_cm'],
        widthInch: data['width_inch'],
        heightInch: data['height_inch'],
      );
}
