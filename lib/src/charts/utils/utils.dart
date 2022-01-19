import '../../exports.dart';
import '../models/series.dart';
import '../models/data_item.dart';

TextPainter _textPainter = TextPainter(
  textDirection: TextDirection.ltr,
);

void drawAxisText(
  Canvas canvas,
  String str, {
  Color color = Colors.black,
  Alignment alignment = Alignment.centerRight,
  Offset offset = Offset.zero,
}) {
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

double getYMaxNum(double num) {
  int len = num.toStringAsFixed(0).length;
  double n = pow(10, len).toDouble();
  double h = n / 2;

  if (num > h) {
    return n;
  }

  return h;
}

double getYStepNum(double num) {
  int len = num.toStringAsFixed(0).length;
  return pow(10, len - 1).toDouble();
}

double calcMaxData(List<Series> series) {
  List<double> _datas = [];

  for (int i = 0; i < series.length; i++) {
    List<double> list = series[i].data;

    for (int j = 0; j < list.length; j++) {
      _datas.add(list[j]);
    }
  }

  return _datas.reduce(max);
}

void drawValueText(
  List<double> list,
  List<Offset> points,
  Color color,
  Canvas canvas, {
  double fontSize = 12.0,
}) {
  for (int i = 0; i < points.length; i++) {
    Offset offset = points[i];
    TextSpan text = TextSpan(
      text: list[i].toString(),
      style: TextStyle(fontSize: fontSize, color: color),
    );
    _textPainter.text = text;
    _textPainter.layout();
    Size size = _textPainter.size;
    _textPainter.paint(
      canvas,
      Offset(
        offset.dx - size.width / 2,
        offset.dy - size.height - fontSize / 2,
      ),
    );
  }
}
