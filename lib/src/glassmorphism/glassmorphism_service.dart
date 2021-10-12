import 'package:flutter/material.dart';

import '../exports.dart';

class GlassmorphismService {
  Color color;
  double width;
  double height;
  double blur;
  double opacity;
  double radius;
  String code;

  GlassmorphismService({
    this.color = Colors.white,
    this.width = 360.0,
    this.height = 520.0,
    this.blur = 10.0,
    this.opacity = 0.2,
    this.radius = 12.0,
    this.code = '',
  });
}
