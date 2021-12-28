import '../../exports.dart';
import '../chart_container.dart';
import '../models/data_item.dart';

class ColumnChart extends StatefulWidget {
  ColumnChart({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  final Widget title;
  final List<DataItem> data;

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
    return ChartContainer(
      title: widget.title,
      painter: ColumnChartPainter(
        data: widget.data,
        animation: _controller,
      ),
    );
  }
}

class ColumnChartPainter extends CustomPainter {
  ColumnChartPainter({
    required this.data,
    required this.animation,
  }) : super(repaint: animation) {
    maxData = data.map((DataItem item) => item.value).reduce(max);
  }

  final List<DataItem> data;
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

  void _moveOrigin(Canvas canvas, Size size) {
    canvas.translate(0, size.height);
    canvas.translate(_scaleHeight, -_scaleHeight);
  }

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
        Offset(size.width - _scaleHeight, 0),
        gridPaint,
      );
      final String str = (numStep * i).toStringAsFixed(0);
      _drawAxisText(canvas, str, offset: Offset(-_scaleHeight - 4, 0));
      canvas.translate(0, -yStep);
    }
    canvas.restore();
  }

  void _drawXAxis(Canvas canvas, Size size) {
    xStep = (size.width - _scaleHeight) / (data.length);

    canvas.save();
    canvas.translate(xStep / 2, 0);
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

  void _drawBars(Canvas canvas, Size size) {
    double barWidth = xStep / 2;
    double maxYNum = _getYMaxNum(maxData);
    double aValue = animation.value;

    canvas.save();
    canvas.translate(xStep / 2, 0.0);
    for (int i = 0; i < data.length; i++) {
      double height =
          ((size.height - _scaleHeight - yStep) * (data[i].value) / maxYNum) *
              aValue;
      canvas.drawRect(
        Rect.fromLTWH(0, 0, barWidth, -height).translate(-barWidth / 2, 0),
        barPaint,
      );
      _drawAxisText(
        canvas,
        (data[i].value * aValue).toStringAsFixed(0),
        alignment: Alignment.center,
        offset: Offset(0, -height - _scaleHeight),
      );
      canvas.translate(xStep, 0);
    }
    canvas.restore();
  }

  @override
  void paint(Canvas canvas, Size size) {
    _moveOrigin(canvas, size);
    _drawYAxis(canvas, size);
    _drawXAxis(canvas, size);
    _drawBars(canvas, size);
  }

  @override
  bool shouldRepaint(ColumnChartPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(ColumnChartPainter oldDelegate) => false;
}
