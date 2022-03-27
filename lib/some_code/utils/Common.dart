import 'package:flutter/material.dart';

extension IntExt on int {
  Size get size => Size(this.toDouble(), this.toDouble());
}
