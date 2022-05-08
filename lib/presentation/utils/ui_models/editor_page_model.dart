import 'package:flutter/material.dart';
import 'package:photo_album/data/models/decoration_element.dart';

class EditorPage {
  final List<AlbumDecoration> elements;
  Widget? backImage;

  EditorPage({
    required this.elements,
    this.backImage,
  });
}
