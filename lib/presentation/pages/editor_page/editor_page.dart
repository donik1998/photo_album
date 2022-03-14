import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:matrix4_transform/matrix4_transform.dart';
import 'package:photo_album/data/models/decoration_element.dart';
import 'package:photo_album/presentation/pages/editor_page/widgets/elements_sheet.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/different_icons.dart';
import 'package:photo_album/presentation/utils/routes.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class RedactorPage extends StatefulWidget {
  RedactorPage({Key? key}) : super(key: key);

  @override
  State<RedactorPage> createState() => _RedactorPageState();
}

class _RedactorPageState extends State<RedactorPage> {
  ScrollController scrollController = ScrollController();
  List<DecorationElement> elements = List.empty(growable: true);
  int _selectedItemElement = 0;

  bool fabIsVisible = true;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      // if (scrollController.offset < -100) ;
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as RedactorPageArgs;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              MyFlutterApp.dot_2,
              color: Color(0xFF2E2E2E),
              size: 24,
            ),
            onPressed: () {},
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              MyFlutterApp.cloud_download,
              color: Color(0xFF2E2E2E),
              size: 24,
            ),
          ),
          IconButton(
            icon: Icon(
              MyFlutterApp.upload,
              color: Color(0xFF2E2E2E),
              size: 24,
            ),
            onPressed: () {},
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              MyFlutterApp.popup,
              color: Color(0xFF2E2E2E),
              size: 24,
            ),
          ),
        ],
      ),
      body: DragTarget<DecorationElement>(
        onAccept: (element) {
          setState(() {
            final elementIndex = elements.indexOf(element);
            if (elementIndex.isNegative) {
              elements.remove(element);
              elements.add(element);
            } else {
              elements.removeAt(elementIndex);
              elements.insert(elementIndex, element);
            }
          });
        },
        builder: (context, acceptedChildren, rejectedChildren) => Stack(
          fit: StackFit.passthrough,
          children: [
            if (args.backImage != null)
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  width: 366,
                  height: 570,
                  decoration: BoxDecoration(),
                  child: args.backImage,
                ),
              ),
            for (final element in elements)
              Positioned(
                top: element.y,
                left: element.x,
                child: AnimatedRedactorPageElement(
                  element: element,
                  notifier: ValueNotifier<ElementConditions>(
                    ElementConditions(
                      angle: 0,
                      size: Size(element.width, element.height),
                      position: Offset(element.x, element.y),
                    ),
                  ),
                ),
                // RedactorPageElement(
                //   child: element,
                //   onDragged: (newOffset) => setState(() {
                //     print(newOffset);
                //     final renderBox = context.findRenderObject() as RenderBox;
                //     Offset off = renderBox.globalToLocal(newOffset);
                //     final elementIndex = elements.indexOf(element);
                //     elements.removeAt(elementIndex);
                //     elements.insert(elementIndex, element.copyWith(x: off.dx, y: off.dy));
                //   }),
                // ),
              ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: fabIsVisible,
        child: FloatingActionButton(
          backgroundColor: AppColors.pinkLight,
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            setState(() {
              fabIsVisible = false;
            });
            showModalBottomSheet(
              context: context,
              elevation: 10,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (context) => SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ElementsSheet(
                  controller: scrollController,
                  albumPageTemplateCategory: args.albumPageTemplateCategories,
                  decorationCategories: args.decorationCategories,
                ),
              ),
            ).then((value) {
              if (value is DecorationElement) elements.add(value);
              setState(() => fabIsVisible = true);
            });
          },
        ),
      ),
    );
  }
}

class AnimatedRedactorPageElement extends StatelessWidget {
  final DecorationElement element;
  final ValueNotifier<ElementConditions> notifier;
  const AnimatedRedactorPageElement({
    Key? key,
    required this.element,
    required this.notifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: notifier,
      builder: (context, child) => AnimatedContainer(
        duration: Duration(milliseconds: 250),
        height: notifier.value.size.height,
        width: notifier.value.size.width,
        transform: Matrix4Transform()
            .rotateDegrees(
              notifier.value.angle,
              origin: Offset(notifier.value.size.width * 0.5, notifier.value.size.height * 0.5),
            )
            .matrix4,
        transformAlignment: Alignment.center,
        child: child,
      ),
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          final renderBox = context.findRenderObject() as RenderBox;
          Offset off = renderBox.globalToLocal(details.localPosition);
          notifier.value = notifier.value.copyWith(position: off);
        },
        onHorizontalDragUpdate: (details) {
          final renderBox = context.findRenderObject() as RenderBox;
          Offset off = renderBox.globalToLocal(details.localPosition);
          notifier.value = notifier.value.copyWith(position: off);
        },
        onScaleUpdate: (details) => notifier.value = notifier.value.copyWith(size: notifier.value.size * details.scale),
        child: SizedBox.fromSize(
          size: Size(element.width, element.height),
          child: element.isLocal ? Image.file(File(element.localPath)) : CachedNetworkImage(imageUrl: element.downloadLink),
        ),
      ),
    );
  }
}

class ElementConditions {
  final Offset position;
  final Size size;
  final double angle;

  ElementConditions({
    required this.position,
    required this.size,
    required this.angle,
  });
  ElementConditions copyWith({Offset? position, Size? size, double? angle}) => ElementConditions(
        position: position ?? this.position,
        size: size ?? this.size,
        angle: angle ?? this.angle,
      );
}

class RedactorPageElement extends StatefulWidget {
  final DecorationElement child;
  final ValueChanged<Offset> onDragged;

  const RedactorPageElement({
    Key? key,
    required this.child,
    required this.onDragged,
  }) : super(key: key);

  @override
  State<RedactorPageElement> createState() => _RedactorPageElementState();
}

class _RedactorPageElementState extends State<RedactorPageElement> {
  double _scale = 1;
  late Size childSize = Size(widget.child.width, widget.child.height);

  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: Duration(milliseconds: 500),
      scale: _scale,
      child: SizedBox.fromSize(
        size: childSize,
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            Draggable<DecorationElement>(
              data: widget.child,
              onDragEnd: (details) => widget.onDragged(Offset(details.offset.dx, details.offset.dy)),
              feedback: Opacity(
                opacity: 0.75,
                child: SizedBox.fromSize(
                  size: childSize,
                  child: widget.child.isLocal
                      ? Image.file(File(widget.child.localPath))
                      : CachedNetworkImage(imageUrl: widget.child.downloadLink),
                ),
              ),
              childWhenDragging: Container(),
              child: SizedBox.fromSize(
                size: childSize,
                child: widget.child.isLocal
                    ? Image.file(File(widget.child.localPath))
                    : CachedNetworkImage(
                        imageUrl: widget.child.downloadLink,
                      ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () => setState(() {
                  _scale += 0.5;
                  childSize = Size(widget.child.width * _scale, widget.child.height * _scale);
                }),
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.zoom_out_map, color: AppColors.white, size: 10),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: GestureDetector(
                onScaleEnd: (details) {
                  print(details.velocity.pixelsPerSecond.distance);
                },
                onTap: () => setState(() {
                  if (_scale > 0.5) _scale -= 0.5;
                  childSize = Size(widget.child.width * _scale, widget.child.height * _scale);
                }),
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(color: AppColors.black, shape: BoxShape.circle),
                  child: Icon(Icons.zoom_in_map, color: AppColors.white, size: 10),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
