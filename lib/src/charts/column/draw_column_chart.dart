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
  canvas.translate(xStep / 2, 0.0);
  for (int i = 0; i < list.length; i++) {
    double left = -barWidth / 2;
    double height = -list[i] * numUnit;
    canvas.drawRect(
      Rect.fromLTWH(left, 0, barWidth, height),
      barPaint,
    );
    _drawValueText(Offset(left, height), list[i].toString(), canvas);
    canvas.translate(xStep, 0);
  }
}

TextPainter _textPainter = TextPainter(
  textDirection: TextDirection.ltr,
);

void _drawValueText(
  Offset offset,
  String val,
  Canvas canvas, {
  double fontSize = 12.0,
}) {
  TextSpan text = TextSpan(
    text: val,
    style: TextStyle(
      fontSize: fontSize,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  );
  _textPainter.text = text;
  _textPainter.layout();
  Size size = _textPainter.size;
  _textPainter.paint(
    canvas,
    Offset(
      offset.dx,
      offset.dy + size.height / 2,
    ),
  );
}
