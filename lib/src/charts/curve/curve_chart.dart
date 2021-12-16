import 'dart:ui';

import '../../exports.dart';
import '../utils/create_animated_path.dart';
import './draw_cruve.dart';
import '../models/data_item.dart';
// import './touch_info.dart';

class CurveChart extends StatefulWidget {
  final Widget title;
  final List<DataItem> data;

  CurveChart({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  _CurveChartState createState() => _CurveChartState();
}

class _CurveChartState extends State<CurveChart>
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

  // final TouchInfo touchInfo = TouchInfo();

  // void _onPanDown(DragDownDetails details) {
  //   if (touchInfo.points.length < 8) {
  //     touchInfo.addPoint(details.localPosition);
  //   } else {
  //     judgeZone(details.localPosition);
  //   }
  // }

  // void _onPanUpdate(DragUpdateDetails details) {
  //   judgeZone(details.localPosition, update: true);
  // }

  // ///判断出是否在某点的半径为r圆范围内
  // bool judgeCircleArea(Offset src, Offset dst, double r) =>
  //     (src - dst).distance <= r;

  // //判断哪个点被选中
  // void judgeZone(Offset src, {bool update = false}) {
  //   for (int i = 0; i < touchInfo.points.length; i++) {
  //     if (judgeCircleArea(src, touchInfo.points[i], 15)) {
  //       touchInfo.selectIndex = i;
  //       if (update) {
  //         touchInfo.updatePoint(i, src);
  //       }
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: GestureDetector(
            // onPanDown: _onPanDown,
            // onPanUpdate: _onPanUpdate,
            child: CustomPaint(
              painter: CurveChartPainter(
                data: widget.data,
                animation: _controller,
                // repaint: touchInfo,
              ),
              child: SizedBox(width: 720.0, height: 480.0),
            ),
          ),
        ),
        Align(alignment: Alignment.topCenter, child: widget.title),
      ],
    );
  }
}

class CurveChartPainter extends CustomPainter {
  CurveChartPainter({
    required this.data,
    // required this.repaint,
    required this.animation,
  }) : super(repaint: animation) {
    maxData = data.map((DataItem item) => item.value).reduce(max);
  }
  // final TouchInfo repaint;
  final List<DataItem> data;
  final Animation<double> animation;
  final double _scaleHeight = 10;
  final TextPainter _textPainter = TextPainter(
    textDirection: TextDirection.ltr,
  );

  Paint gridPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.grey
    ..strokeWidth = 0.5;
  final pathPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.blue
    ..isAntiAlias = true
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..strokeWidth = 1.5;

  double xStep = 0; // x 间隔
  double yStep = 0; // y 间隔
  double maxData = 0.0;

  List<Offset> points = [];

  void _drawAxisText(
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

  void _drawLines(Canvas canvas, Size size) {
    double maxYNum = _getYMaxNum(maxData);
    List<Offset> points = [];
    canvas.translate(xStep / 2, 0.0);
    for (int i = 0; i < data.length; i++) {
      final double dx = xStep * i;
      final double dy =
          (size.height - _scaleHeight - yStep) * (data[i].value / maxYNum);
      points.add(Offset(dx, -dy));
    }
    Path path = getCurvePath(
      canvas,
      points,
      tension: .6,
    );
    canvas.drawPath(createAnimatedPath(path, animation.value), pathPaint);
  }

  void _drawPoints(Canvas canvas, Size size) {
    double maxYNum = _getYMaxNum(maxData);
    double aValue = animation.value;

    final paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = Colors.blue;

    canvas.save();
    for (int i = 0; i < data.length; i++) {
      const double dx = 0.0;
      final double dy =
          (size.height - _scaleHeight - yStep) * (data[i].value / maxYNum);
      final offset = Offset(dx, -dy);
      canvas.drawCircle(offset, 4.0, paint);

      double textDy = 0.0;
      if (i == 0) {
        textDy = -_scaleHeight * 2;
      } else {
        textDy = (data[i].value >= data[i - 1].value)
            ? -_scaleHeight * 2
            : _scaleHeight * 2;
      }

      _drawAxisText(
        canvas,
        (data[i].value * aValue).toStringAsFixed(0),
        alignment: Alignment.center,
        offset: offset.translate(0.0, textDy),
      );
      canvas.translate(xStep, 0.0);
    }
    canvas.restore();
  }

  void _drawXAxis(Canvas canvas, Size size) {
    xStep = (size.width - _scaleHeight) / (data.length);

    canvas.save();
    canvas.translate(xStep / 2, 0.0);

    for (int i = 0; i < data.length; i++) {
      canvas.drawLine(Offset(0.0, _scaleHeight / 2), Offset.zero, gridPaint);

      _drawAxisText(
        canvas,
        data[i].name,
        alignment: Alignment.center,
        offset: Offset(0, _scaleHeight + 8),
      );
      canvas.translate(xStep, 0);
    }
    canvas.restore();
  }

  double _getYMaxNum(double num) {
    int len = num.toString().length;
    double n = pow(10, len).toDouble();
    double h = n / 2;

    return num > h ? n : h;
  }

  double _getYStepNum(double num) {
    int len = num.toString().length;

    return pow(10, len - 1).toDouble();
  }

  void _drawYAxis(Canvas canvas, Size size) {
    double maxYNum = _getYMaxNum(maxData);
    double numStep = _getYStepNum(maxData);
    int steps = 0;
    double c = 0.0;

    while (c < maxYNum) {
      steps++;
      c += numStep;
    }

    yStep = (size.height - _scaleHeight) / (steps + 1);
    canvas.save();
    for (int i = 0; i <= steps; i++) {
      canvas.drawLine(
        Offset.zero,
        Offset(size.width - _scaleHeight, 0.0),
        gridPaint,
      );
      final String str = (numStep * i).toStringAsFixed(0);
      _drawAxisText(canvas, str, offset: Offset(-_scaleHeight - 4, 0));
      canvas.translate(0, -yStep);
    }
    canvas.restore();
  }

  void _moveOrigin(Canvas canvas, Size size) {
    canvas.translate(0, size.height);
    canvas.translate(_scaleHeight, -_scaleHeight);
  }

  List<Offset> pos = [];

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    _moveOrigin(canvas, size);
    _drawXAxis(canvas, size);
    _drawYAxis(canvas, size);
    _drawLines(canvas, size);
    _drawPoints(canvas, size);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CurveChartPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(CurveChartPainter oldDelegate) => false;
}
