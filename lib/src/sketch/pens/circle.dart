import 'dart:ui';
import 'package:flutter/material.dart';

import './pen.dart';

class Circle extends Pen {
  @override
  void draw({
    double x = 0.0,
    double y = 0.0,
    double radius = 20.0,
    Color color = Colors.red,
    Offset offset = Offset.zero,
    PaintingStyle style = PaintingStyle.fill,
  }) {
    Paint paint = Paint()
      ..color = color
      ..style = style;
    // canvas.drawCircle(Offset(x, y), radius, paint);
  }
}
