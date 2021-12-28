import 'dart:math';
import 'package:flutter/material.dart';

import '../chart_container.dart';
import '../models/data_item.dart';
import './utils.dart';

Color _generateBlockColor({double opacity = 1}) {
  if (opacity == 0) {
    return Colors.black12;
  }

  return Color.fromRGBO(45, 181, 93, opacity);
}

double _getOpacity(double val, double maxVal) {
  double percent = val / maxVal;
  double opacity;

  if (percent > .7) {
    opacity = 1;
  } else if (percent > .5) {
    opacity = 0.8;
  } else if (percent > .3) {
    opacity = 0.6;
  } else if (percent > 0) {
    opacity = 0.4;
  } else {
    opacity = 0.0;
  }

  return opacity;
}

class CalenderHeatMap extends StatefulWidget {
  final Widget title;
  final List<DataItem> data;

  CalenderHeatMap({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  State<CalenderHeatMap> createState() => _CalenderHeatMapState();
}

class _CalenderHeatMapState extends State<CalenderHeatMap>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
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
      painter: CalenderHeatMapPainter(
        data: widget.data,
        animation: _controller,
      ),
      legend: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 20.0,
                height: 12.0,
                margin: EdgeInsets.only(right: 2.0),
                color: _generateBlockColor(
                  opacity: _getOpacity(5, 25),
                ),
              ),
              Text('0-5'),
            ],
          ),
          SizedBox(width: 10.0),
          Row(
            children: [
              Container(
                width: 20.0,
                height: 12.0,
                margin: EdgeInsets.only(right: 2.0),
                color: _generateBlockColor(
                  opacity: _getOpacity(10, 25),
                ),
              ),
              Text('6-10'),
            ],
          ),
          SizedBox(width: 10.0),
          Row(
            children: [
              Container(
                width: 20.0,
                height: 12.0,
                margin: EdgeInsets.only(right: 2.0),
                color: _generateBlockColor(
                  opacity: _getOpacity(15, 25),
                ),
              ),
              Text('11-20'),
            ],
          ),
          SizedBox(width: 10.0),
          Row(
            children: [
              Container(
                width: 20.0,
                height: 12.0,
                margin: EdgeInsets.only(right: 2.0),
                color: _generateBlockColor(
                  opacity: _getOpacity(25, 25),
                ),
              ),
              Text('20-25'),
            ],
          ),
        ],
      ),
    );
  }
}

class CalenderHeatMapPainter extends CustomPainter {
  final List<DataItem> data;
  final Animation<double> animation;

  CalenderHeatMapPainter({
    required this.data,
    required this.animation,
  }) : super(repaint: animation) {
    if (data.isNotEmpty) {
      maxVal = data.map((d) => d.value).reduce(max);
    }
  }

  final double gap = 2.0;
  final double _blockSize = 12.0;
  final double blockRadius = 2.0;
  final Paint blockPaint = Paint()
    ..isAntiAlias = true
    ..style = PaintingStyle.fill;

  double maxVal = 0.0;
  double dx = 0.0;
  double dy = 0.0;

  void _drawBlock(Canvas canvas, Color color) {
    final Rect rect = Rect.fromLTWH(0.0, 0.0, _blockSize, _blockSize);
    final Radius radius = Radius.circular(blockRadius);
    final rrect = RRect.fromRectAndRadius(rect, radius);

    blockPaint.color = color;
    canvas.drawRRect(rrect, blockPaint);
  }

  void _drawMonthDays(Canvas canvas, Size size, int year, int month) {
    if (data.isEmpty) {
      return;
    }
    int monthDays = daysInMonth(year, month);
    int weekDays = DateTime(year, month, 1).weekday;

    canvas.save();
    canvas.translate(_blockSize * 3, 0.0);
    List<DataItem> datas = data.where((d) => d.date!.month == month).toList();

    for (int j = 0; j < monthDays + weekDays - 1; j++) {
      if (j < weekDays - 1) {
        canvas.translate(0.0, gap + _blockSize);
      } else if (j % 7 == 0 && j != 0) {
        canvas.translate(gap + _blockSize, -(_blockSize + gap) * 6);
        if (datas.isNotEmpty) {
          _drawBlock(
            canvas,
            _generateBlockColor(
              opacity: _getOpacity(
                datas[j - weekDays + 1].value * animation.value,
                maxVal,
              ),
            ),
          );
        } else {
          _drawBlock(canvas, _generateBlockColor(opacity: 0.0));
        }
      } else {
        canvas.translate(0.0, gap + _blockSize);

        if (datas.isNotEmpty) {
          _drawBlock(
            canvas,
            _generateBlockColor(
              opacity: _getOpacity(
                datas[j - weekDays + 1].value * animation.value,
                maxVal,
              ),
            ),
          );
        } else {
          _drawBlock(canvas, _generateBlockColor(opacity: 0.0));
        }
      }
    }

    canvas.restore();
  }

  void _drawBackground(Canvas canvas, Size size) {
    if (data.isEmpty) {
      return;
    }

    DataItem firstDay = data.first;
    DateTime? firstDayDate = firstDay.date;
    dx = size.width / 12;
    TextPainter tp = TextPainter(
      textDirection: TextDirection.ltr,
    );

    canvas.save();
    canvas.translate(0.0, _blockSize * 2);

    for (int i = 1; i <= 12; i++) {
      int monthDays = daysInMonth(firstDayDate!.year, i);

      _drawMonthDays(canvas, size, firstDayDate.year, i);

      double _dx =
          monthDays > 29 ? (gap + _blockSize) * 6 : (gap + _blockSize) * 5;
      canvas.translate(_dx, 0.0);

      String text = monthTextEn[i - 1];
      tp.text = TextSpan(text: text);
      tp.layout();
      tp.paint(canvas, Offset(-_dx / 2, -_blockSize));
    }

    canvas.restore();
  }

  void _drawWeekDayTexts(Canvas canvas, Size size) {
    dy = size.height / weekDayTextEn.length;
    TextPainter tp = TextPainter(
      textDirection: TextDirection.ltr,
    );

    canvas.save();
    canvas.translate(0, _blockSize * 3);
    weekDayTextEn.asMap().forEach((index, text) {
      tp.text = TextSpan(text: text);
      tp.layout();
      tp.paint(canvas, Offset.zero);
      canvas.translate(0, _blockSize + gap);
    });
    canvas.restore();
  }

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawRect(
    //   Rect.fromLTWH(0.0, 0.0, size.width, size.height),
    //   Paint()..color = Colors.amber,
    // );

    canvas.translate(_blockSize, 0.0);
    _drawBackground(canvas, size);
    _drawWeekDayTexts(canvas, size);
  }

  @override
  bool shouldRepaint(CalenderHeatMapPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(CalenderHeatMapPainter oldDelegate) => false;
}
