import 'dart:math';

import 'package:flutter/material.dart';

class ResizeWrapper extends StatefulWidget {
  final Widget child;
  final Size childSize;
  final void Function(double width, double height) onDragEnd;

  const ResizeWrapper({
    Key? key,
    required this.child,
    required this.childSize,
    required this.onDragEnd,
  }) : super(key: key);

  @override
  _ResizeWrapperState createState() => _ResizeWrapperState();
}

const ballDiameter = 30.0;

class _ResizeWrapperState extends State<ResizeWrapper> {
  late double height = widget.childSize.height;
  late double width = widget.childSize.width;

  double top = 0;
  double left = 0;

  void onDrag(double dx, double dy) {
    var newHeight = height + dy;
    var newWidth = width + dx;

    setState(() {
      height = max(0, newHeight);
      width = max(0, newWidth);
    });
    widget.onDragEnd(width, height);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: widget.childSize,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Container(height: height, width: width, child: widget.child),
          ),
          // top left
          Positioned(
            top: 0,
            left: 0,
            child: ManipulatingBall(
              onDrag: (dx, dy) {
                var mid = (dx + dy) / 2;
                var newHeight = height - 2 * mid;
                var newWidth = width - 2 * mid;
                setState(() {
                  height = newHeight > 0 ? newHeight : 0;
                  width = newWidth > 0 ? newWidth : 0;
                  top = top + mid;
                  left = left + mid;
                });
                widget.onDragEnd(width, height);
              },
            ),
          ),
          // top right
          Positioned(
            top: 0,
            right: 0,
            child: ManipulatingBall(
              onDrag: (dx, dy) {
                var mid = (dx + (dy * -1)) / 2;

                var newHeight = height + 2 * mid;
                var newWidth = width + 2 * mid;

                setState(() {
                  height = newHeight > 0 ? newHeight : 0;
                  width = newWidth > 0 ? newWidth : 0;
                  top = top - mid;
                  left = left - mid;
                });
                widget.onDragEnd(width, height);
              },
            ),
          ),
          // bottom right
          Positioned(
            bottom: 0,
            right: 0,
            child: ManipulatingBall(
              onDrag: (dx, dy) {
                var mid = (dx + dy) / 2;

                var newHeight = height + 2 * mid;
                var newWidth = width + 2 * mid;

                setState(() {
                  height = newHeight > 0 ? newHeight : 0;
                  width = newWidth > 0 ? newWidth : 0;
                  top = top - mid;
                  left = left - mid;
                });
                widget.onDragEnd(width, height);
              },
            ),
          ),
          // bottom left
          Positioned(
            bottom: 0,
            left: 0,
            child: ManipulatingBall(
              onDrag: (dx, dy) {
                var mid = ((dx * -1) + dy) / 2;

                var newHeight = height + 2 * mid;
                var newWidth = width + 2 * mid;

                setState(() {
                  height = newHeight > 0 ? newHeight : 0;
                  width = newWidth > 0 ? newWidth : 0;
                  top = top - mid;
                  left = left - mid;
                });
                widget.onDragEnd(width, height);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ManipulatingBall extends StatefulWidget {
  ManipulatingBall({Key? key, required this.onDrag});

  final Function onDrag;

  @override
  _ManipulatingBallState createState() => _ManipulatingBallState();
}

class _ManipulatingBallState extends State<ManipulatingBall> {
  double? initX;
  double? initY;

  _handleDrag(details) {
    setState(() {
      initX = details.globalPosition.dx;
      initY = details.globalPosition.dy;
    });
  }

  _handleUpdate(details) {
    var dx = details.globalPosition.dx - initX;
    var dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    widget.onDrag(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handleDrag,
      onPanUpdate: _handleUpdate,
      child: Container(
        width: ballDiameter,
        height: ballDiameter,
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
