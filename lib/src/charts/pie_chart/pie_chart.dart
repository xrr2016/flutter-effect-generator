import 'dart:math' as math;

import '../utils/utils.dart';
import '../../exports.dart';
import '../models/data_item.dart';

class PieChart extends StatefulWidget {
  final Widget title;
  final List<DataItem> data;

  PieChart({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 3000),
      vsync: this,
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
            painter: PeiChartPainter(
              data: widget.data,
              animation: _controller,
            ),
            child: SizedBox(width: 480.0, height: 480.0),
          ),
        ),
        Align(alignment: Alignment.topCenter, child: widget.title),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.data.length,
              (index) => Container(
                width: 50.0,
                height: 24.0,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                color: colors[index % colors.length],
                alignment: Alignment.center,
                child: Text(
                  widget.data[index].name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PeiChartPainter extends CustomPainter {
  PeiChartPainter({
    required this.data,
    required this.animation,
  }) : super(repaint: animation) {
    maxData = data.map((DataItem item) => item.value).reduce((a, b) => a + b);
  }

  final List<DataItem> data;
  final Animation<double> animation;

  double maxData = 0.0;

  void drawParts(Canvas canvas, Size size) {
    final sw = size.width;
    final sh = size.height;
    final double radius = math.min(sw, sh);

    canvas.save();
    canvas.rotate(-pi / 2);
    Rect rect = Rect.fromCenter(
      center: Offset.zero,
      width: radius,
      height: radius,
    );
    for (int i = 0; i < data.length; i++) {
      Color color = colors[i % colors.length];
      double sweepAngle = pi * 2 * (data[i].value / maxData);
      canvas.drawArc(
        rect,
        0.0,
        sweepAngle * animation.value,
        true,
        Paint()..color = color,
      );
      canvas.rotate(sweepAngle);
    }
    canvas.restore();
  }

  void drawCircle(Canvas canvas, Size size) {
    final sw = size.width;
    final sh = size.height;
    final double radius = math.min(sw, sh) / 2;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.grey
      ..strokeWidth = 1.0;

    canvas.drawCircle(Offset.zero, radius, paint);
  }

  void drawInfos(Canvas canvas, Size size) {
    final sw = size.width;
    final sh = size.height;
    final double radius = math.min(sw, sh) / 2;

    canvas.save();
    canvas.rotate(-pi / 2);
    for (int i = 0; i < data.length; i++) {
      Color color = colors[i % colors.length];
      double sweepAngle = pi * 2 * (data[i].value / maxData);
      String percent =
          ((data[i].value / maxData * 100).toStringAsFixed(1)) + '%';
      String val = (data[i].value * animation.value).toStringAsFixed(0);

      canvas.save();
      canvas.rotate(sweepAngle / 2);
      drawAxisText(
        canvas,
        val,
        color: color,
        alignment: Alignment.center,
        offset: Offset(radius + 25, 0),
      );

      drawAxisText(
        canvas,
        percent,
        color: Colors.white,
        alignment: Alignment.center,
        offset: Offset(radius / 2, 0),
      );
      Path showPath = Path();
      showPath.moveTo(radius, 0);
      showPath.relativeLineTo(15, 0);
      canvas.drawPath(
        showPath,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke,
      );
      canvas.restore();
      canvas.rotate(sweepAngle);
    }
    canvas.restore();
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    drawCircle(canvas, size);
    drawParts(canvas, size);
    drawInfos(canvas, size);
  }

  @override
  bool shouldRepaint(PeiChartPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(PeiChartPainter oldDelegate) => false;
}
