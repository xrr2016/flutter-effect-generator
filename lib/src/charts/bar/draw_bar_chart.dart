import '../../exports.dart';

void moveBarChartOrigin(Canvas canvas, Size size, double chartPaddding) {
  canvas.translate(chartPaddding * 3, size.height - chartPaddding * 1.5);
}

void drawBarChartXAxis(
  Canvas canvas,
  Size size,
  List<String> yaxis,
  double chartPaddding,
  Paint gridPaint,
  Function drawAxisText,
) {
  double xStep = (size.width - chartPaddding) / yaxis.length;

  canvas.save();
  for (int i = 0; i < yaxis.length; i++) {
    canvas.drawLine(
      Offset.zero,
      Offset(0, -size.height + chartPaddding * 2),
      gridPaint,
    );
    drawAxisText(canvas, yaxis[i]);
    canvas.translate(xStep, 0.0);
  }
  canvas.restore();
}

void drawBarChartYAxis(
  Canvas canvas,
  Size size,
  List<String> xaxis,
  double chartPaddding,
  Paint gridPaint,
  Function drawAxisText,
) {
  double yStep = (size.height - chartPaddding * 2) / (xaxis.length);

  canvas.save();
  canvas.translate(0.0, -yStep + yStep / 2);
  for (var i = 0; i < xaxis.length; i++) {
    canvas.drawLine(
      Offset.zero,
      Offset(
        -chartPaddding / 3,
        0.0,
      ),
      gridPaint,
    );

    drawAxisText(canvas, xaxis[i], yaxis: true);
    canvas.translate(0.0, -yStep);
  }
  canvas.restore();
}

void drawBarChart(
  List<double> list,
  Color color,
  Canvas canvas,
  Size size,
  double yStep,
  double numUnit,
) {
  final barPaint = Paint()
    ..style = PaintingStyle.fill
    ..color = color;
  final double barHeight = yStep / 2;
  canvas.translate(0.0, -yStep + barHeight / 2);

  for (var i = 0; i < list.length; i++) {
    final double barWidth = list[i] * numUnit;
    final Rect bar = Rect.fromLTWH(
      0.0,
      0.0,
      barWidth,
      barHeight,
    );
    canvas.drawRect(bar, barPaint);
    _drawValueText(
        Offset(barWidth, barHeight), list[i].toString(), color, canvas);
    canvas.translate(0.0, -yStep);
  }
}

TextPainter _textPainter = TextPainter(
  textDirection: TextDirection.ltr,
);

void _drawValueText(
  Offset offset,
  String val,
  Color color,
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
      offset.dx - size.width - size.width / 4,
      offset.dy - size.height - size.height / 4,
    ),
  );
}
