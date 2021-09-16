import '../exports.dart';

class BackgroundState {
  String text;
  String pattern;
  List<Color> colors;
  String code;

  BackgroundState({
    this.text = '',
    this.pattern = '',
    this.colors = const [],
    this.code = '',
  });
}
