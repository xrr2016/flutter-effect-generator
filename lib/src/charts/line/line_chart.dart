import '../../exports.dart';
import '../utils/utils.dart';
import '../chart_container.dart';
import '../utils/create_animated_path.dart';
import '../models/data_item.dart';

class LineChart extends StatefulWidget {
  final String title;
  final List<Color> theme;
  final List<List<DataItem>> datas;

  LineChart({
    Key? key,
    required this.title,
    required this.datas,
    required this.theme,
  }) : super(key: key);

  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<LineChart>
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
      title: Row(
        children: [
          SizedBox(width: 20.0),
          Text(
            widget.title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      painter: LineChartPainter(
        datas: widget.datas,
        animation: _controller,
        theme: widget.theme,
      ),
    );
  }
}

class LineChartPainter extends CustomPainter {
  final List<Color> theme;
  final List<List<DataItem>> datas;
  final Animation<double> animation;

  LineChartPainter({
    required this.datas,
    required this.theme,
    required this.animation,
  }) : super(repaint: animation) {
    // maxData = calcMaxData(datas);
    maxYNum = getYMaxNum(maxData);
  }

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
    ..isAntiAlias = true
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..strokeWidth = 1.5;

  double xStep = 0; // x 间隔
  double yStep = 0; // y 间隔
  double maxData = 0.0;
  double maxYNum = 0.0;

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

  void _drawLines(List<DataItem> list, Color color, Canvas canvas, Size size) {
    final path = Path();

    canvas.save();
    canvas.translate(xStep / 2, 0.0);
    for (int i = 0; i < list.length; i++) {
      final double dx = xStep * i;
      final double dy =
          (size.height - _scaleHeight - yStep) * (list[i].value / maxYNum);

      if (i == 0) {
        path.moveTo(dx, -dy);
      } else {
        path.lineTo(dx, -dy);
      }
    }
    pathPaint.color = color;

    canvas.drawPath(createAnimatedPath(path, animation.value), pathPaint);
    canvas.restore();
  }

  void _drawPoints(List<DataItem> list, Color color, Canvas canvas, Size size) {
    double aValue = animation.value;
    final paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = color;

    canvas.save();
    canvas.translate(xStep / 2, 0.0);

    for (int i = 0; i < datas.first.length; i++) {
      const double dx = 0.0;
      final double dy =
          (size.height - _scaleHeight - yStep) * (list[i].value / maxYNum);
      final offset = Offset(dx, -dy);
      canvas.drawCircle(offset, 3.0, paint);

      double textDy = 0.0;
      if (i == 0) {
        textDy = -_scaleHeight * 2;
      } else {
        textDy = (list[i].value >= list[i - 1].value)
            ? -_scaleHeight * 2
            : _scaleHeight * 2;
      }

      _drawAxisText(
        canvas,
        (list[i].value * aValue).toStringAsFixed(0),
        alignment: Alignment.center,
        offset: offset.translate(0.0, textDy),
      );
      canvas.translate(xStep, 0.0);
    }
    canvas.restore();
  }

  void _drawXAxis(Canvas canvas, Size size) {
    xStep = (size.width - _scaleHeight) / datas.first.length - 1;

    canvas.save();
    canvas.translate(xStep / 2, 0.0);

    for (int i = 0; i < datas.first.length; i++) {
      canvas.drawLine(Offset(0.0, _scaleHeight / 2), Offset.zero, gridPaint);

      _drawAxisText(
        canvas,
        datas.first[i].name,
        alignment: Alignment.center,
        offset: Offset(0, _scaleHeight + 8),
      );
      canvas.translate(xStep, 0);
    }
    canvas.restore();
  }

  void _drawYAxis(Canvas canvas, Size size) {
    double numStep = getYStepNum(maxData);
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

  @override
  void paint(Canvas canvas, Size size) {
    _moveOrigin(canvas, size);
    _drawXAxis(canvas, size);
    _drawYAxis(canvas, size);

    final _datas = datas.reversed.toList();
    _datas.asMap().forEach((int index, List<DataItem> list) {
      Color color = theme[index];

      _drawPoints(list, color, canvas, size);
      _drawLines(list, color, canvas, size);
    });
  }

  @override
  bool shouldRepaint(LineChartPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(LineChartPainter oldDelegate) => false;
}
