import '../../exports.dart';

void drawColumnChart(
  List<double> list,
  Color color,
  Canvas canvas,
  Size size,
  double xStep,
  double numUnit,
) {
  double barWidth = xStep / 3;
  final barPaint = Paint()
    ..style = PaintingStyle.fill
    ..color = color
    ..strokeWidth = 2.0;

  for (int i = 0; i < list.length; i++) {
    double height = -list[i] * numUnit;
    canvas.drawRect(
      Rect.fromLTWH(-barWidth / 2, 0, barWidth, height),
      barPaint,
    );
    canvas.translate(xStep, 0);
  }
}
