import '../exports.dart';
import './models/data_item.dart';
import './models/event_item.dart';

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
  gauge,
  wave,
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
      case ChartType.gauge:
        return '仪表盘';
      case ChartType.wave:
        return '波浪图';
      default:
        return '';
    }
  }
}

final List<EventItem> _events = [
  EventItem(
    start: DateTime(1949),
    end: DateTime(1950),
    title: '新中国成立',
  ),
  EventItem(
    start: DateTime(1959),
    end: DateTime(1980),
    title: '啦啦啦啦啦',
  ),
  EventItem(
    start: DateTime(1978),
    end: DateTime(1982),
    title: '啦啦啦啦啦',
  ),
  EventItem(
    start: DateTime(1985),
    end: DateTime(1990),
    title: '啦啦啦啦啦',
  ),
  EventItem(
    start: DateTime(1955),
    end: DateTime(1993),
    title: '啦啦啦啦啦',
  ),
  EventItem(
    start: DateTime(1981),
    end: DateTime(1993),
    title: '啦啦啦啦啦',
  ),
  EventItem(
    start: DateTime(1986),
    end: DateTime(1999),
    title: '啦啦啦啦啦',
  ),
  EventItem(
    start: DateTime(1966),
    end: DateTime(2000),
    title: '啦啦啦啦啦',
  ),
  EventItem(
    start: DateTime(1958),
    end: DateTime(2004),
    title: '啦啦啦啦啦',
  ),
  EventItem(
    start: DateTime(2000),
    end: DateTime(2014),
    title: '啦啦啦啦啦',
  ),
  EventItem(
    start: DateTime(2002),
    end: DateTime(2014),
    title: '啦啦啦啦啦',
  ),
  EventItem(
    start: DateTime(1976),
    end: DateTime(2016),
    title: '啦啦啦啦啦',
  ),
  EventItem(
    start: DateTime(2019),
    end: DateTime(2021),
    title: '新冠疫情',
  ),
];

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

  List<EventItem> get events => _events;
}
