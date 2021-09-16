import '../exports.dart';

Color getAdjustColor(Color baseColor, int amount) {
  Map colors = {
    "red": baseColor.red,
    "green": baseColor.green,
    "blue": baseColor.blue
  };
  colors = colors.map((key, value) {
    if (value + amount < 0) return MapEntry(key, 0);
    if (value + amount > 255) return MapEntry(key, 255);
    return MapEntry(key, value + amount);
  });
  return Color.fromRGBO(colors["red"], colors["green"], colors["blue"], 1);
}

List<Color> getFlatGradients(baseColor, depth) {
  return [
    baseColor,
    baseColor,
  ];
}

List<Color> getConcaveGradients(baseColor, depth) {
  return [
    getAdjustColor(baseColor, -depth),
    getAdjustColor(baseColor, depth),
  ];
}

List<Color> getConvexGradients(baseColor, depth) {
  return [
    getAdjustColor(baseColor, depth),
    getAdjustColor(baseColor, -depth),
  ];
}
