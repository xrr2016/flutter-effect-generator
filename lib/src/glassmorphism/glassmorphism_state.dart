import 'package:flutter/material.dart';

import '../exports.dart';

class GlassmorphismState {
  Color color;
  double blur;
  double width;
  double height;
  double radius;
  double opacity;
  double padding;
  double saturation;
  String code;

  GlassmorphismState({
    this.color = Colors.black12,
    this.blur = 0.0,
    this.width = 0.0,
    this.height = 0.0,
    this.radius = 0.0,
    this.opacity = 0.0,
    this.padding = 0.0,
    this.saturation = 0.0,
    this.code = '',
  });
}
