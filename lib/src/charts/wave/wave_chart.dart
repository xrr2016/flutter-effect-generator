import '../../exports.dart';
import '../models/data_item.dart';

class WaveChart extends StatefulWidget {
  const WaveChart({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  final Widget title;
  final List<DataItem> data;

  @override
  _WaveChartState createState() => _WaveChartState();
}

class _WaveChartState extends State<WaveChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.title,
        SizedBox(height: 20.0),
        CustomPaint(
          painter: WaveChartPainter(
            data: widget.data,
            animation: _controller,
          ),
          child: SizedBox(width: 480.0, height: 480.0),
        ),
      ],
    );
  }
}

class WaveChartPainter extends CustomPainter {
  WaveChartPainter({
    required this.data,
    required this.animation,
  }) : super(repaint: animation);

  final List<DataItem> data;
  final Animation<double> animation;

  double waveWidth = 120; //波宽
  double wrapHeight = 140; // 包裹高度
  double waveHeight = 20; // 波高

  Paint linePaint = Paint()
    ..color = Colors.orange
    ..style = PaintingStyle.fill
    ..strokeWidth = 2;

  TextPainter tp = TextPainter(
    textDirection: TextDirection.ltr,
  );

  Path getWavePath() {
    Path path = Path();
    path.relativeQuadraticBezierTo(
      waveWidth / 2,
      -waveHeight * 2,
      waveWidth,
      0,
    );
    path.relativeQuadraticBezierTo(
      waveWidth / 2,
      waveHeight * 2,
      waveWidth,
      0,
    );
    path.relativeQuadraticBezierTo(
      waveWidth / 2,
      -waveHeight * 2,
      waveWidth,
      0,
    );
    path.relativeQuadraticBezierTo(
      waveWidth / 2,
      waveHeight * 2,
      waveWidth,
      0,
    );
    path.relativeQuadraticBezierTo(
      waveWidth / 2,
      -waveHeight * 2,
      waveWidth,
      0,
    );
    path.relativeQuadraticBezierTo(waveWidth / 2, waveHeight * 2, waveWidth, 0);
    path.relativeLineTo(0, wrapHeight);
    path.relativeLineTo(-waveWidth * 3 * 2.0, 0);
    return path;
  }

  void _drawCircle(Canvas canvas, Size size) {
    canvas.drawCircle(
      Offset.zero,
      waveWidth + 6.0,
      Paint()
        ..color = Colors.amber
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke,
    );
  }

  void _drawProgress(Canvas canvas, Size size) {
    tp.text = TextSpan(
      text: '20%',
      style: TextStyle(
        color: Colors.white,
        fontSize: 24.0,
      ),
    );
    tp.layout();
    tp.paint(canvas, Offset(-18.0, -48.0));
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    _drawCircle(canvas, size);
    _drawProgress(canvas, size);

    canvas.clipPath(
      Path()
        ..addOval(
          Rect.fromCenter(
            center: Offset(0, 0),
            width: waveWidth * 2,
            height: waveWidth * 2,
          ),
        ),
    );

    Path path = getWavePath();

    canvas.save();
    canvas.translate(-3 * waveWidth + 2 * waveWidth * animation.value, 0);
    canvas.drawPath(path, linePaint);
    canvas.restore();

    canvas.translate(-2.5 * waveWidth + 2 * waveWidth * animation.value, 0);
    canvas.drawPath(path, linePaint..color = Colors.orange.withAlpha(44));

    canvas.translate(-2 * waveWidth + 2 * waveWidth * animation.value, 0);
    canvas.drawPath(path, linePaint..color = Colors.orange.withAlpha(88));
  }

  @override
  bool shouldRepaint(WaveChartPainter oldDelegate) =>
      oldDelegate.animation != animation;

  @override
  bool shouldRebuildSemantics(WaveChartPainter oldDelegate) => false;
}
