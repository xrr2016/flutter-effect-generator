import 'dart:ui';

import '../../exports.dart';
import '../models/data_item.dart';

class GuageChart extends StatefulWidget {
  const GuageChart({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  final Widget title;
  final List<DataItem> data;

  @override
  _GuageChartState createState() => _GuageChartState();
}

class _GuageChartState extends State<GuageChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GuageChartPainter(
        data: widget.data,
        animation: _controller,
      ),
      child: SizedBox(width: 720.0, height: 480.0),
    );
  }
}

const double _kPiePadding = 20; // 圆边距
const double _kStrokeWidth = 10; // 圆弧宽
const double _kAngle = 270; // 圆弧角度
const int _kMax = 320; // 最大刻度值
const int _kMin = 0; // 最小刻度值
const double _kScaleHeightLever1 = 14; // 短刻度线
const double _kScaleHeightLever2 = 18; // 逢5线
const double _kScaleHeightLever3 = 20; // 逢10线
const double _kScaleDensity = 0.3; // 逢10线
const double _kColorStopRate = 0.2; // 颜色变化分率
const List<Color> _kColors = [
  // 颜色列表
  Colors.green,
  Colors.blue,
  Colors.red,
];

class GuageChartPainter extends CustomPainter {
  final List<DataItem> data;
  final Animation<double> animation;

  GuageChartPainter({
    required this.data,
    required this.animation,
  }) : super(repaint: animation);

  final TextPainter _textPainter = TextPainter(
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.center,
  );
  double value = 150; //指针数值
  double radius = 0; // 圆半径

  Paint fillPaint = Paint(); // 填充画笔
  Paint stokePaint = Paint()
    ..strokeWidth = 1.0
    ..isAntiAlias = true
    ..style = PaintingStyle.stroke; // 线型画笔

  double get initAngle => (360 - _kAngle) / 2;

  void _drawOutline(Canvas canvas) {
    Path path = Path()..moveTo(radius, 0);
    path.arcTo(
        Rect.fromCenter(
            center: Offset.zero, width: radius * 2, height: radius * 2),
        pi / 180 * initAngle,
        pi / 180 * _kAngle,
        true);
    PathMetrics pms = path.computeMetrics();
    stokePaint.strokeWidth = _kStrokeWidth;
    // 通过路径测量绘制三段线
    for (PathMetric pm in pms) {
      canvas.drawPath(pm.extractPath(0, pm.length * _kColorStopRate),
          stokePaint..color = _kColors[0]);
      canvas.drawPath(
          pm.extractPath(
              pm.length * _kColorStopRate, pm.length * (1 - _kColorStopRate)),
          stokePaint..color = _kColors[1]);
      canvas.drawPath(
          pm.extractPath(pm.length * (1 - _kColorStopRate), pm.length),
          stokePaint..color = _kColors[2]);
    }
  }

  void _drawScale(Canvas canvas) {
    canvas.save();
    canvas.rotate(pi / 180 * initAngle);
    double len = 0;
    Color color = Colors.red;
    var count = _kMax * _kScaleDensity; // 格线个数
    for (int i = _kMin; i <= count; i++) {
      if (i % 5 == 0 && i % 10 != 0) {
        len = _kScaleHeightLever2;
      } else if (i % 10 == 0) {
        len = _kScaleHeightLever3;
      } else {
        len = _kScaleHeightLever1;
      }
      if (i < count * _kColorStopRate) {
        color = Colors.green;
      } else if (i < count * (1 - _kColorStopRate)) {
        color = Colors.blue;
      } else {
        color = Colors.red;
      }
      canvas.drawLine(
        Offset(radius + _kStrokeWidth / 2, 0),
        Offset(radius - len, 0),
        stokePaint
          ..color = color
          ..strokeWidth = 2.0,
      );
      canvas.rotate(pi / 180 / _kMax * _kAngle / _kScaleDensity);
    }
    canvas.restore();
  }

  void _drawArrow(Canvas canvas) {
    var nowPer = value / _kMax;
    Color color = Colors.red;
    canvas.save();
    canvas
        .rotate(pi / 180 * (-_kAngle / 2 + nowPer * _kAngle * animation.value));
    Path arrowPath = Path();
    arrowPath.moveTo(0, 28);
    arrowPath.relativeLineTo(-6, -10);
    arrowPath.relativeLineTo(6, -radius + 10);
    arrowPath.relativeLineTo(6, radius - 10);
    arrowPath.close();
    if (nowPer < _kColorStopRate) {
      color = _kColors[0];
    } else if (nowPer < (1 - _kColorStopRate)) {
      color = _kColors[1];
    } else {
      color = _kColors[2];
    }
    canvas.drawPath(arrowPath, fillPaint..color = color);
    canvas.drawCircle(Offset.zero, 3, stokePaint..color = Colors.yellow);
    canvas.drawCircle(Offset.zero, 3, fillPaint..color = Colors.white);
    canvas.restore();
  }

  void _drawAxisText(Canvas canvas, String str,
      {Color color = Colors.black,
      double fontSize = 11,
      FontStyle fontStyle = FontStyle.normal,
      Alignment alignment = Alignment.centerRight,
      FontWeight fontWeight = FontWeight.normal,
      Offset offset = Offset.zero}) {
    TextSpan text = TextSpan(
        text: str,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          color: color,
        ));

    _textPainter.text = text;
    _textPainter.layout(); // 进行布局

    Size size = _textPainter.size;

    Offset offsetPos = Offset(-size.width / 2, -size.height / 2)
        .translate(-size.width / 2 * alignment.x + offset.dx, 0.0 + offset.dy);
    _textPainter.paint(canvas, offsetPos);
  }

  void _drawText(Canvas canvas) {
    // 上方文字
    _drawAxisText(canvas, 'km/s',
        fontSize: 20,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
        alignment: Alignment.center,
        color: Colors.black,
        offset: Offset(0, -radius / 2));
    // 下方文字
    _drawAxisText(canvas, '${value.toStringAsFixed(1)}',
        fontSize: 16,
        alignment: Alignment.center,
        color: Colors.black,
        offset: Offset(0, radius / 2));
    // 周围文字
    int count = (_kMax - _kMin) * _kScaleDensity ~/ 10;
    Color color = Colors.red;
    for (int i = _kMin; i <= count; i++) {
      var thta = pi / 180 * (90 + initAngle + (_kAngle / count) * i);
      if (i < count * _kColorStopRate) {
        color = _kColors[0];
      } else if (i < count * (1 - _kColorStopRate)) {
        color = _kColors[1];
      } else {
        color = _kColors[2];
      }
      Rect rect = Rect.fromLTWH((radius - 40) * cos(thta) - 12,
          (radius - 40) * sin(thta) - 8, 24, 16);
      canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(3)),
          fillPaint..color = color);
      _drawAxisText(canvas, '${i * 10 ~/ _kScaleDensity}',
          fontSize: 11,
          alignment: Alignment.center,
          color: Colors.white,
          offset: Offset((radius - 40) * cos(thta), (radius - 40) * sin(thta)));
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    radius = size.shortestSide / 2 - _kPiePadding; // 当前圆半径
    canvas.translate(size.width / 2, size.height / 2); // 画布原点移至中点
    _drawText(canvas);
    _drawArrow(canvas);
    canvas.rotate(pi / 2);
    _drawOutline(canvas);
    _drawScale(canvas);
  }

  @override
  bool shouldRepaint(GuageChartPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(GuageChartPainter oldDelegate) => false;
}
