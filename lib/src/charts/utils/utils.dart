import '../../exports.dart';

void drawAxisText(
  Canvas canvas,
  String str, {
  Color color = Colors.black,
  Alignment alignment = Alignment.centerRight,
  Offset offset = Offset.zero,
}) {
  TextPainter _textPainter = TextPainter(
    textDirection: TextDirection.ltr,
  );
  TextSpan text = TextSpan(
    text: str,
    style: TextStyle(
      fontSize: 12,
      color: color,
    ),
  );

  _textPainter.text = text;
  _textPainter.layout(); // 进行布局
  Size size = _textPainter.size;
  Offset offsetPos = Offset(
    -size.width / 2,
    -size.height / 2,
  ).translate(
    -size.width / 2 * alignment.x + offset.dx,
    0.0 + offset.dy,
  );
  _textPainter.paint(canvas, offsetPos);
}
