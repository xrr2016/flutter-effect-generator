import '../curve/draw_cruve.dart';
import '../../exports.dart';

final TextPainter textPainter = TextPainter(
  textDirection: TextDirection.ltr,
);

void drawCruveChart(
  List<double> list,
  Color color,
  Canvas canvas,
  Size size,
  Paint linePaint,
  double xStep,
  double numUnit,
) {
  linePaint.color = color;
  linePaint.isAntiAlias = true;
  List<Offset> points = [];

  for (int i = 0; i < list.length; i++) {
    final double dx = xStep * i;
    final double dy = -list[i] * numUnit;
    points.add(Offset(dx, dy));
  }

  final Path linePath = getCurvePath(canvas, points, tension: 0.6);
  canvas.drawPath(linePath, linePaint);

  _drawValueText(list, points, color, canvas);
}

void _drawValueText(
  List<double> list,
  List<Offset> points,
  Color color,
  Canvas canvas,
) {
  for (int i = 0; i < points.length; i++) {
    Offset offset = points[i];
    TextSpan text = TextSpan(
      text: list[i].toString(),
      style: TextStyle(fontSize: 12, color: color),
    );
    textPainter.text = text;
    textPainter.layout();
    Size size = textPainter.size;

    double textDy = 0.0;
    if (i == 0) {
      textDy = size.height / 2;
    } else {
      textDy = (list[i] >= list[i - 1]) ? -size.height * 1.2 : size.height / 2;
    }

    textPainter.paint(
      canvas,
      Offset(
        offset.dx - size.width / 2,
        offset.dy + textDy,
      ),
    );
  }
}
