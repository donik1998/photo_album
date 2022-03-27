import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:photo_album/data/models/decoration_element.dart';
import 'package:photo_album/presentation/custom_widgets/custom_icon_button.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';

class RedactorPageElement extends StatelessWidget {
  final DecorationElement child;
  final ValueChanged<File> onCropped;
  final ValueChanged<Offset> onDragged;
  final VoidCallback onDeleted, onScaleDown, onScaleUp;
  final bool hasResizeControls;

  const RedactorPageElement({
    Key? key,
    required this.child,
    required this.hasResizeControls,
    required this.onDragged,
    required this.onScaleDown,
    required this.onScaleUp,
    required this.onCropped,
    required this.onDeleted,
  }) : super(key: key);

  Widget build(BuildContext context) {
    Size childSize = Size(child.width, child.height);
    final childWidget = child.isLocal ? Image.file(File(child.localPath)) : CachedNetworkImage(imageUrl: child.downloadLink);
    return SizedBox.fromSize(
      size: childSize,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              CustomIconButton(
                icon: Icons.delete,
                onTap: onDeleted,
              ),
              CustomIconButton(
                icon: Icons.crop,
                onTap: () => ImageCropper()
                    .cropImage(sourcePath: child.localPath, androidUiSettings: AndroidUiSettings(toolbarTitle: 'Обрезать картинку'))
                    .then((value) {
                  if (value != null) {
                    onCropped(value);
                  }
                }),
              ),
              CustomIconButton(
                icon: Icons.zoom_in,
                onTap: onScaleUp,
              ),
              CustomIconButton(
                icon: Icons.zoom_out,
                onTap: onScaleDown,
              ),
              CustomIconButton(
                icon: Icons.camera,
                onTap: () {},
              ),
              SizedBox(),
            ],
          ),
          AppSpacing.verticalSpace16,
          Draggable<DecorationElement>(
            data: child,
            onDragEnd: (details) => onDragged(Offset(details.offset.dx, details.offset.dy - 50)),
            feedback: Opacity(
              opacity: 0.75,
              child: SizedBox.fromSize(size: childSize, child: childWidget),
            ),
            childWhenDragging: Container(),
            child: SizedBox.fromSize(size: childSize, child: childWidget),
          ),
        ],
      ),
    );
  }
}
