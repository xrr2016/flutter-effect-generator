import '../../exports.dart';
import '../utils/utils.dart';

void drawLineChart(
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
  final Path path = Path();

  for (int i = 0; i < list.length; i++) {
    final double dx = xStep * i;
    final double dy = -list[i] * numUnit;
    points.add(Offset(dx, dy));

    if (i == 0) {
      path.moveTo(dx, dy);
    } else {
      path.lineTo(dx, dy);
    }
  }

  canvas.drawPath(path, linePaint);
  drawValueText(list, points, color, canvas);
}
