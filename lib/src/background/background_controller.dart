import '../exports.dart';
import './background_service.dart';
import './model/gradient_item.dart';

class BackgroundController with ChangeNotifier {
  final BackgroundService _backgroundService = BackgroundService();

  late String _text = _backgroundService.text;
  String get text => _text;

  changeText(String text) {
    _text = text;
    notifyListeners();
    _backgroundService.changeText(text);
  }

  clearText() {
    _text = '';
    notifyListeners();
    _backgroundService.changeText('');

    print('clear');
  }

  GradientItem get gradient => _backgroundService.gradient;
  List<GradientItem> get gradients => _backgroundService.gradients;

  changleGradient(GradientItem item) {
    _backgroundService.changleGradient(item);
    notifyListeners();
  }
}
