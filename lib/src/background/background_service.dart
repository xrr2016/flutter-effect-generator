import '../exports.dart';
import './model/gradient_item.dart';

class BackgroundService {
  String text;
  String code;
  List<GradientItem> gradients;
  GradientItem gradient;

  BackgroundService({
    this.text = '',
    this.gradient = const GradientItem(colors: [], name: ''),
    this.gradients = const [],
    this.code = '',
  }) {
    loadJson();
  }

  List<GradientItem> _parseGradients(String data) {
    final jsonResult = json.decode(data) as List;
    return jsonResult.map((json) => GradientItem.fromJson(json)).toList();
  }

  loadJson() async {
    String data = await rootBundle.loadString('assets/data/gradients.json');
    gradients = await compute(_parseGradients, data);
    gradient = gradients.first;
  }

  changeText(String text) {
    text = text;
  }

  changleGradient(GradientItem item) {
    gradient = item;
  }

  setCode(String code) {
    code = code;
  }
}
