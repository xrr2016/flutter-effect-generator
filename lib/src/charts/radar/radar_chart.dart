import 'dart:math';
import 'package:flutter/material.dart';

import '../chart_container.dart';
import '../colors.dart';
import '../models/data_item.dart';
import '../utils/create_animated_path.dart';

class RadarChart extends StatefulWidget {
  final Widget title;
  final List<double> scores;
  final List<String> features;
  final List<List<DataItem>> datas;

  RadarChart({
    Key? key,
    required this.title,
    required this.datas,
    required this.scores,
    required this.features,
  }) : super(key: key);

  @override
  _RadarChartState createState() => _RadarChartState();
}

class _RadarChartState extends State<RadarChart> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChartContainer(
      title: widget.title,
      painter: RadarChartPainter(
        datas: widget.datas,
        scores: widget.scores,
        features: widget.features,
        animation: _controller,
      ),
      legend: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          widget.datas.length,
          (index) => Container(
            width: 50.0,
            height: 22.0,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            color: colors1[index % colors1.length],
            alignment: Alignment.center,
            child: Text(
              widget.datas[index].first.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RadarChartPainter extends CustomPainter {
  final List<String> features;
  final List<double> scores;
  final List<List<DataItem>> datas;
  final Animation<double> animation;

  RadarChartPainter({
    required this.scores,
    required this.datas,
    required this.features,
    required this.animation,
  }) : super(repaint: animation);

  double _radius = 0.0;
  double _scoreDistance = 0.0;

  void _initChart(Canvas canvas, Size size) {
    _radius = min(size.width, size.height) / 2 - 40.0;
    _scoreDistance = _radius / scores.length;
    canvas.translate(size.width / 2, size.height / 2);
  }

  void _drawOutline(Canvas canvas, Size size) {
    Paint outlinePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..isAntiAlias = true;

    canvas.drawCircle(Offset.zero, _radius, outlinePaint);
  }

  Paint scoresPaint = Paint()
    ..color = Colors.grey
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0
    ..isAntiAlias = true;

  void _drawScores(Canvas canvas, Size size) {
    double scoreLabelFontSize = 10;

    scores.asMap().forEach(
      (index, score) {
        double scoreRadius = _scoreDistance * (index + 1);

        if (index.isEven) {
          canvas.drawArc(
            Rect.fromCircle(
              center: Offset.zero,
              radius: scoreRadius - _scoreDistance / 2,
            ),
            0.0,
            pi * 2,
            false,
            Paint()
              ..color = Colors.white70
              ..strokeWidth = _scoreDistance
              ..style = PaintingStyle.stroke,
          );
        } else {
          canvas.drawCircle(Offset.zero, scoreRadius, scoresPaint);
        }

        TextPainter(
          text: TextSpan(
            text: score.toString(),
            style: TextStyle(color: Colors.grey, fontSize: scoreLabelFontSize),
          ),
          textDirection: TextDirection.ltr,
        )
          ..layout(minWidth: 0, maxWidth: size.width)
          ..paint(
            canvas,
            Offset(
              -scoreLabelFontSize,
              -scoreRadius - scoreLabelFontSize,
            ),
          );
      },
    );
  }

  void _drawRotateText({
    required Canvas canvas,
    required Size size,
    required String text,
    required Offset offset,
    required double radius,
    Color color = Colors.black,
    double fontSize = 12.0,
  }) {
    canvas.save();
    canvas.rotate(radius);

    TextPainter(
      text: TextSpan(
        style: TextStyle(
          color: color,
          fontSize: fontSize,
        ),
        text: text,
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )
      ..layout(minWidth: 0, maxWidth: size.width)
      ..paint(canvas, offset);
    canvas.restore();
  }

  void _drawFetures(Canvas canvas, Size size) {
    double angle = (2 * pi) / features.length;
    const double featureLabelFontSize = 14;
    const double featureLabelFontWidth = 12;

    features.asMap().forEach(
      (index, feature) {
        double xAngle = cos(angle * index - pi / 2);
        double yAngle = sin(angle * index - pi / 2);

        Offset featureOffset = Offset(
          _radius * xAngle,
          _radius * yAngle,
        );

        Paint linePaint = Paint()
          ..color = Colors.grey
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0
          ..isAntiAlias = true;

        canvas.drawLine(Offset.zero, featureOffset, linePaint);

        double labelYOffset =
            yAngle < 0 ? -featureLabelFontSize * 2.5 : featureLabelFontSize * 2;
        double labelXOffset = xAngle < 0
            ? -featureLabelFontWidth * (feature.length + 1)
            : -featureLabelFontWidth / 1.5;

        _drawRotateText(
          canvas: canvas,
          size: size,
          text: feature,
          radius: 0.0,
          fontSize: featureLabelFontSize,
          offset: Offset(
            featureOffset.dx + labelXOffset,
            featureOffset.dy + labelYOffset,
          ),
        );
      },
    );
  }

  void _drawDatas(Canvas canvas, Size size) {
    double angle = (2 * pi) / features.length;
    double scale = _radius / scores.last;

    datas.asMap().forEach(
      (index, graph) {
        Paint graphPaint = Paint()
          ..color = colors1[index % colors1.length].withOpacity(0.2)
          ..style = PaintingStyle.fill;
        Color outLineColor = colors1[index % colors1.length];
        Paint graphOutlinePaint = Paint()
          ..color = outLineColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0
          ..isAntiAlias = true;

        Path path = Path();
        double scoreSize = 12.0;
        double scaledPoint = -scale * graph[0].value;
        path.moveTo(0.0, scaledPoint);

        _drawRotateText(
          canvas: canvas,
          size: size,
          text: graph[0].value.toString(),
          radius: 0.0,
          fontSize: scoreSize,
          color: outLineColor,
          offset: Offset(0.0, scaledPoint),
        );

        graph.sublist(1).asMap().forEach(
          (index, point) {
            double scaledPoint = scale * point.value;
            double xAngle = cos(angle * (index + 1) - pi / 2);
            double yAngle = sin(angle * (index + 1) - pi / 2);
            double x = scaledPoint * xAngle;
            double y = scaledPoint * yAngle;

            path.lineTo(x, y);
            _drawRotateText(
              canvas: canvas,
              size: size,
              text: point.value.toString(),
              radius: 0.0,
              fontSize: scoreSize,
              color: outLineColor,
              offset: Offset(x - scoreSize, y),
            );
          },
        );

        path.close();
        canvas.drawPath(
          createAnimatedPath(path, animation.value),
          graphPaint,
        );
        canvas.drawPath(
          createAnimatedPath(path, animation.value),
          graphOutlinePaint,
        );
      },
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    _initChart(canvas, size);
    _drawOutline(canvas, size);
    _drawScores(canvas, size);
    _drawFetures(canvas, size);
    _drawDatas(canvas, size);
  }

  @override
  bool shouldRepaint(RadarChartPainter oldDelegate) => true;
}
