import '../../exports.dart';
import 'dart:ui' as ui;

class GlassmorphismCard extends StatelessWidget {
  final double width;
  final double height;
  final double blur;
  final double opacity;
  final double radius;
  final Color color;

  const GlassmorphismCard({
    Key? key,
    required this.width,
    required this.height,
    required this.blur,
    required this.opacity,
    required this.radius,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(
          sigmaX: blur,
          sigmaY: blur,
        ),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: color.withOpacity(opacity),
            boxShadow: [
              BoxShadow(color: color.withOpacity(opacity), offset: Offset(0, 1))
            ],
            gradient: RadialGradient(
              radius: 2.0,
              center: Alignment(-1, -1),
              colors: [
                color.withOpacity(opacity),
                color.withOpacity(0.01),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 10.0),
                CircleAvatar(
                  radius: 36.0,
                  child: FlutterLogo(size: 36.0),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Charles McBrayer',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.75),
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  '5555 5555 5555 4444',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.75),
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
