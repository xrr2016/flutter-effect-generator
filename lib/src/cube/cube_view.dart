import '../exports.dart';

List<Widget> _customPaintJob = <Widget>[];

List get customPaintJob {
  if (_customPaintJob.isNotEmpty) {
    return _customPaintJob;
  }
  for (num i = 0; i < PenConfig.patternSize.height; i++) {
    num add = i % 2 == 0 ? 0 : PenConfig.cubeSize.width / 2;
    for (num j = 0; j < PenConfig.patternSize.width; j++) {
      _customPaintJob.add(
        Positioned(
            top: i * PenConfig.cubeSize.height,
            left: add + j * PenConfig.cubeSize.width,
            child: CustomPaint(
              size: PenConfig.cubeSize,
              painter: PenPainter(),
            )),
      );
    }
  }
  return _customPaintJob;
}

class FlutterPen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PenColors.scaffold,
      body: Center(
        child: SizedBox(
          width: PenConfig.cubeSize.width * 0.5 +
              PenConfig.cubeSize.width * PenConfig.patternSize.width,
          height: PenConfig.cubeSize.height * PenConfig.patternSize.height,
          child: Stack(
            children: [],
          ),
        ),
      ),
    );
  }
}

class PenColors {
  static const scaffold = const Color(0xFF5bc7f8); //Flutter light blue
  static const darkBlue = const Color(0xFF065a9d); //Flutter dark blue
}

class PenData {}

class PenConfig {
  static Size cubeSize = Size(36, 30);
  static Size patternSize = Size(20, 20);
}

class Utils {
  static bool notNull(Object o) => o != null;
}

class PenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint dark = Paint()
      ..color = PenColors.darkBlue
      ..style = PaintingStyle.fill;
    Paint light = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path pathLeft = Path();

    pathLeft.moveTo(0, 0);
    pathLeft.lineTo(size.width / 2, size.height / 3);
    pathLeft.lineTo(size.width / 2, size.height);
    pathLeft.lineTo(0, 2 * size.height / 3);
    pathLeft.lineTo(0, 0);

    Path pathRight = Path();
    pathRight.moveTo(size.width, 0);
    pathRight.lineTo(size.width / 2, size.height / 3);
    pathRight.lineTo(size.width / 2, size.height);
    pathRight.lineTo(size.width, 2 * size.height / 3);
    pathRight.lineTo(size.width, size.height);

    canvas.drawPath(pathLeft, light);
    canvas.drawPath(pathRight, dark);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
