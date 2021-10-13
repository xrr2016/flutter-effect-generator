import '../exports.dart';
import './glassmorphism_service.dart';

class GlassmorphismController with ChangeNotifier {
  static final GlassmorphismService _service = GlassmorphismService();

  bool _showControl = true;
  bool get showControl => _showControl;

  toggleShowControl(bool val) {
    _showControl = val;
    notifyListeners();
  }

  double _width = _service.width;
  double get width => _width;

  changeWidth(double val) {
    _width = val;
    changeCode();
    notifyListeners();
  }

  double _height = _service.height;
  double get height => _height;

  changeHeight(double val) {
    _height = val;
    changeCode();
    notifyListeners();
  }

  double _blur = _service.blur;
  double get blur => _blur;

  changeBlur(double val) {
    _blur = val;
    changeCode();
    notifyListeners();
  }

  double _opacity = _service.opacity;
  double get opacity => _opacity;

  changeOpacity(double val) {
    _opacity = val;
    changeCode();
    notifyListeners();
  }

  Color _color = _service.color;
  Color get color => _color;

  changeColor(Color val) {
    _color = val;
    changeCode();
    notifyListeners();
  }

  double _radius = _service.radius;
  double get radius => _radius;

  changeRadius(double val) {
    _radius = val;
    changeCode();
    notifyListeners();
  }

  late String _code = _service.code;
  String get code => _code;

  changeCode() {
    _code = '''
    ClipRRect(
      borderRadius: BorderRadius.circular($_radius),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(
          sigmaX: blur,
          sigmaY: blur,
        ),
        child: Container(
          width: $_width,
          height: $_height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular($_radius),
            color: $_color.withOpacity($_opacity),
            gradient: RadialGradient(
              radius: 2.0,
              center: Alignment(-1, -1),
              colors: [
                $_color.withOpacity(.4),
                $_color.withOpacity(0.01),
              ],
            ),
            border: Border.all(
              width: 1.0,
              color: $_color.withOpacity($_opacity),
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
    )
    ''';
    notifyListeners();
  }

  GlassmorphismController() {
    changeCode();
  }
}
