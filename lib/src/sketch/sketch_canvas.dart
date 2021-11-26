import 'dart:async';
import 'package:flutter/material.dart';

import './models/line.dart';
import 'sketch_painter.dart';

class SketchCanvas extends StatefulWidget {
  final Color color;
  final double strokeWidth;
  final GlobalKey allPathKey;

  const SketchCanvas({
    Key? key,
    required this.color,
    required this.strokeWidth,
    required this.allPathKey,
  }) : super(key: key);

  @override
  _SketchCanvasState createState() => _SketchCanvasState();
}

class _SketchCanvasState extends State<SketchCanvas> {
  List<Line> lines = [];
  final linesStreamController = StreamController<List<Line>>.broadcast();

  Widget _buildAllPath() {
    return RepaintBoundary(
      child: StreamBuilder<List<Line>>(
        stream: linesStreamController.stream,
        builder: (context, snapshot) {
          return CustomPaint(
            key: widget.allPathKey,
            child: Container(color: Colors.white),
            foregroundPainter: SketchPainter(lines: lines),
          );
        },
      ),
    );
  }

  Line line = Line([], Colors.black, 10.0);
  final currentLineStreamController = StreamController<Line>.broadcast();

  void onPanStart(DragStartDetails details) {
    line = Line([details.localPosition], widget.color, widget.strokeWidth);
    currentLineStreamController.add(line);
  }

  void onPanUpdate(DragUpdateDetails details) {
    final List<Offset> path = List.from(line.path)..add(details.localPosition);
    line = Line(path, widget.color, widget.strokeWidth);

    currentLineStreamController.add(line);
  }

  void onPanEnd(DragEndDetails details) {
    lines = List.from(lines)..add(line);
    linesStreamController.add(lines);
  }

  Widget _buildCurrentPath() {
    return GestureDetector(
      onPanStart: onPanStart,
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      child: RepaintBoundary(
        child: StreamBuilder<Line>(
          stream: currentLineStreamController.stream,
          builder: (context, snapshot) {
            return CustomPaint(
              child: Container(color: Colors.transparent),
              foregroundPainter: SketchPainter(lines: [line]),
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    line = Line([], widget.color, 10.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(0.0, 0.0),
            blurRadius: 30,
            spreadRadius: 0.0,
          ),
        ],
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Stack(
        children: [
          _buildAllPath(),
          _buildCurrentPath(),
        ],
      ),
    );
  }
}
