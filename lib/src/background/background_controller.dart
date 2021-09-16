import '../exports.dart';
import './background_service.dart';

class BackgroundController with ChangeNotifier {
  late final BackgroundService _backgroundService;

  BackgroundController() {
    _backgroundService = BackgroundService();
  }

  String get text => _backgroundService.text;

  changeText(String text) {
    _backgroundService.changeText(text);
    notifyListeners();
  }
}
