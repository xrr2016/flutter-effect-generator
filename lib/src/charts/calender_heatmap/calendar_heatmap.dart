import 'dart:math';
import 'package:flutter/material.dart';

import '../models/data_item.dart';
import './utils.dart';

class CalenderHeatMap extends StatelessWidget {
  final Widget title;
  final List<DataItem> data;

  CalenderHeatMap({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: CustomPaint(
            painter: CalenderHeatMapPainter(data: data),
            child: SizedBox(width: 1200.0, height: 360.0),
          ),
        ),
        Align(alignment: Alignment.topCenter, child: title),
        Align(
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              Text('0'),
              Text('1'),
              Text('2'),
              Text('3'),
              Text('4'),
            ],
          ),
        ),
      ],
    );
  }
}

class CalenderHeatMapPainter extends CustomPainter {
  final List<DataItem> data;

  CalenderHeatMapPainter({
    required this.data,
  }) {
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

  Color _generateBlockColor({double opacity = 1}) {
    if (opacity == 0) {
      return Colors.black12;
    }

    return Color.fromRGBO(45, 181, 93, opacity);
  }

  void _drawBlock(Canvas canvas, Color color) {
    final Rect rect = Rect.fromLTWH(0.0, 0.0, _blockSize, _blockSize);
    final Radius radius = Radius.circular(blockRadius);
    final rrect = RRect.fromRectAndRadius(rect, radius);

    blockPaint.color = color;
    canvas.drawRRect(rrect, blockPaint);
  }

  double _getOpacity(double val) {
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
              opacity: _getOpacity(datas[j - weekDays + 1].value),
            ),
          );
        } else {
          _drawBlock(canvas, _generateBlockColor(opacity: 0.0));
        }
      } else {
        canvas.translate(0.0, gap + _blockSize);

        if (datas.isNotEmpty) {
          debugPrint(
              '$month $monthDays ${j - weekDays + 1} ${datas[j - weekDays + 1].value}');
          _drawBlock(
            canvas,
            _generateBlockColor(
              opacity: _getOpacity(datas[j - weekDays + 1].value),
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
          monthDays > 28 ? (gap + _blockSize) * 7 : (gap + _blockSize) * 6;
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
    _drawBackground(canvas, size);
    _drawWeekDayTexts(canvas, size);
  }

  @override
  bool shouldRepaint(CalenderHeatMapPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(CalenderHeatMapPainter oldDelegate) => false;
}
