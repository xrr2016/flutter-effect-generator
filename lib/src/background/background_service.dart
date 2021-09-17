import '../exports.dart';

List<Map<String, dynamic>> parrtens = [
  {
    "text": "Nighthawk",
    "gradient": [fromCssColor('#2980b9'), fromCssColor('#2c3e50')],
  },
  {
    "text": "Grade Grey",
    "gradient": [fromCssColor('#bdc3c7'), fromCssColor('#2c3e50')],
  },
  {
    "text": "Grade Grey",
    "gradient": [fromCssColor('#bdc3c7'), fromCssColor('#2c3e50')],
  },
];

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
