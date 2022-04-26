import 'dart:math';

import 'package:flutter/material.dart';

class ImageFilterWidget extends StatelessWidget {
  final double? brightness;
  final double? saturation;
  final double? hue;
  final double? contrast;
  final Widget? child;

  ImageFilterWidget({this.brightness, this.saturation, this.hue, this.contrast, this.child});

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: brightness != 0.0
          ? ColorFilter.matrix(ColorFilterGenerator.brightnessAdjustMatrix(value: brightness!))
          : ColorFilter.mode(Colors.transparent, BlendMode.srcATop),
      child: ColorFiltered(
        colorFilter: saturation != 0.0
            ? ColorFilter.matrix(ColorFilterGenerator.saturationAdjustMatrix(value: saturation!))
            : ColorFilter.mode(Colors.transparent, BlendMode.srcATop),
        child: ColorFiltered(
          colorFilter: hue != 0.0
              ? ColorFilter.matrix(ColorFilterGenerator.hueAdjustMatrix(value: hue!))
              : ColorFilter.mode(Colors.transparent, BlendMode.srcATop),
          child: ColorFiltered(
            colorFilter: contrast != 0.0
                ? ColorFilter.matrix(ColorFilterGenerator.contrastAdjustMatrix(value: contrast!))
                : ColorFilter.mode(Colors.transparent, BlendMode.srcATop),
            child: child,
          ),
        ),
      ),
    );
  }
}

class ColorFilterGenerator {
  static List<double> hueAdjustMatrix({required double value}) {
    value = value * pi;
    if (value == 0) return [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
    double cosVal = cos(value);
    double sinVal = sin(value);
    double lumR = 0.213;
    double lumG = 0.715;
    double lumB = 0.072;
    return List<double>.from(<double>[
      (lumR + (cosVal * (1 - lumR))) + (sinVal * (-lumR)),
      (lumG + (cosVal * (-lumG))) + (sinVal * (-lumG)),
      (lumB + (cosVal * (-lumB))) + (sinVal * (1 - lumB)),
      0,
      0,
      (lumR + (cosVal * (-lumR))) + (sinVal * 0.143),
      (lumG + (cosVal * (1 - lumG))) + (sinVal * 0.14),
      (lumB + (cosVal * (-lumB))) + (sinVal * (-0.283)),
      0,
      0,
      (lumR + (cosVal * (-lumR))) + (sinVal * (-(1 - lumR))),
      (lumG + (cosVal * (-lumG))) + (sinVal * lumG),
      (lumB + (cosVal * (1 - lumB))) + (sinVal * lumB),
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]).map((i) => i.toDouble()).toList();
  }

  static List<double> brightnessAdjustMatrix({required double value}) {
    if (value <= 0)
      value = value * 255;
    else
      value = value * 100;
    if (value == 0) return [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
    return List<double>.from(<double>[1, 0, 0, 0, value, 0, 1, 0, 0, value, 0, 0, 1, 0, value, 0, 0, 0, 1, 0])
        .map((i) => i.toDouble())
        .toList();
  }

  static List<double> contrastAdjustMatrix({required double value}) {
    value = 1 + value;
    if (value == 0) return [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
    return List<double>.from(<double>[value, 0, 0, 0, 1, 0, value, 0, 0, 1, 0, 0, value, 0, 1, 0, 0, 0, 1, 0])
        .map((i) => i.toDouble())
        .toList();
  }

  static List<double> saturationAdjustMatrix({required double value}) {
    value = value * 100;
    if (value == 0) return [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
    double x = ((1 + ((value > 0) ? ((3 * value) / 100) : (value / 100)))).toDouble();
    double lumR = 0.3086;
    double lumG = 0.6094;
    double lumB = 0.082;
    return List<double>.from(<double>[
      (lumR * (1 - x)) + x,
      lumG * (1 - x),
      lumB * (1 - x),
      0,
      0,
      lumR * (1 - x),
      (lumG * (1 - x)) + x,
      lumB * (1 - x),
      0,
      0,
      lumR * (1 - x),
      lumG * (1 - x),
      (lumB * (1 - x)) + x,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]).map((i) => i.toDouble()).toList();
  }
}
