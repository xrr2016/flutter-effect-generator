import 'dart:math' as math;

import '../models/data_item.dart';
import '../../exports.dart';

final circlePaint = Paint()
  ..style = PaintingStyle.stroke
  ..color = Colors.grey
  ..strokeWidth = 1.0;

final partPaint = Paint()..style = PaintingStyle.fill;

TextPainter _textPainter = TextPainter(
  textDirection: TextDirection.ltr,
  textAlign: TextAlign.end,
);

void drawPieChart(
  List<DataItem>? datas,
  List<Color> theme,
  double paddding,
  Canvas canvas,
  Size size,
) {
  final double sw = size.width;
  final double sh = size.height;
  final double radius = math.min(sw, sh) / 2 - paddding;
  final double maxData =
      datas!.map((DataItem item) => item.value).reduce((a, b) => a + b);

  canvas.save();
  canvas.translate(sw / 2, sh / 2);
  canvas.rotate(-pi / 2);

  for (int i = 0; i < datas.length; i++) {
    Rect rect = Rect.fromCenter(
      center: Offset.zero,
      width: radius * 2,
      height: radius * 2,
    );
    double sweepAngle = pi * 2 * (datas[i].value / maxData);
    canvas.drawArc(rect, 0.0, sweepAngle, true, partPaint..color = theme[i]);
    canvas.drawArc(
      rect,
      0.0,
      sweepAngle,
      true,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.white
        ..strokeWidth = 2.0,
    );
    _drawValues(datas[i].value, sweepAngle, radius, maxData, canvas);
    canvas.rotate(sweepAngle);
  }
  canvas.restore();
}

void _drawValues(
  double value,
  double sweepAngle,
  double radius,
  double maxData,
  Canvas canvas,
) {
  canvas.save();
  canvas.rotate(sweepAngle / 2);
  canvas.translate(radius / 2, 0.0);

  // canvas.drawCircle(
  //   Offset.zero,
  //   4.0,
  //   Paint()..color = Colors.amber,
  // );

  String percent = ((value / maxData * 100).toStringAsFixed(1)) + '%';
  TextSpan text = TextSpan(
    text: percent,
    style: TextStyle(fontSize: 12.0, color: Colors.white),
  );
  _textPainter.text = text;
  _textPainter.layout();
  Size size = _textPainter.size;
  Offset offset = Offset(-size.width / 2, -size.height / 2);
  _textPainter.paint(canvas, offset);
  canvas.restore();
}
