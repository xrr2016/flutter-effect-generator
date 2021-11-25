import '../exports.dart';
import './tree_map/tree_map.dart';
import './bar_chart/bar_chart.dart';
import './column_chart/column_chart.dart';

class ChartsView extends StatefulWidget {
  static const routeName = '/charts';

  const ChartsView({Key? key}) : super(key: key);

  @override
  State<ChartsView> createState() => _ChartsViewState();
}

class _ChartsViewState extends State<ChartsView> {
  String _currentChart = '矩形树图';
  final List<String> _charts = [
    '矩形树图',
    '柱状图',
    '折线图',
    '条形图',
    '雷达图',
    '饼图',
    '环图',
    '区域图',
    '热力图',
  ];
  final List<double> _datas = [2, 10, 4, 3, 7, 5, 9, 8, 1, 6, 9];

  List<Widget> _renderDatas() {
    return List.generate(
      _datas.length,
      (index) => TextField(
        maxLength: 3,
        controller: TextEditingController(
          text: _datas[index].toString(),
        ),
        onChanged: (val) {
          _datas[index] = double.tryParse(val) ?? 0.0;
          setState(() {});
        },
        style: TextStyle(
          color: Colors.white,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  List<Widget> _renderCharts() {
    return List.generate(
      _charts.length,
      (index) => CheckboxListTile(
        value: _currentChart == _charts[index],
        onChanged: (checked) {
          setState(() {
            _currentChart = _charts[index];
          });
        },
        title: Text(
          _charts[index],
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _renderChart() {
    switch (_currentChart) {
      case '矩形树图':
        return TreeMap(datas: _datas);
      case '柱状图':
        return ColumnChart(
          data: [180.0, 98.0, 126.0, 64.0, 118.0],
          xAxis: ['一月', '二月', '三月', '四月', '五月'],
        );
      case '条形图':
        return BarChart(
          data: [
            {
              'label': '中国',
              'value': 2800.0,
            },
            {
              'label': '印度',
              'value': 3000.0,
            },
            {
              'label': '美国',
              'value': 2200.0,
            },
            {
              'label': '巴西',
              'value': 3800.0,
            },
            {
              'label': '法国',
              'value': 5200.0,
            },
          ],
          max: 6000,
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
      ),
      body: Container(
        color: Colors.amber,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 200.0,
              color: Colors.blue,
              child: ListView(
                padding: EdgeInsets.all(10.0),
                children: _renderCharts(),
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: 500.0,
                  height: 500.0,
                  child: _renderChart(),
                ),
              ),
            ),
            Container(
              width: 200.0,
              color: Colors.pink,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.all(10.0),
                      children: _renderDatas(),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.add))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
