import '../../exports.dart';
import '../models/data_item.dart';

class ColumnChart extends StatefulWidget {
  final List<DataItem> datas;
  final Widget title;

  ColumnChart({
    Key? key,
    required this.title,
    required this.datas,
  }) : super(key: key);

  @override
  _ColumnChartState createState() => _ColumnChartState();
}

class _ColumnChartState extends State<ColumnChart>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: CustomPaint(
            painter: ColumnChartPainter(
              datas: widget.datas,
              animation: _controller,
            ),
            child: SizedBox(width: 480.0, height: 480.0),
          ),
        ),
        Align(alignment: Alignment.topCenter, child: widget.title),
      ],
    );
  }
}

class ColumnChartPainter extends CustomPainter {
  ColumnChartPainter({
    required this.datas,
    required this.animation,
  }) : super(repaint: animation) {
    maxData = datas.map((DataItem item) => item.value).reduce(max);
  }

  final List<DataItem> datas;
  final Animation<double> animation;
  final double _scaleHeight = 10;
  final TextPainter _textPainter = TextPainter(
    textDirection: TextDirection.ltr,
  );

  Path axisPath = Path();
  Paint axisPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;
  Paint gridPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.grey
    ..strokeWidth = 0.5;
  Paint barPaint = Paint()..color = Colors.blue;

  double xStep = 0; // x 间隔
  double yStep = 0; // y 间隔
  double maxData = 0.0;

  void _drawAxis(Canvas canvas, Size size) {
    canvas.translate(0, size.height);
    canvas.translate(_scaleHeight, -_scaleHeight);
    axisPath.moveTo(-_scaleHeight, 0);
    axisPath.relativeLineTo(size.width, 0);
    axisPath.moveTo(0, _scaleHeight);
    axisPath.relativeLineTo(0, -size.height);
    canvas.drawPath(axisPath, axisPaint..color);
  }

  // void _drawLabels(Canvas canvas, Size size) {}

  // void _drawLegend(Canvas canvas, Size size) {}

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

  void _drawYText(Canvas canvas, Size size) {
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
    _drawAxisText(canvas, '0', offset: Offset(-_scaleHeight - 4, 0));
    canvas.translate(0, -yStep);
    for (int i = 1; i <= steps + 1; i++) {
      if (i == steps + 1) {
        canvas.drawLine(Offset(-_scaleHeight, 0), Offset.zero, axisPaint);
        continue;
      }
      canvas.drawLine(Offset(-_scaleHeight, 0), Offset.zero, axisPaint);
      final String str = (numStep * i).toStringAsFixed(0);
      _drawAxisText(canvas, str, offset: Offset(-_scaleHeight - 4, 0));
      canvas.translate(0, -yStep);
    }
    canvas.restore();
  }

  void _drawXText(Canvas canvas, Size size) {
    xStep = (size.width - _scaleHeight) / (datas.length + 1);

    canvas.save();
    canvas.translate(xStep, 0);
    for (int i = 0; i <= datas.length; i++) {
      if (i == datas.length) {
        canvas.drawLine(Offset.zero, Offset(0, _scaleHeight), axisPaint);
        continue;
      }
      canvas.drawLine(Offset.zero, Offset(0, _scaleHeight), axisPaint);
      _drawAxisText(
        canvas,
        datas[i].name,
        alignment: Alignment.center,
        offset: Offset(0, _scaleHeight + 8),
      );
      canvas.translate(xStep, 0);
    }
    canvas.restore();
  }

  void _drawBars(Canvas canvas, Size size) {
    double maxYNum = _getYMaxNum(maxData);
    double barWidth = xStep / 2;
    double aValue = animation.value;

    canvas.save();
    canvas.translate(xStep, 0);
    for (int i = 0; i < datas.length; i++) {
      double height =
          ((size.height - _scaleHeight - yStep) * (datas[i].value) / maxYNum) *
              aValue;
      canvas.drawRect(
        Rect.fromLTWH(0, -1, barWidth, -height).translate(-barWidth / 2, 0),
        barPaint,
      );
      _drawAxisText(
        canvas,
        (datas[i].value * aValue).toStringAsFixed(0),
        alignment: Alignment.center,
        offset: Offset(0, -height - _scaleHeight),
      );
      canvas.translate(xStep, 0);
    }
    canvas.restore();
  }

  @override
  void paint(Canvas canvas, Size size) {
    _drawAxis(canvas, size);
    _drawYText(canvas, size);
    _drawXText(canvas, size);
    _drawBars(canvas, size);
  }

  @override
  bool shouldRepaint(ColumnChartPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(ColumnChartPainter oldDelegate) => false;
}
