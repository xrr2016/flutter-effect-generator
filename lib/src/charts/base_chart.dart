import '../exports.dart';
import './models/series.dart';
import './chart_type.dart';
import 'area/draw_area_chart.dart';
import './column/draw_column_chart.dart';
import './curve/draw_cruve_chart.dart';
import './line/draw_line_chart.dart';
import 'bar/draw_bar_chart.dart';

class BaseChart extends StatefulWidget {
  final String title;
  final double width;
  final double height;
  final List<Color> theme;
  final List<Series> series;
  final List<String> xaxis;
  final List<String> yaxis;
  final ChartType type;

  const BaseChart({
    Key? key,
    required this.title,
    required this.width,
    required this.height,
    required this.theme,
    required this.series,
    required this.type,
    required this.xaxis,
    required this.yaxis,
  }) : super(key: key);

  @override
  _BaseChartState createState() => _BaseChartState();
}

class _BaseChartState extends State<BaseChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animation;

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    )..forward();
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Column(
          children: [
            ChartTitle(title: widget.title),
            ChartPainter(animation: _animation, widget: widget),
            ChartLegend(theme: widget.theme, series: widget.series),
          ],
        ),
      ),
    );
  }
}

class ChartPainter extends StatelessWidget {
  const ChartPainter({
    Key? key,
    required AnimationController animation,
    required this.widget,
  })  : _animation = animation,
        super(key: key);

  final BaseChart widget;
  final AnimationController _animation;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onPanUpdate: (details) {
          debugPrint('globalPosition: ' + details.globalPosition.toString());
          debugPrint('localPosition: ' + details.localPosition.toString());
          debugPrint('delta: ' + details.delta.toString());
        },
        child: Stack(
          children: [
            CustomPaint(
              painter: BaseChartPainter(
                animation: _animation,
                series: widget.series,
                theme: widget.theme,
                xaxis: widget.xaxis,
                yaxis: widget.yaxis,
                type: widget.type,
              ),
              size: Size.infinite,
            ),
          ],
        ),
      ),
    );
  }
}

class BaseChartPainter extends CustomPainter {
  final ChartType type;
  final List<Color> theme;
  final List<Series> series;
  final List<String> xaxis;
  final List<String> yaxis;
  final Animation<double> animation;

  BaseChartPainter({
    required this.series,
    required this.theme,
    required this.xaxis,
    required this.yaxis,
    required this.type,
    required this.animation,
  }) : super(repaint: animation);

  final TextPainter _textPainter = TextPainter(
    textDirection: TextDirection.ltr,
  );
  final double _chartPaddding = 20.0;
  final Paint _gridPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.black26
    ..strokeWidth = 0.5;
  final linePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0;

  double _xStep = 0;
  double _yStep = 0;
  double _numUnit = 0.0;

  void _moveOrigin(Canvas canvas, Size size) {
    canvas.translate(_chartPaddding * 3, size.height - _chartPaddding * 1.5);
  }

  void _drawAxisText(
    Canvas canvas,
    String str, {
    Color color = Colors.black87,
    bool yaxis = false,
  }) {
    TextSpan text = TextSpan(
      text: str,
      style: TextStyle(fontSize: 12, color: color),
    );
    _textPainter.text = text;
    _textPainter.layout();
    Size size = _textPainter.size;
    Offset offsetPos = yaxis
        ? Offset(
            -size.width * 2,
            -size.height / 2,
          )
        : Offset(
            -size.width / 2,
            size.height / 1.5,
          );

    _textPainter.paint(canvas, offsetPos);
  }

