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

void drawDountChart(
  List<DataItem>? datas,
  List<Color> theme,
  double paddding,
  double dountWidth,
  Canvas canvas,
  Size size,
) {
  final double sw = size.width;
  final double sh = size.height;
  final double radius = math.min(sw, sh) / 2 - paddding;
  final double maxData =
      datas!.map((DataItem item) => item.value).reduce((a, b) => a + b);

  double currentAngle = 0.0;

  Rect rect = Rect.fromCircle(
    radius: radius - dountWidth / 2,
    center: Offset.zero,
  );

  canvas.save();
  canvas.translate(sw / 2, sh / 2);
  canvas.rotate(-pi / 2);

  _drawBackgroudArc(dountWidth, radius, rect, canvas);

  for (int i = 0; i < datas.length; i++) {
    double sweepAngle = pi * 2 * (datas[i].value / maxData);
    currentAngle += sweepAngle;

    canvas.drawArc(
      rect,
      0.0,
      sweepAngle,
      false,
      Paint()
        ..color = theme[i]
        ..strokeWidth = dountWidth
        ..style = PaintingStyle.stroke,
    );

    _drawValues(
      datas[i].value,
      sweepAngle,
      currentAngle,
      radius,
      dountWidth,
      maxData,
      canvas,
    );
    canvas.rotate(sweepAngle);
  }
  canvas.restore();
}

void _drawBackgroudArc(
  double dountWidth,
  double radius,
  Rect rect,
  Canvas canvas,
) {
  Paint paint = Paint()
    ..color = Colors.black12
    ..strokeWidth = dountWidth
    ..style = PaintingStyle.stroke;

  canvas.drawArc(rect, 0.0, pi * 2, false, paint);
}

void _drawValues(
  double value,
  double sweepAngle,
  double currentAngle,
  double radius,
  double dountWidth,
  double maxData,
  Canvas canvas,
) {
  canvas.save();
  canvas.rotate(sweepAngle / 2);
  canvas.translate(radius - dountWidth / 2, 0.0);

  /// 用于绘制水平文字
  canvas.rotate(pi / 2 - (currentAngle - sweepAngle / 2));
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
