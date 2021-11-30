import '../exports.dart';
import './charts_controller.dart';
import './tree_map/tree_map.dart';
import './bar_chart/bar_chart.dart';
import './column_chart/column_chart.dart';
import './line_chart/line_chart.dart';
import './donut_chart/donut_chart.dart';
import './radar_chart/radar_chart.dart';
import './pie_chart/pie_chart.dart';
import './area_chart/area_chart.dart';
import './time_sheet/time_sheet.dart';
import './calender_heatmap/calendar_heatmap.dart';
import './models/data_item.dart';

class ChartsView extends StatefulWidget {
  static const routeName = '/charts';

  const ChartsView({Key? key}) : super(key: key);

  @override
  State<ChartsView> createState() => _ChartsViewState();
}

class _ChartsViewState extends State<ChartsView> {
  final ChartsController _chartsController = ChartsController();
  final List<double> _datas = [30.0, 200.0, 100.0, 400.0, 150.0, 250.0];

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

  List<Widget> _renderChartNames() {
    return List.generate(
      ChartType.values.length,
      (index) => CheckboxListTile(
        value: ChartType.values[index] == _chartsController.chartType,
        onChanged: (checked) {
          _chartsController.changeChartType(ChartType.values[index]);
        },
        title: Text(
          ChartType.values[index].name,
          style: TextStyle(color: Colors.white),
        ),
        contentPadding: EdgeInsets.all(10.0),
        selected: ChartType.values[index] == _chartsController.chartType,
      ),
    );
  }

  Widget _renderChart() {
    switch (_chartsController.chartType) {
      case ChartType.area:
        return AreaChart(
          datas: [120.0, 90.0, 80.0, 60.0, 108.0],
          // xAxis: ['一月', '二月', '三月', '四月', '五月'],
        );
      case ChartType.calenderHeatMap:
        return CalenderHeatMap(datas: _datas);
      case ChartType.treeMap:
        return TreeMap(datas: _datas);
      case ChartType.pie:
        return PieChart(
          datas: [60.0, 50.0, 40.0, 80.0, 90.0],
          legends: ['一月', '二月', '三月', '四月', '五月'],
        );
      case ChartType.radar:
        return RadarChart(
          datas: [
            [60.0, 70.0, 80.0, 30.0, 70.0, 80.0],
            [80.0, 50.0, 60.0, 80.0, 40.0, 90.0],
            [40.0, 70.0, 90.0, 50.0, 60.0, 80.0],
          ],
          scores: [60.0, 70.0, 80.0, 90.0],
          features: ['学习能力', '英语水平', '编码能力', '解决问题能力', '工作态度', '沟通能力'],
        );
      case ChartType.donut:
        return DonutCahrt(
          datas: [
            {
              'name': '青年',
              'value': 90.0,
            },
            {
              'name': '少年',
              'value': 40.0,
            },
            {
              'name': '老年',
              'value': 120.0,
            },
            {
              'name': '幼年',
              'value': 200.0,
            },
          ],
        );
      case ChartType.column:
        return ColumnChart(
          datas: List.generate(
            _datas.length,
            (index) => DataItem(name: '$index 月', value: _datas[index]),
          ),
          title: Text(
            '游客访问量 - 2040年',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        );
      case ChartType.timeSheet:
        return TimeSheet(
          startDate: DateTime(1949),
          endDate: DateTime(2021),
          events: [],
        );
      case ChartType.line:
        return LineChart(
          datas: _datas,
          xAxis: ['一月', '二月', '三月', '四月', '五月'],
        );
      case ChartType.bar:
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
      body: AnimatedBuilder(
        animation: _chartsController,
        builder: (context, Widget? child) {
          return Container(
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 200.0,
                  color: Colors.blueAccent,
                  child: ListView(
                    padding: EdgeInsets.all(10.0),
                    children: _renderChartNames(),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SizedBox(
                      child: _renderChart(),
                      width: 720.0,
                      height: 720.0,
                    ),
                  ),
                ),
                Container(
                  width: 200.0,
                  color: Colors.blueAccent,
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
          );
        },
      ),
    );
  }
}
