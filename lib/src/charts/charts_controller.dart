import '../exports.dart';
import './models/data_item.dart';

enum ChartType {
  area,
  bar,
  column,
  calenderHeatMap,
  donut,
  line,
  curve,
  radar,
  pie,
  treeMap,
  timeSheet,
}

extension ChartTypeName on ChartType {
  String get name {
    switch (this) {
      case ChartType.area:
        return '面积图';
      case ChartType.bar:
        return '条形图';
      case ChartType.column:
        return '柱状图';
      case ChartType.donut:
        return '环图';
      case ChartType.line:
        return '折线图';
      case ChartType.curve:
        return '曲线图';
      case ChartType.radar:
        return '雷达图';
      case ChartType.pie:
        return '饼图';
      case ChartType.calenderHeatMap:
        return '日历热力图';
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
  ChartsController() {
    loadJson();
  }

  ChartType chartType = ChartType.timeSheet;
  void changeChartType(ChartType type) {
    chartType = type;
    notifyListeners();
  }

  List<DataItem> commits = [];

  List<DataItem> _parseGradients(String data) {
    final jsonResult = json.decode(data) as List;
    return jsonResult.map((json) => DataItem.fromJson(json)).toList();
  }

  loadJson() async {
    try {
      String data = await rootBundle.loadString('assets/data/commits.json');
      commits = await compute(_parseGradients, data);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
