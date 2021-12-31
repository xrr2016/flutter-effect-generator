import 'dart:typed_data';
import 'package:universal_html/html.dart' as html;

import '../exports.dart';
import './models/data_item.dart';
import './models/event_item.dart';
import './chart_type.dart';
import './colors.dart';

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

final _datas1 = [
  DataItem(name: '1月', value: 300.0),
  DataItem(name: '2月', value: 260.0),
  DataItem(name: '3月', value: 240.0),
  DataItem(name: '4月', value: 390.0),
  DataItem(name: '5月', value: 439.0),
  DataItem(name: '6月', value: 280.0),
  DataItem(name: '7月', value: 356.0),
  DataItem(name: '8月', value: 378.0),
];

final _datas2 = [
  DataItem(name: '1月', value: 220.0),
  DataItem(name: '2月', value: 200.0),
  DataItem(name: '3月', value: 280.0),
  DataItem(name: '4月', value: 310.0),
  DataItem(name: '5月', value: 520.0),
  DataItem(name: '6月', value: 480.0),
  DataItem(name: '7月', value: 300.0),
  DataItem(name: '8月', value: 208.0),
];

final _datas3 = [
  DataItem(name: '1月', value: 120.0),
  DataItem(name: '2月', value: 500.0),
  DataItem(name: '3月', value: 320.0),
  DataItem(name: '4月', value: 420.0),
  DataItem(name: '5月', value: 120.0),
  DataItem(name: '6月', value: 340.0),
  DataItem(name: '7月', value: 220.0),
  DataItem(name: '8月', value: 108.0),
];

class ChartsController extends ChangeNotifier {
  ChartType chartType = ChartType.area;

  void changeChartType(ChartType type) {
    chartType = type;
    // if (chartType == ChartType.calenderHeatMap) {
    //   loadJson();
    // } else {
    datas = [_datas1, _datas2, _datas3];
    // }
    notifyListeners();
  }

  List<Color> theme = themes[0];

  void changeChartTheme(int index) {
    theme = themes[index];
    notifyListeners();
  }

  List<List<DataItem>> datas = [_datas1, _datas2, _datas3];

  addDataList() {
    if (datas.length > 4) {
      return;
    }
    List<DataItem> list = List.generate(
      datas[0].length,
      (index) {
        return DataItem(
          name: datas[0][index].name,
          value: Random().nextInt(datas[0][index].value.toInt()).toDouble(),
        );
      },
    );

    datas.add(list);
    notifyListeners();
  }

  removeDataList(int index) {
    if (datas.length < 2) {
      return;
    }
    datas.removeAt(index);
    notifyListeners();
  }

  changeItemValue(int arrIndex, int dataIndex, double val) {
    debugPrint('arrIndex: ' + arrIndex.toString());
    debugPrint('dataIndex: ' + dataIndex.toString());
    datas[arrIndex][dataIndex].value = val;
    notifyListeners();
  }

  changeItemName(int dataIndex, String val) {
    for (List<DataItem> list in datas) {
      list[dataIndex].name = val;
    }
    notifyListeners();
  }

  addDataItem(String name, double value) {
    for (List<DataItem> list in datas) {
      list.add(DataItem(name: name, value: value));
    }
    notifyListeners();
  }

  removeDataItem(int arrIndex, int index) {
    datas[arrIndex].removeAt(index);
    notifyListeners();
  }

  String title = '游客访问量 - 2040年';

  changeChartTitle(String val) {
    title = val;
    notifyListeners();
  }

  loadJson() async {
    try {
      String data = await rootBundle.loadString('assets/data/commits.json');
      final _list = await compute(_parseGradients, data);
      datas.add(_list);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  List<DataItem> _parseGradients(String data) {
    final jsonResult = json.decode(data) as List;
    return jsonResult.map((json) => DataItem.fromJson(json)).toList();
  }

  List<EventItem> get events => _events;

  void _capturedImage(Uint8List image) async {
    final base64data = base64Encode(image);
    final a = html.AnchorElement(href: 'data:image/jpeg;base64,$base64data');
    a.download = 'Chart.jpg';
    a.click();
    a.remove();
  }

  void _catchError(e) {
    debugPrint(e.toString());
  }

  final ScreenshotController screenshotController = ScreenshotController();
  Widget image = SizedBox.shrink();

  void downloadImage() async {
    try {
      // final double pixelRatio = MediaQuery.of(context).devicePixelRatio;

      screenshotController
          .captureFromWidget(image)
          .then(_capturedImage)
          .catchError(_catchError);
    } catch (e) {
      _catchError(e);
    }
  }

  void toggleTheme() {
    notifyListeners();
  }
}
