import 'dart:ui';

import '../../exports.dart';
import '../utils/utils.dart';
import '../utils/create_animated_path.dart';
import '../curve/draw_cruve.dart';
import '../models/data_item.dart';
import '../chart_container.dart';

class AreaChart extends StatefulWidget {
  final Widget title;
  final List<Color> theme;
  final List<List<DataItem>> data;

  AreaChart({
    Key? key,
    required this.title,
    required this.data,
    required this.theme,
  }) : super(key: key);

  @override
  _AreaChartState createState() => _AreaChartState();
}

class _AreaChartState extends State<AreaChart>
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
    return ChartContainer(
      title: widget.title,
      painter: AreaChartPainter(
        data: widget.data,
        animation: _controller,
        theme: widget.theme,
      ),
    );
  }
}

class AreaChartPainter extends CustomPainter {
  final List<List<DataItem>> data;
  final List<Color> theme;
  final Animation<double> animation;
  final double _scaleHeight = 10;
  final TextPainter _textPainter = TextPainter(
    textDirection: TextDirection.ltr,
  );

  AreaChartPainter({
    required this.data,
    required this.theme,
    required this.animation,
  }) : super(repaint: animation) {
    List<double> _datas = [];
    for (int i = 0; i < data.length; i++) {
      List<DataItem> list = data[i];

      for (int j = 0; j < list.length; j++) {
        _datas.add(list[j].value);
      }
    }
    maxData = _datas.reduce(max);
  }

  Paint gridPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.grey
    ..strokeWidth = 0.5;

  final pathPaint = Paint()..style = PaintingStyle.fill;

  final linePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  double xStep = 0; // x 间隔
  double yStep = 0; // y 间隔
  double yStepsHeight = 0.0;
  double maxData = 0.0;

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
        fontWeight: FontWeight.bold,
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

  void _drawLines(List<DataItem> list, Color color, Canvas canvas, Size size) {
    final Path path = Path();
    double maxYNum = getYMaxNum(maxData);
    List<Offset> points = [];

    for (int i = 0; i < list.length; i++) {
      final double dx = xStep * i;
      final double dy =
          (size.height - _scaleHeight - yStep) * (list[i].value / maxYNum);
      points.add(Offset(dx, -dy));

      if (i == 0) {
        path.moveTo(dx, -dy);
      } else {
        path.lineTo(dx, -dy);
      }
    }

    path.lineTo(points.last.dx, 0);
    path.lineTo(points.first.dx, 0);
    path.close();

    pathPaint.color = color.withOpacity(.3);
    canvas.drawPath(path, pathPaint);

    linePaint.color = color;
    final Path linePath = getCurvePath(canvas, points, tension: 0.05);
    canvas.drawPath(createAnimatedPath(linePath, animation.value), linePaint);
  }

  void _drawPoints(List<DataItem> list, Canvas canvas, Size size) {
    double maxYNum = getYMaxNum(maxData);
    double aValue = animation.value;

    canvas.save();
    for (int i = 0; i < data[0].length; i++) {
      const double dx = 0.0;
      final double dy =
          (size.height - _scaleHeight - yStep) * (list[i].value / maxYNum);
      final offset = Offset(dx, -dy);

      _drawAxisText(
        canvas,
        (list[i].value * aValue).toStringAsFixed(0),
        alignment: Alignment.center,
        offset: offset.translate(0.0, -_scaleHeight),
      );
      canvas.translate(xStep, 0.0);
    }
    canvas.restore();
  }

  void _drawXAxis(Canvas canvas, Size size) {
    xStep = (size.width - _scaleHeight) / (data[0].length - 1);

    canvas.save();
    for (int i = 0; i < data[0].length; i++) {
      canvas.drawLine(Offset(0.0, _scaleHeight / 2), Offset.zero, gridPaint);
      _drawDashLine(canvas, size);
      _drawAxisText(
        canvas,
        data[0][i].name,
        alignment: Alignment.center,
        offset: Offset(0, _scaleHeight + 8),
        color: Colors.black54,
      );
      canvas.translate(xStep, 0);
    }
    canvas.restore();
  }

  void _drawYAxis(Canvas canvas, Size size) {
    double maxYNum = getYMaxNum(maxData);
    double numStep = getYStepNum(maxData);
    int steps = 0;
    double c = 0.0;
    yStepsHeight = 0.0;

    while (c < maxYNum) {
      steps++;
      c += numStep;
    }
    yStep = (size.height - _scaleHeight) / (steps + 1);
    canvas.save();
    for (int i = 0; i <= steps; i++) {
      yStepsHeight += -yStep;
      canvas.drawLine(
        Offset.zero,
        Offset(size.width - _scaleHeight, 0.0),
        gridPaint,
      );
      final String str = (numStep * i).toStringAsFixed(0);
      _drawAxisText(
        canvas,
        str,
        offset: Offset(-_scaleHeight - 4, 0),
        color: Colors.black54,
      );
      canvas.translate(0, -yStep);
    }
    canvas.restore();
  }

  void _moveOrigin(Canvas canvas, Size size) {
    canvas.translate(0, size.height);
    canvas.translate(_scaleHeight, -_scaleHeight);
  }

  void _drawDashLine(Canvas canvas, Size size) {
    double step = 6.0;
    double span = 4.0;
    double partLength = step + span;
    Path path = Path()
      ..moveTo(0.0, 0.0)
      ..lineTo(0.0, yStepsHeight + yStep)
      ..fillType = PathFillType.evenOdd;
    PathMetrics pms = path.computeMetrics();

    for (PathMetric pm in pms) {
      int count = pm.length ~/ partLength;
      for (int i = 0; i < count; i++) {
        canvas.drawPath(
          pm.extractPath(partLength * i, partLength * i + step),
          gridPaint,
        );
      }
      double tail = pm.length % partLength;
      canvas.drawPath(pm.extractPath(pm.length - tail, pm.length), gridPaint);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    _moveOrigin(canvas, size);
    _drawXAxis(canvas, size);
    _drawYAxis(canvas, size);

    final _datas = data.reversed.toList();

    _datas.asMap().forEach((int index, List<DataItem> list) {
      Color color = theme[index];
      _drawLines(list, color, canvas, size);
      _drawPoints(list, canvas, size);
    });
  }

  @override
  bool shouldRepaint(AreaChartPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(AreaChartPainter oldDelegate) => false;
}
