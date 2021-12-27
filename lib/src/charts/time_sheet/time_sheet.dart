import 'dart:ui';

import '../../exports.dart';
import '../models/event_item.dart';

class TimeSheet extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  final List<EventItem> events;
  final Widget title;

  const TimeSheet({
    Key? key,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.events,
  }) : super(key: key);

  @override
  State<TimeSheet> createState() => _TimeSheetState();
}

class _TimeSheetState extends State<TimeSheet> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final double _height = 25.0;

  double _calcChartHeight() {
    double totalHeight = widget.events.length * _height + 80.0;

    return totalHeight < 320 ? 320 : totalHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.title,
        SizedBox(height: 30.0),
        CustomPaint(
          painter: TimeSheetPainter(
            startDate: widget.startDate,
            endDate: widget.endDate,
            events: widget.events,
            animation: _controller,
          ),
          child: SizedBox(
            width: double.infinity,
            height: _calcChartHeight(),
          ),
        ),
      ],
    );
  }
}

class TimeSheetPainter extends CustomPainter {
  final DateTime startDate;
  final DateTime endDate;
  final List<EventItem> events;
  final Animation<double> animation;

  TimeSheetPainter({
    required this.startDate,
    required this.endDate,
    required this.events,
    required this.animation,
  }) : super(repaint: animation) {
    _yearsLen = endDate.year - startDate.year;
  }

  final double _barHeight = 12.0;
  final double _paddingTop = 30.0;
  final Paint linePaint = Paint()
    ..strokeWidth = 1.0
    ..color = Colors.black26
    ..style = PaintingStyle.stroke;

  int _yearsLen = 0;
  double _oneYearWidth = 0.0;

  void _drawText(
    Canvas canvas,
    String text, {
    TextStyle style = const TextStyle(color: Colors.white, fontSize: 14.0),
    Offset offset = Offset.zero,
  }) {
    TextPainter(
      text: TextSpan(
        text: text,
        style: style,
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )
      ..layout(minWidth: 0.0, maxWidth: double.infinity)
      ..paint(canvas, offset);
  }

  void _drawLine(Canvas canvas, Size size) {
    double step = 6.0;
    double span = 4.0;
    double partLength = step + span;
    Path path = Path()
      ..moveTo(0.0, _paddingTop)
      ..lineTo(0.0, size.height - _paddingTop / 4)
      ..fillType = PathFillType.evenOdd;
    PathMetrics pms = path.computeMetrics();

    for (PathMetric pm in pms) {
      int count = pm.length ~/ partLength;
      for (int i = 0; i < count; i++) {
        canvas.drawPath(
          pm.extractPath(partLength * i, partLength * i + step),
          linePaint,
        );
      }
      double tail = pm.length % partLength;
      canvas.drawPath(pm.extractPath(pm.length - tail, pm.length), linePaint);
    }
  }

  void _drawYears(Canvas canvas, Size size) {
    DateTime start = startDate;
    DateTime end = endDate;
    List<int> years = [];

    if (_yearsLen > 10) {
      int addYear = end.year.isEven ? 4 : 3;

      for (int i = start.year; i <= end.year; i += addYear) {
        years.add(i);
      }
      if (!years.contains(end.year)) {
        years.add(end.year);
      }
    } else {
      for (int i = start.year; i <= end.year; i++) {
        years.add(i);
      }
    }
    _oneYearWidth = size.width / _yearsLen;

    canvas.save();
    canvas.translate(0.0, _paddingTop / 4);
    canvas.drawLine(
      Offset(-_oneYearWidth, _paddingTop),
      Offset(size.width + _oneYearWidth, _paddingTop),
      Paint()
        ..strokeWidth = 1.0
        ..color = Colors.black12,
    );

    for (int i = 0; i < years.length; i++) {
      int year = years[i];

      if (i == 0) {
        _drawText(
          canvas,
          year.toString(),
          style: TextStyle(color: Colors.black54),
          offset: Offset(-14.0, 0.0),
        );
        _drawLine(canvas, size);
      } else {
        double dx = (years[i] - years[i - 1]) * _oneYearWidth;
        canvas.translate(dx, 0);

        _drawText(
          canvas,
          year.toString(),
          style: TextStyle(
            color: Colors.black54,
          ),
          offset: Offset(-14.0, 0.0),
        );
        _drawLine(canvas, size);
      }
    }

    canvas.restore();
  }

  void _drawEvents(Canvas canvas, Size size) {
    double barTop = 60.0;

    canvas.save();
    for (var i = 0; i < events.length; i++) {
      EventItem event = events[i];
      Color color = colors[i % colors.length];
      int years = event.end.year - event.start.year;
      double barLeft = _oneYearWidth * (event.start.year - startDate.year);
      double barWidth = years * _oneYearWidth * animation.value;

      _drawEventItem(
        canvas,
        size,
        event,
        barLeft,
        barTop,
        barWidth,
        _barHeight,
        color,
      );
      canvas.translate(0.0, _barHeight * 2);
    }
    canvas.restore();
  }

  void _drawEventItem(
    Canvas canvas,
    Size size,
    EventItem event,
    double barLeft,
    double barTop,
    double barWidth,
    double barHeight,
    Color color,
  ) {
    double fontSize = 12.0;
    Paint paint = Paint()..color = color;
    Rect rect = Rect.fromLTWH(barLeft, barTop, barWidth, barHeight);
    RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(barHeight / 2));

    canvas.drawRRect(rrect, paint);
    _drawText(
      canvas,
      '${event.start.year}-${event.end.year} ${event.title}',
      style: TextStyle(fontSize: fontSize, color: color),
      offset: Offset(barLeft + barWidth + 4, barTop - fontSize / 3),
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawRect(
    //   Rect.fromLTWH(0.0, 0.0, size.width, size.height),
    //   Paint()..color = Colors.amberAccent,
    // );
    _drawYears(canvas, size);
    _drawEvents(canvas, size);
  }

  @override
  bool shouldRepaint(TimeSheetPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(TimeSheetPainter oldDelegate) => false;
}
