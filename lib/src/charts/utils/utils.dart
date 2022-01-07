import '../../exports.dart';
import '../models/data_item.dart';

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
    List<DataItem> list = series[i].data;

    for (int j = 0; j < list.length; j++) {
      _datas.add(list[j].value);
    }
  }

  return _datas.reduce(max);
}
