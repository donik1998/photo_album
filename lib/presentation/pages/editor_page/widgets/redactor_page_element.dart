import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:photo_album/data/models/decoration_element.dart';
import 'package:photo_album/presentation/custom_widgets/custom_icon_button.dart';
import 'package:photo_album/presentation/pages/editor_page/photo_editor_page.dart';
import 'package:photo_album/presentation/pages/editor_page/widgets/resize_wrapper.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';

class RedactorPageElement extends StatefulWidget {
  final AlbumDecoration child;
  final ValueChanged<CropData> onCropped;
  final ValueChanged<Offset> onDragged;
  final VoidCallback dragEnded;
  final ValueChanged<Size> onResized;
  final ValueChanged<String> onEdited;
  final VoidCallback onDeleted;
  final bool hideControls;

  const RedactorPageElement({
    Key? key,
    required this.child,
    required this.dragEnded,
    required this.hideControls,
    required this.onEdited,
    required this.onDragged,
    required this.onResized,
    required this.onCropped,
    required this.onDeleted,
  }) : super(key: key);

  @override
  State<RedactorPageElement> createState() => _RedactorPageElementState();
}

class _RedactorPageElementState extends State<RedactorPageElement> {
  double scale = 1;
  bool hasResizeControls = false;
  bool hasTranslateControls = true;
  ImageCropper cropper = ImageCropper();

  late Size childSize = Size(widget.child.width * scale, widget.child.height * scale);
  late Widget childWidget = widget.child.isLocal
      ? Image.file(File(widget.child.localPath))
      : widget.child.isText
          ? Text(
              widget.child.title,
              style: TextStyle(fontFamily: widget.child.fontFamily),
            )
          : CachedNetworkImage(imageUrl: widget.child.downloadLink);
  @override
  initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!widget.hideControls)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomIconButton(
                icon: Icon(Icons.zoom_out_map, color: Colors.white, size: 18),
                onTap: () => setState(() => hasResizeControls = true),
              ),
              AppSpacing.horizontalSpace16,
              CustomIconButton(
                icon: Icon(Icons.crop, color: Colors.white, size: 18),
                onTap: () => cropper.cropImage(sourcePath: File(widget.child.localPath).path).then((value) async {
                  if (value != null) {
                    final image = await decodeImageFromList(await value.readAsBytes());
                    double suitableWidth = 0;
                    double suitableHeight = 0;
                    if (image.height * 0.25 > MediaQuery.of(context).size.height)
                      suitableHeight = image.height * 0.125;
                    else
                      suitableHeight = image.height * 0.25;

                    if (image.width * 0.25 > MediaQuery.of(context).size.width)
                      suitableWidth = image.width * 0.125;
                    else
                      suitableWidth = image.width * 0.25;
                    widget.onCropped(CropData(file: File(value.path), dimensions: Size(suitableWidth, suitableHeight)));
                    setState(() {
                      childWidget = Image.file(File(value.path));
                      childSize = Size(suitableWidth, suitableHeight);
                    });
                  }
                }),
              ),
              AppSpacing.horizontalSpace16,
              CustomIconButton(
                icon: Icon(Icons.filter, color: Colors.white, size: 18),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PhotoEditScreen(
                      file: File(widget.child.localPath),
                    ),
                  ),
                ).then((value) {
                  setState(() {
                    childWidget = Image.file(File(value));
                  });
                  widget.onEdited(value);
                }),
              ),
            ],
          ),
        AppSpacing.verticalSpace16,
        GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              hasResizeControls = false;
            });
            widget.onDragged(details.delta);
          },
          onPanEnd: (details) => widget.dragEnded(),
          child: hasResizeControls
              ? ResizeWrapper(
                  child: childWidget,
                  childSize: childSize,
                  onDragEnd: (width, height) => setState(() => childSize = Size(width, height)),
                )
              : SizedBox.fromSize(
                  size: childSize,
                  child: childWidget,
                ),
        ),
      ],
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
