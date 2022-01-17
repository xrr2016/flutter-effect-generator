import '../curve/draw_cruve.dart';

import '../../exports.dart';

void drawAreaChart(
  List<double> list,
  Color color,
  Canvas canvas,
  Size size,
  Paint linePaint,
  double xStep,
  double numUnit,
) {
  linePaint.color = color;
  List<Offset> points = [];

  for (int i = 0; i < list.length; i++) {
    final double dx = xStep * i;
    final double dy = list[i] * numUnit;
    points.add(Offset(dx, -dy));
  }

  final Path linePath = getCurvePath(canvas, points, tension: 0.6);
  canvas.drawPath(linePath, linePaint);

  final areaPaint = Paint()
    ..style = PaintingStyle.fill
    ..strokeWidth = 4.0;
  final Path areaPath = getCurvePath(canvas, points, tension: 0.6);
  areaPaint.color = color.withOpacity(.3);
  areaPath.lineTo(points.last.dx, 0);
  areaPath.lineTo(points.first.dx, 0);
  areaPath.close();
  canvas.drawPath(areaPath, areaPaint);
}
