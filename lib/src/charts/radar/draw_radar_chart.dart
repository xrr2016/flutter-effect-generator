import 'dart:math' as math;

import '../models/series.dart';
import '../../exports.dart';

const double featureLabelFontSize = 10;
const double featureLabelFontWidth = 10;

TextPainter _textPainter = TextPainter(
  textDirection: TextDirection.ltr,
  textAlign: TextAlign.end,
);

Paint outlinePaint = Paint()
  ..color = Color(0xffe8e8e8)
  ..style = PaintingStyle.stroke
  ..strokeWidth = 1.0
  ..isAntiAlias = true;

void drawRadarChart(
  List<Series> series,
  List<String> xaxis,
  List<String> yaxis,
  List<Color> theme,
  double paddding,
  Canvas canvas,
  Size size,
) {
  final double sw = size.width;
  final double sh = size.height;
  final double radius = math.min(sw, sh) / 2 - paddding;
  final double scoreDistance = radius / yaxis.length;
  final double angle = (2 * pi) / xaxis.length;

  canvas.translate(size.width / 2, size.height / 2);

  _drawScores(yaxis, xaxis, angle, scoreDistance, canvas);
  _drawFetures(xaxis, radius, angle, canvas);
  _drawSeries(series, yaxis, xaxis, radius, theme, canvas, size);
}

const double scoreLabelFontSize = 10;

void _drawScores(
  List<String> yaxis,
  List<String> xaxis,
  double angle,
  double scoreDistance,
  Canvas canvas,
) {
  canvas.save();
  yaxis.asMap().forEach(
    (index, score) {
      List<Offset> points = [];
      double scoreRadius = scoreDistance * (index + 1);

      xaxis.asMap().forEach((index, _) {
        double xAngle = cos(angle * index - pi / 2);
        double yAngle = sin(angle * index - pi / 2);
        Offset offset = Offset(scoreRadius * xAngle, scoreRadius * yAngle);
        points.add(offset);
      });
      _drawOutline(points, canvas);

      _textPainter.text = TextSpan(
        text: score,
        style: TextStyle(color: Colors.grey, fontSize: scoreLabelFontSize),
      );
      _textPainter.layout();
      Size size = _textPainter.size;
      _textPainter.paint(
        canvas,
        Offset(-size.width / 2, -scoreRadius - size.height / 3),
      );
    },
  );
  canvas.restore();
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
      text: text,
      style: TextStyle(color: color, fontSize: fontSize),
    ),
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  )
    ..layout(minWidth: 0, maxWidth: size.width)
    ..paint(canvas, offset);
  canvas.restore();
}

void _drawFetures(
  List<String> xaxis,
  double radius,
  double angle,
  Canvas canvas,
) {
  canvas.save();

  for (int i = 0; i < xaxis.length; i++) {
    canvas.drawLine(Offset.zero, Offset(0.0, radius), outlinePaint);

    canvas.save();
    canvas.translate(0.0, radius);
    TextSpan text = TextSpan(
      text: xaxis[i],
      style: TextStyle(fontSize: featureLabelFontSize, color: Colors.grey),
    );
    _textPainter.text = text;
    _textPainter.layout();
    Size size = _textPainter.size;
    Offset offset = Offset.zero;
    canvas.rotate(i * -angle);

    switch (i) {
      case 0:
        offset = Offset(-size.width / 2, 0.0);
        break;
      case 1:
        offset = Offset(-size.width, 0.0);
        break;
      case 2:
        offset = Offset(-size.width, -size.height);
        break;
      case 3:
        offset = Offset(-size.width / 2, -size.height * 1.5);
        break;
      case 4:
        offset = Offset(0.0, -size.height);
        break;
      case 5:
        offset = Offset.zero;
        break;
    }

    _textPainter.paint(canvas, offset);
    canvas.restore();
    canvas.rotate(angle);
  }
  canvas.restore();
}

void _drawOutline(List<Offset> points, Canvas canvas) {
  Path path = Path();
  path.moveTo(points[0].dx, points[0].dy);

  for (int i = 1; i < points.length; i++) {
    path.lineTo(points[i].dx, points[i].dy);
  }
  path.close();
  canvas.drawPath(path, outlinePaint);
}

Paint graphPaint = Paint()..style = PaintingStyle.fill;
Paint graphOutlinePaint = Paint()
  ..style = PaintingStyle.stroke
  ..strokeWidth = 2.0
  ..isAntiAlias = true;
double scoreSize = 12.0;

void _drawSeries(
  List<Series> series,
  List<String> yaxis,
  List<String> xaxis,
  double radius,
  List<Color> theme,
  Canvas canvas,
  Size size,
) {
  double angle = (pi * 2) / xaxis.length;
  double scale = radius / double.parse(yaxis.last);

  series.asMap().forEach(
    (index, graph) {
      Color outLineColor = theme[index];
      graphPaint.color = outLineColor.withOpacity(0.2);
      graphOutlinePaint.color = outLineColor;
      Path path = Path();
      double scaledPoint = -scale * graph.data[0];
      path.moveTo(0.0, scaledPoint);

      _drawRotateText(
        canvas: canvas,
        size: size,
        text: graph.data[0].toString(),
        radius: 0.0,
        fontSize: scoreSize,
        color: outLineColor,
        offset: Offset(0.0, scaledPoint),
      );

      graph.data.sublist(1).asMap().forEach(
        (index, point) {
          double scaledPoint = scale * point;
          double xAngle = cos(angle * (index + 1) - pi / 2);
          double yAngle = sin(angle * (index + 1) - pi / 2);
          double x = scaledPoint * xAngle;
          double y = scaledPoint * yAngle;

          path.lineTo(x, y);
          _drawRotateText(
            canvas: canvas,
            size: size,
            text: point.toString(),
            radius: 0.0,
            fontSize: scoreSize,
            color: outLineColor,
            offset: Offset(x - scoreSize, y),
          );
        },
      );

      path.close();
      canvas.drawPath(path, graphPaint);
      canvas.drawPath(path, graphOutlinePaint);
    },
  );
}
