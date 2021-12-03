import '../../exports.dart';

Path getCurvePath(Canvas canvas, List<Offset> points, {double tension = 1}) {
  Path path = Path();
  path.moveTo(points[0].dx, points[0].dy);
  for (int i = 0; i < points.length - 1; i++) {
    Offset p0 = i > 0 ? points[i - 1] : points[0];
    Offset p1 = points[i];
    Offset p2 = points[i + 1];
    Offset p3 = i != points.length - 2 ? points[i + 2] : p2;
    double cp1x = p1.dx + ((p2.dx - p0.dx) / 6) * tension;
    double cp1y = p1.dy + ((p2.dy - p0.dy) / 6) * tension;
    double cp2x = p2.dx - ((p3.dx - p1.dx) / 6) * tension;
    double cp2y = p2.dy - ((p3.dy - p1.dy) / 6) * tension;
    path.cubicTo(cp1x, cp1y, cp2x, cp2y, p2.dx, p2.dy);
  }

  return path;
}
