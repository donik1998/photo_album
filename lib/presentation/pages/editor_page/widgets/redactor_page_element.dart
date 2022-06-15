import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/data/models/decoration_element.dart';
import 'package:photo_album/presentation/pages/editor_page/widgets/resize_wrapper.dart';

class RedactorPageElement extends StatelessWidget {
  final AlbumDecoration decoration;
  final ValueChanged<Offset> onDragged;
  final VoidCallback dragEnded;
  final VoidCallback onTapped;
  final ValueChanged<Size> onResized;
  final bool hasResizeControls;

  const RedactorPageElement({
    Key? key,
    required this.decoration,
    required this.dragEnded,
    required this.onTapped,
    required this.onDragged,
    required this.onResized,
    required this.hasResizeControls,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) => onDragged(details.delta),
      onTap: () => onTapped,
      onPanEnd: (details) => dragEnded(),
      child: hasResizeControls
          ? ResizeWrapper(
              child: decoration.isLocal
                  ? Image.file(File(decoration.localPath))
                  : decoration.isText
                      ? Text(
                          decoration.title,
                          style: TextStyle(fontFamily: decoration.fontFamily),
                        )
                      : CachedNetworkImage(imageUrl: decoration.downloadLink),
              childSize: decoration.size,
              onDragEnd: (width, height) {
                final newSize = Size(width, height);
                onResized(newSize);
              },
            )
          : SizedBox.fromSize(
              size: decoration.size,
              child: decoration.isLocal
                  ? Image.file(File(decoration.localPath))
                  : decoration.isText
                      ? Text(
                          decoration.title,
                          style: TextStyle(fontFamily: decoration.fontFamily),
                        )
                      : CachedNetworkImage(imageUrl: decoration.downloadLink),
            ),
    );
  }
}

class CropData {
  final File file;
  final Size dimensions;

  CropData({
    required this.file,
    required this.dimensions,
  });
}
