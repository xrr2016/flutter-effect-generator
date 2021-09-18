import 'dart:ui' as ui;

import '../exports.dart';

List<Color> colors = [
  Colors.transparent,
  Colors.green,
  Colors.green,
  Colors.white
];

List<double> pos = [0.0, 0.5, 0.8, 1.0];

class MatrixPainter extends CustomPainter {
  final List<String> _texts = [
    'TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST1',
    'TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST2',
    'TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST3',
    'TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST4',
    'TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST5',
    'TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST6',
  ];

  _drawTextLine(Canvas canvas, Size size, String text) {
    canvas.save();
    canvas.translate(Random().nextDouble() * size.width, 0.0);
    canvas.rotate(pi / 2);

    final Shader linearGradient = LinearGradient(
      colors: colors,
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).createShader(
      Rect.fromLTWH(0, 0, size.width, size.height),
    );
    Paint foreground = Paint()..shader = linearGradient;

    TextStyle textStyle = TextStyle(
      fontSize: 20.0,
      foreground: foreground,
    );

    TextPainter(
      text: TextSpan(
        text: text,
        style: textStyle,
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    )
      ..layout()
      ..paint(canvas, Offset.zero);

    canvas.restore();
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < _texts.length; i++) {
      _drawTextLine(canvas, size, _texts[i]);
    }
  }

  @override
  bool shouldRepaint(MatrixPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(MatrixPainter oldDelegate) => false;
}
