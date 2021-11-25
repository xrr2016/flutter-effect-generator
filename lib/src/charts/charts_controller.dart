import '../exports.dart';

enum ChartType {
  area,
  bar,
  column,
  donut,
  line,
  radar,
  pie,
  heatMap,
  treeMap,
  timeSheet,
}

extension ChartTypeName on ChartType {
  String get name {
    switch (this) {
      case ChartType.area:
        return '区域图';
      case ChartType.bar:
        return '条形图';
      case ChartType.column:
        return '柱状图';
      case ChartType.donut:
        return '区域图';
      case ChartType.line:
        return '折线图';
      case ChartType.radar:
        return '雷达图';
      case ChartType.pie:
        return '饼图';
      case ChartType.heatMap:
        return '热力图';
      case ChartType.treeMap:
        return '矩形树图';
      case ChartType.timeSheet:
        return '时序图';
      default:
        return '';
    }
  }
}

class ChartsController extends ChangeNotifier {
  ChartType chartType = ChartType.treeMap;

  void changeChartType(ChartType type) {
    chartType = type;
    debugPrint(chartType.name);
    notifyListeners();
  }
}
