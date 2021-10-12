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
            gradient: RadialGradient(
              radius: 2.0,
              center: Alignment(-1, -1),
              colors: [
                color.withOpacity(.4),
                color.withOpacity(0.01),
              ],
            ),
            border: Border.all(
              width: 1.0,
              color: color.withOpacity(opacity),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(26.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50.0,
                  child: FlutterLogo(
                    size: 50.0,
                  ),
                ),
                SizedBox(height: 12.0),
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