  void _drawXAxis(Canvas canvas, Size size) {
    double chartWidth = size.width - _chartPaddding * 5;

    if (type == ChartType.area) {
      _xStep = chartWidth / (xaxis.length - 1);
    } else {
      _xStep = chartWidth / xaxis.length;
    }

    canvas.save();
    if (type != ChartType.area) {
      canvas.translate(_xStep / 2, 0.0);
    }
    for (int i = 0; i < xaxis.length; i++) {
      canvas.drawLine(Offset.zero, Offset(0.0, _chartPaddding / 3), _gridPaint);
      _drawAxisText(canvas, xaxis[i]);
      canvas.translate(_xStep, 0);
    }
    canvas.restore();
  }

  void _drawYAxis(Canvas canvas, Size size) {
    double chartHeight = size.height - _chartPaddding * 1.5;
    _yStep = chartHeight / yaxis.length;
    _numUnit = (_yStep * (yaxis.length - 1)) / double.parse(yaxis.last);

    canvas.save();
    for (int i = 0; i < yaxis.length; i++) {
      canvas.drawLine(
        Offset.zero,
        Offset(size.width - _chartPaddding * 5, 0.0),
        _gridPaint,
      );
      _drawAxisText(canvas, yaxis[i], yaxis: true);
      canvas.translate(0, -_yStep);
    }
    canvas.restore();
  }

  void _drawSeries(
    Series series,
    Color color,
    Canvas canvas,
    Size size,
  ) {
    canvas.save();

    // ChartType _type;

    // if (type == ChartType.combine) {
    //   _type = ChartType.combine;
    // } else {
    //   _type = type;
    // }

    // if (type != ChartType.area || type != ChartType.bar) {
    //   canvas.translate(_xStep / 2, 0.0);
    // }

    switch (type) {
      case ChartType.area:
        drawAreaChart(
            series.data, color, canvas, size, linePaint, _xStep, _numUnit);
        break;
      case ChartType.column:
        drawColumnChart(series.data, color, canvas, size, _xStep, _numUnit);
        break;
      case ChartType.bar:
        drawBarChart(series.data, color, canvas, size, _yStep, _numUnit);
        break;
      case ChartType.curve:
        drawCruveChart(
            series.data, color, canvas, size, linePaint, _xStep, _numUnit);
        break;
      case ChartType.line:
        drawLineChart(
            series.data, color, canvas, size, linePaint, _xStep, _numUnit);
        break;
      default:
    }
    canvas.restore();
  }

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawRect(
    //   Rect.fromLTWH(0.0, 0.0, size.width, size.height),
    //   Paint()..color = Colors.amber,
    // );

    if (type == ChartType.bar) {
      moveBarChartOrigin(canvas, size, _chartPaddding);
      _xStep = (size.width - _chartPaddding) / yaxis.length;
      _yStep = (size.height - _chartPaddding * 2) / xaxis.length;
      _numUnit = (_xStep * (yaxis.length - 1)) / double.parse(yaxis.last);

      drawBarChartXAxis(
        canvas,
        size,
        yaxis,
        _chartPaddding,
        _gridPaint,
        _drawAxisText,
      );
      drawBarChartYAxis(
        canvas,
        size,
        xaxis,
        _chartPaddding,
        _gridPaint,
        _drawAxisText,
      );
    } else {
      _moveOrigin(canvas, size);
      _drawXAxis(canvas, size);
      _drawYAxis(canvas, size);
    }

    for (int i = 0; i < series.length; i++) {
      Color color = theme[i];
      Series serie = series[i];
      _drawSeries(serie, color, canvas, size);
    }
  }

  @override
  bool shouldRepaint(BaseChartPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BaseChartPainter oldDelegate) => false;
}

class ChartLegend extends StatelessWidget {
  const ChartLegend({
    Key? key,
    required this.series,
    required this.theme,
  }) : super(key: key);

  final List<Series> series;
  final List<Color> theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          series.length,
          (index) => Container(
            width: 80.0,
            padding: EdgeInsets.only(right: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 10.0,
                  height: 10.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: theme[index],
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 4.0),
                Text(
                  series[index].name,
                  style: TextStyle(fontSize: 12.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChartTitle extends StatelessWidget {
  const ChartTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
