import '../../exports.dart';

import 'dart:math';

class EventItem {
  DateTime start;
  DateTime? end;
  String title;

  EventItem({
    required this.start,
    required this.title,
    this.end,
  });
}

final List<EventItem> _events = [
  EventItem(
      start: DateTime(1991),
      end: DateTime(1994),
      title: 'loream adsfkha fakdshfkh'),
  EventItem(
      start: DateTime(1992),
      end: DateTime(1994),
      title: 'loream adsfkha fakdshfkh'),
  EventItem(
      start: DateTime(1993),
      end: DateTime(1994),
      title: 'loream adsfkha fakdshfkh'),
  EventItem(
      start: DateTime(1994),
      end: DateTime(1995),
      title: 'loream adsfkha fakdshfkh'),
  EventItem(start: DateTime(1995), title: 'loream adsfkha fakdshfkh'),
  EventItem(start: DateTime(1995), title: 'loream adsfkha fakdshfkh'),
  EventItem(
      start: DateTime(1996),
      end: DateTime(1998),
      title: 'loream adsfkha fakdshfkh'),
  EventItem(start: DateTime(1998), title: 'loream adsfkha fakdshfkh'),
  EventItem(start: DateTime(1999), title: 'loream adsfkha fakdshfkh'),
  EventItem(
      start: DateTime(1995),
      end: DateTime(2000),
      title: 'loream adsfkha fakdshfkh'),
];

class TimeSheet extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final List events;

  const TimeSheet({
    Key? key,
    required this.startDate,
    required this.endDate,
    required this.events,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TimeSheetPainter(
        range: DateTimeRange(start: DateTime(1991), end: DateTime(2002)),
        events: _events,
      ),
      child: Container(),
    );
  }
}

class TimeSheetPainter extends CustomPainter {
  final DateTimeRange range;
  final List<EventItem> events;

  TimeSheetPainter({
    required this.range,
    required this.events,
  });

  void drawTextVertical(
    Canvas canvas,
    String s,
    Offset pos,
  ) {
    canvas.save();
    canvas.translate(10.0, 0.0);
    canvas.rotate(-90 * pi / 180);
    drawText(canvas, s);
    canvas.restore();
  }

  void drawText(
    Canvas canvas,
    String text, {
    TextStyle style = const TextStyle(color: Colors.white, fontSize: 14.0),
  }) {
    TextPainter(
      text: TextSpan(
        text: text,
        style: style,
      ),
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    )
      ..layout(minWidth: 0.0, maxWidth: double.infinity)
      ..paint(canvas, Offset.zero);
  }

  void drawYears(Canvas canvas, Size size) {
    DateTime start = range.start;
    DateTime end = range.end;
    List<int> years = [];
    for (int i = start.year; i <= end.year; i++) {
      years.add(i);
    }
    double padding = size.width / years.length;

    canvas.save();
    canvas.translate(padding / 4, 10.0);
    for (int year in years) {
      drawText(canvas, year.toString());
      canvas.translate(padding, 0);
    }
    canvas.restore();
    drawYearLines(canvas, size, years);
  }

  void drawYearLines(Canvas canvas, Size size, List<int> years) {
    canvas.drawLine(
      Offset(0.0, 1.0),
      Offset(size.width, 1.0),
      Paint()
        ..color = Colors.white
        ..strokeWidth = 2.0,
    );
    Paint linePaint = Paint()..color = Colors.white24;
    double padding = size.width / years.length;

    canvas.save();
    for (var _ in years) {
      Offset p1 = Offset.zero;
      Offset p2 = Offset(0.0, size.height);
      canvas.drawLine(p1, p2, linePaint);
      canvas.translate(padding, 0);
    }
    canvas.restore();
  }

  void drawEvents(Canvas canvas, Size size) {
    final int totalYears = range.end.year - range.start.year;
    const double barHeight = 10.0;
    double barTop = 80.0;
    double padding = size.width / totalYears;

    for (EventItem event in events) {
      int years = 1;
      if (event.end != null) {
        years = event.end!.year - event.start.year;
      }
      double barWidth = size.width * (years / totalYears);
      double barLeft = padding * (event.start.year - range.start.year);

      debugPrint((range.end.year - event.start.year).toString());
      drawEventItem(canvas, size, event, barLeft, barTop, barWidth, barHeight);
      barTop += barHeight * 2;
    }
  }

  void drawEventItem(
    Canvas canvas,
    Size size,
    EventItem event,
    double barLeft,
    double barTop,
    double barWidth,
    double barHeight,
  ) {
    Paint paint = Paint()..color = colors[Random().nextInt(colors.length)];
    Rect rect = Rect.fromLTWH(barLeft, barTop, barWidth, barHeight);
    RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(barHeight / 2));
    canvas.drawRRect(rrect, paint);
    double fontSize = 12.0;

    TextPainter(
      text: TextSpan(
        text: '${event.start.year}',
        style: TextStyle(color: Colors.white, fontSize: fontSize),
        children: [
          // TextSpan(
          //   text: '-',
          //   style: TextStyle(color: Colors.white, fontSize: fontSize),
          // ),
          // TextSpan(
          //   text: '${event.end!.year}',
          //   style: TextStyle(color: Colors.white, fontSize: fontSize),
          // ),
          TextSpan(
            text: ' ',
          ),
          TextSpan(
            text: event.title,
            style: TextStyle(color: Colors.white54, fontSize: fontSize),
          )
        ],
      ),
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    )
      ..layout(minWidth: 0.0, maxWidth: double.infinity)
      ..paint(canvas, Offset(barLeft + barWidth + 10, barTop - (fontSize / 3)));
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0.0, 0.0, size.width, size.height),
      Paint()..color = Colors.black54,
    );
    drawYears(canvas, size);
    drawEvents(canvas, size);
  }

  @override
  bool shouldRepaint(TimeSheetPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(TimeSheetPainter oldDelegate) => false;
}
