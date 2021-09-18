import '../../exports.dart';

class GradientItem {
  const GradientItem({
    required this.name,
    required this.colors,
  });

  final String name;
  final List<Color> colors;

  GradientItem copyWith({
    required String name,
    required List<Color> colors,
  }) =>
      GradientItem(name: name, colors: colors);

  factory GradientItem.fromRawJson(String str) => GradientItem.fromJson(
        json.decode(str),
      );

  String toRawJson() => json.encode(toJson());

  factory GradientItem.fromJson(Map<String, dynamic> json) => GradientItem(
        name: json['name'],
        colors: List<Color>.from(
          json['colors'].map((x) => fromCssColor(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'colors': List<dynamic>.from(
          colors.map((x) => x),
        ),
      };
}
