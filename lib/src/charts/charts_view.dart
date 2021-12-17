import '../exports.dart';
import './charts_select.dart';
import './charts_controller.dart';
import './tree_map/tree_map.dart';
import './bar/bar_chart.dart';
import './column/column_chart.dart';
import './line/line_chart.dart';
import './donut/donut_chart.dart';
import './radar/radar_chart.dart';
import './pie/pie_chart.dart';
import './area/area_chart.dart';
import './time_sheet/time_sheet.dart';
import './calender_heatmap/calendar_heatmap.dart';
import './models/data_item.dart';
import './curve/curve_chart.dart';

class ChartsView extends StatefulWidget {
  static const routeName = '/charts';

  const ChartsView({Key? key}) : super(key: key);

  @override
  State<ChartsView> createState() => _ChartsViewState();
}

class _ChartsViewState extends State<ChartsView> {
  final ChartsController _chartsController = ChartsController();
  final List<double> _datas = [30.0, 200.0, 100.0, 300.0, 350.0, 350.0];

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
          color: Colors.black,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget _renderChart() {
    switch (_chartsController.chartType) {
      case ChartType.area:
        return AreaChart(
          data: List.generate(
            _datas.length,
            (index) => DataItem(name: '${index + 1} 月', value: _datas[index]),
          ),
          title: Text(
            '游客访问量 - 2040年',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        );
      case ChartType.calenderHeatMap:
        return SizedBox(
          width: 1200.0,
          height: 300.0,
          child: CalenderHeatMap(
            data: _chartsController.commits.isEmpty
                ? []
                : _chartsController.commits,
            title: Text(
              '提交记录 - 2021年',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        );
      case ChartType.treeMap:
        return TreeMap(
          data: List.generate(
            _datas.length,
            (index) => DataItem(name: '${index + 1} 月', value: _datas[index]),
          ),
          title: Text(
            '商品产量比例 - 2020年',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        );
      case ChartType.pie:
        return PieChart(
          data: List.generate(
            _datas.length,
            (index) => DataItem(name: '${index + 1} 月', value: _datas[index]),
          ),
          title: Text(
            '商品产量比例 - 2020年',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        );
      case ChartType.radar:
        return RadarChart(
          datas: [
            [
              DataItem(name: '小明', value: 80.0),
              DataItem(name: '小明', value: 70.0),
              DataItem(name: '小明', value: 60.0),
              DataItem(name: '小明', value: 50.0),
              DataItem(name: '小明', value: 90.0),
              DataItem(name: '小明', value: 80.0),
            ],
            [
              DataItem(name: '小林', value: 50.0),
              DataItem(name: '小林', value: 90.0),
              DataItem(name: '小林', value: 30.0),
              DataItem(name: '小林', value: 70.0),
              DataItem(name: '小林', value: 60.0),
              DataItem(name: '小林', value: 40.0),
            ],
          ],
          scores: [
            10.0,
            20.0,
            30.0,
            40.0,
            50.0,
            60.0,
            70.0,
            80.0,
            90.0,
            100.0,
          ],
          features: ['学习能力', '英语水平', '编码能力', '解决问题能力', '工作态度', '沟通能力'],
          title: Text(
            '个人能力雷达图',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        );
      case ChartType.donut:
        return DonutCahrt(
          data: List.generate(
            _datas.length,
            (index) => DataItem(name: '${index + 1} 月', value: _datas[index]),
          ),
          title: Text(
            '商品产量比例 - 2020年',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        );
      case ChartType.column:
        return ColumnChart(
          data: List.generate(
            _datas.length,
            (index) => DataItem(name: '${index + 1} 月', value: _datas[index]),
          ),
          title: Text(
            '游客访问量 - 2040年',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        );
      case ChartType.timeSheet:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 120.0),
          child: TimeSheet(
            startDate: DateTime(1949),
            endDate: DateTime(2021),
            events: _chartsController.events,
            title: Text(
              '1949-2021 大事记',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        );
      case ChartType.line:
        return LineChart(
          data: List.generate(
            _datas.length,
            (index) => DataItem(name: '${index + 1} 月', value: _datas[index]),
          ),
          title: Text(
            '产品销售量-2022年',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        );
      case ChartType.curve:
        return CurveChart(
          data: List.generate(
            _datas.length,
            (index) => DataItem(name: '${index + 1} 月', value: _datas[index]),
          ),
          title: Text(
            '产品销售量-2022年',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        );
      case ChartType.bar:
        return BarChart(
          data: List.generate(
            _datas.length,
            (index) => DataItem(name: '产品 ${index + 1}', value: _datas[index]),
          ),
          title: Text(
            '产品销售量 - 2020年',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        );
      default:
        return Container();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          const SizedBox(width: 10.0),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.download),
          ),
          const SizedBox(width: 10.0),
        ],
        backgroundColor: Color(0xffefeeee),
        centerTitle: true,
        elevation: 0.0,
        foregroundColor: Colors.black,
        title: Text('Charts'),
      ),
      body: AnimatedBuilder(
        animation: _chartsController,
        builder: (context, Widget? child) {
          return Container(
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ChartsSelect(controller: _chartsController),
                Expanded(
                  child: Container(
                    color: Color(0xffefeeee),
                    child: Container(
                      color: Color(0xffefeeee),
                      margin: EdgeInsets.only(
                        top: 50.0,
                        left: 100.0,
                        right: 100.0,
                        bottom: 200.0,
                      ),
                      child: Container(
                        child: Center(
                          child: _renderChart(),
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffefeeee),
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xffefeeee),
                              Color(0xffefeeee),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffffffff),
                              offset: Offset(-20.0, -20.0),
                              blurRadius: 30,
                              spreadRadius: 0.0,
                            ),
                            BoxShadow(
                              color: Color(0xffd1d0d0),
                              offset: Offset(20.0, 20.0),
                              blurRadius: 30,
                              spreadRadius: 0.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 200.0,
                  color: Color(0xffefeeee),
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
