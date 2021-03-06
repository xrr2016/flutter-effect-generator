import '../../exports.dart';
import '../utils/utils.dart';
import '../chart_container.dart';
import '../models/data_item.dart';

class BarChart extends StatefulWidget {
  final String title;
  final List<DataItem> data;

  BarChart({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  _BarChartState createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> with TickerProviderStateMixin {
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
      title: Row(
        children: [
          SizedBox(width: 20.0),
          Text(
            widget.title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      painter: BarChartPainter(
        data: widget.data,
        animation: _controller,
      ),
    );
  }
}

class BarChartPainter extends CustomPainter {
  BarChartPainter({
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

  double xStep = 0;
  double yStep = 0;
  double maxData = 0.0;
  Paint gridPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.grey
    ..strokeWidth = 0.5;
  Paint barPaint = Paint()..color = Colors.blue;

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
    _textPainter.layout(); // ????????????
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

  void _drawXAxis(Canvas canvas, Size size) {
    double maxYNum = getYMaxNum(maxData);
    double numStep = getYStepNum(maxData);

    debugPrint('maxYNum: ' + maxYNum.toString());
    debugPrint('numStep: ' + numStep.toString());
    int steps = 0;
    double c = 0.0;

    while (c < maxYNum) {
      steps++;
      c += numStep;
    }

    xStep = (size.width - _scaleHeight) / (steps + 1);

    canvas.save();
    for (int i = 0; i <= steps; i++) {
      canvas.drawLine(
        Offset.zero,
        Offset(0, size.height - _scaleHeight),
        gridPaint,
      );
      canvas.save();
      canvas.translate(0.0, size.height + _scaleHeight);
      final String str = (numStep * i).toStringAsFixed(0);
      _drawAxisText(canvas, str, alignment: Alignment.center);
      canvas.restore();
      canvas.translate(xStep, 0.0);
    }
    canvas.restore();
  }

  void _drawYAxis(Canvas canvas, Size size) {
    yStep = (size.height - _scaleHeight) / (data.length);
    final double barHeight = yStep / 2.5;

    canvas.save();
    canvas.translate(-_scaleHeight * 3, yStep / 2 + _scaleHeight / 2);
    for (var i = 0; i < data.length; i++) {
      _drawAxisText(
        canvas,
        data[i].name.toString(),
        alignment: Alignment.center,
        color: Colors.grey,
      );
      canvas.translate(0.0, yStep - barHeight / 4);
    }
    canvas.restore();
  }

  void _drawBars(Canvas canvas, Size size) {
    final double barHeight = yStep / 2.5;
    final double aValue = animation.value;
    final double maxXNum = getYMaxNum(maxData);

    canvas.save();
    canvas.translate(0.0, yStep / 2 - _scaleHeight);

    for (var i = 0; i < data.length; i++) {
      final double barWidth = (data[i].value / maxXNum) *
          (size.width - _scaleHeight - xStep) *
          aValue;
      final Rect bar = Rect.fromLTWH(
        0.0,
        0.0,
        barWidth,
        barHeight,
      );
      canvas.drawRect(bar, barPaint);
      canvas.drawLine(
        Offset(0.0, barHeight / 2),
        Offset(-_scaleHeight, barHeight / 2),
        gridPaint,
      );
      canvas.save();
      canvas.translate(barWidth + 30.0, barHeight / 2);
      _drawAxisText(
        canvas,
        (data[i].value * aValue).toStringAsFixed(0),
      );
      canvas.restore();
      canvas.translate(0.0, yStep - barHeight / 4);
    }
    canvas.restore();
  }

  @override
  void paint(Canvas canvas, Size size) {
    _drawXAxis(canvas, size);
    _drawYAxis(canvas, size);
    _drawBars(canvas, size);
  }

  @override
  bool shouldRepaint(BarChartPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BarChartPainter oldDelegate) => false;
}
