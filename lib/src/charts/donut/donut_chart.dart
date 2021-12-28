import 'dart:math' as math;

import '../../exports.dart';
import '../chart_container.dart';
import '../utils/utils.dart';
import '../models/data_item.dart';

class DonutCahrt extends StatefulWidget {
  final Widget title;
  final List<DataItem> data;

  DonutCahrt({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  _DonutCahrtState createState() => _DonutCahrtState();
}

class _DonutCahrtState extends State<DonutCahrt> with TickerProviderStateMixin {
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
    return ChartContainer(
      title: widget.title,
      painter: DonutChartPainter(
        data: widget.data,
        animation: _controller,
      ),
      legend: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          widget.data.length,
          (index) => Container(
            width: 50.0,
            height: 20.0,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            color: colors[index % colors.length],
            alignment: Alignment.center,
            child: Text(
              widget.data[index].name,
              style: TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          ),
        ),
      ),
    );
  }
}

class DonutChartPainter extends CustomPainter {
  DonutChartPainter({
    required this.data,
    required this.animation,
  }) : super(repaint: animation) {
    maxData = data.map((DataItem item) => item.value).reduce((a, b) => a + b);
  }

  final List<DataItem> data;
  final Animation<double> animation;

  double maxData = 0.0;
  double initStartAngle = 0.0;
  final double dountWidth = 80.0;

  void _drawBackgroudArc(Canvas canvas, Size size) {
    final sw = size.width;
    final sh = size.height;
    final double radius = math.min(sw, sh) / 1.5;

    Paint paint = Paint()
      ..color = Colors.black12
      ..strokeWidth = dountWidth
      ..style = PaintingStyle.stroke;
    Rect rect = Rect.fromCircle(
      radius: radius / 2,
      center: Offset.zero,
    );

    double startAngle = 0;
    double sweepAngle = pi * 2;
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  void _drawItemArc(
    Canvas canvas,
    Size size,
  ) {
    final sw = size.width;
    final sh = size.height;
    final double radius = math.min(sw, sh) / 1.5;
    Rect rect = Rect.fromCircle(center: Offset.zero, radius: radius / 2);

    canvas.save();
    canvas.rotate(-pi / 2);

    for (int i = 0; i < data.length; i++) {
      Color color = colors[i % colors.length];
      double sweepAngle = pi * 2 * (data[i].value / maxData);

      canvas.drawArc(
        rect,
        0.0,
        sweepAngle * animation.value,
        false,
        Paint()
          ..color = color
          ..strokeWidth = dountWidth
          ..style = PaintingStyle.stroke,
      );
      canvas.rotate(sweepAngle);
    }
    canvas.restore();
  }

  void _drawInfos(Canvas canvas, Size size) {
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
        offset: Offset(radius / 2 + dountWidth + 30.0, 0),
      );

      drawAxisText(
        canvas,
        percent,
        color: Colors.white,
        alignment: Alignment.center,
        offset: Offset(radius / 2 + dountWidth / 2, 0),
      );
      Path showPath = Path();
      showPath.moveTo(radius / 2 + dountWidth, 0);
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
    _drawBackgroudArc(canvas, size);
    _drawItemArc(canvas, size);
    _drawInfos(canvas, size);
  }

  @override
  bool shouldRepaint(DonutChartPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(DonutChartPainter oldDelegate) => false;
}
