import 'package:flutter/material.dart';

import './models/line.dart';
import 'utils.dart';

class SketchPainter extends CustomPainter {
  final List<Line> lines;

  SketchPainter({
    required this.lines,
  });

  @override
  void paint(Canvas canvas, Size size) {
    image(canvas, size, image: 'assets/images/lgz.jpg');
  }

  @override
  bool shouldRepaint(SketchPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(SketchPainter oldDelegate) => false;
}
