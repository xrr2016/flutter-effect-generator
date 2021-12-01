import '../exports.dart';
import '../sketch/utils.dart';

class GridBackground extends StatelessWidget {
  const GridBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GridPainter(),
      child: Container(),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    grid(canvas, size, count: 50);
  }

  @override
  bool shouldRepaint(GridPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(GridPainter oldDelegate) => false;
}
