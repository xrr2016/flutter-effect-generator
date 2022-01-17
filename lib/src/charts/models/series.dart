import '../chart_type.dart';

class Series {
  String name;
  ChartType type;
  List<double> data;

  Series({
    required this.name,
    required this.data,
    required this.type,
  });
}
