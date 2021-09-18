import '../exports.dart';

// List<Map<String, dynamic>> parrtens = [
//   {
//     "text": "Nighthawk",
//     "gradient": [fromCssColor('#2980b9'), fromCssColor('#2c3e50')],
//   },
//   {
//     "text": "Grade Grey",
//     "gradient": [fromCssColor('#bdc3c7'), fromCssColor('#2c3e50')],
//   },
//   {
//     "text": "Grade Grey",
//     "gradient": [fromCssColor('#bdc3c7'), fromCssColor('#2c3e50')],
//   },
// ];

class BackgroundService {
  String text;
  String pattern;
  double angle;
  String code;

  BackgroundService({
    this.text = 'Nighthawk',
    this.pattern = '',
    this.angle = 0.0,
    this.code = '',
  }) {
    print('BackgroundService');
    loadJson();
  }

  loadJson() async {
    String data = await rootBundle.loadString('assets/data/gradients.json');
    final jsonResult = json.decode(data);
    print(jsonResult);
  }

  changeText(String text) {
    this.text = text;
  }
}
