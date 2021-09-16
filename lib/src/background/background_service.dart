import '../exports.dart';

class BackgroundService {
  String text;
  String pattern;
  List<Color> colors;
  double angle;
  String code;

  BackgroundService({
    this.text = 'Nighthawk',
    this.pattern = '',
    this.colors = const [],
    this.angle = 0.0,
    this.code = '',
  });

  changeText(String text) {
    this.text = text;
  }
}
