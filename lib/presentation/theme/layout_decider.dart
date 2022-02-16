import 'package:flutter/material.dart';

const double kTabletSize = 980.0;
const double kMobileSize = 640.0;
const double kLaptopSize = 1024.0;

abstract class LayoutDecider {
  late Widget mobileLayout, tabletLayout, largeLayout;

  Widget getLayoutFromBoxConstrains(BoxConstraints boxConstraints) {
    if (boxConstraints.maxWidth <= kMobileSize && boxConstraints.maxWidth <= kTabletSize)
      return AnimatedContainer(
        duration: Duration(milliseconds: 250),
        width: boxConstraints.maxWidth,
        height: boxConstraints.maxHeight,
        child: mobileLayout,
      );
    else if (boxConstraints.maxWidth >= kMobileSize && boxConstraints.maxWidth <= kTabletSize)
      return AnimatedContainer(
        duration: Duration(milliseconds: 250),
        width: boxConstraints.maxWidth,
        height: boxConstraints.maxHeight,
        child: tabletLayout,
      );
    else
      return AnimatedContainer(
        duration: Duration(milliseconds: 250),
        width: boxConstraints.maxWidth,
        height: boxConstraints.maxHeight,
        child: largeLayout,
      );
  }
}
