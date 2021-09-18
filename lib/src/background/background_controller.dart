import '../exports.dart';
import './background_service.dart';
import './model/gradient_item.dart';

class BackgroundController with ChangeNotifier {
  BackgroundController() {
    changeCode();
  }

  bool _showControl = true;
  bool get showControl => _showControl;

  toggleShowControl(bool val) {
    _showControl = val;

    notifyListeners();
  }

  final BackgroundService _backgroundService = BackgroundService();

  late String _text = _backgroundService.text;
  String get text => _text;

  changeText(String text) {
    _text = text;
    changeCode();
    notifyListeners();
    _backgroundService.changeText(text);
  }

  clearText() {
    _text = '';
    changeCode();
    notifyListeners();
    _backgroundService.changeText('');
  }

  late GradientItem _gradient = _backgroundService.gradient;
  GradientItem get gradient => _gradient;
  List<GradientItem> get gradients => _backgroundService.gradients;

  changleGradient(GradientItem item) {
    _gradient = item;
    changeCode();
    _backgroundService.changleGradient(item);
    notifyListeners();
  }

  late String _code = _backgroundService.code;
  String get code => _code;

  changeCode() {
    _code = '''
      Container(
        alignment: Alignment.topCenter,
        constraints: BoxConstraints.tightForFinite(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: ${gradient.colors},
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 300.0),
          padding: const EdgeInsets.symmetric(horizontal: 100.0),
          child: Text(
            '$text',
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 40.0),
          ),
        ),
      ),
    ''';
    notifyListeners();
    _backgroundService.setCode(_code);
  }
}
