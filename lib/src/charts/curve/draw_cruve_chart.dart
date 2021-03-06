import '../curve/draw_cruve.dart';
import '../../exports.dart';
import '../utils/utils.dart';

void drawCruveChart(
  List<double> list,
  Color color,
  Canvas canvas,
  Size size,
  Paint linePaint,
  double xStep,
  double numUnit,
) {
  canvas.translate(xStep / 2, 0.0);

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
  drawValueText(list, points, color, canvas);
}
