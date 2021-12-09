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
// import '../components/grid_brackground.dart';
import './curve_chart/curve_chart.dart';

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
          style: TextStyle(color: Colors.black),
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
        return CalenderHeatMap(datas: _datas);
      case ChartType.treeMap:
        return TreeMap(datas: _datas);
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
            [60.0, 70.0, 80.0, 30.0, 70.0, 80.0],
            [80.0, 50.0, 60.0, 80.0, 40.0, 90.0],
            [40.0, 70.0, 90.0, 50.0, 60.0, 80.0],
          ],
          scores: [60.0, 70.0, 80.0, 90.0],
          features: ['学习能力', '英语水平', '编码能力', '解决问题能力', '工作态度', '沟通能力'],
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
        return TimeSheet(
          startDate: DateTime(1949),
          endDate: DateTime(2021),
          events: [],
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        foregroundColor: Colors.black,
        title: Text('Charts'),
        backgroundColor: Color(0xffefeeee),
        elevation: 1.0,
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
                  color: Color(0xffefeeee),
                  child: ListView(
                    padding: EdgeInsets.all(10.0),
                    children: _renderChartNames(),
                  ),
                ),
                VerticalDivider(
                  width: 1.0,
                  color: Colors.grey,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(100.0),
                    color: Color(0xffefeeee),
                    alignment: Alignment.center,
                    transformAlignment: Alignment.center,
                    child: Container(
                      color: Color(0xffefeeee),
                      child: Container(
                        child: Center(
                          child: SizedBox(
                            width: 720,
                            height: 640,
                            child: _renderChart(),
                          ),
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
                VerticalDivider(
                  width: 1.0,
                  color: Colors.grey,
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


      // Container(
      //   width: 500.0,
      //   height: 500.0,
      //   color: Color(0xffefeeee),
      //   alignment: Alignment.center,
      //   transformAlignment: Alignment.center,
      //   child: Container(
      //     color: Color(0xffefeeee),
      //     child: Container(
      //       width: 200,
      //       height: 200,
      //       child: Icon(
      //         Icons.star,
      //         size: 67,
      //         color: Colors.amber,
      //       ),
      //       decoration: BoxDecoration(
      //         color: Color(0xffefeeee),
      //         borderRadius: BorderRadius.circular(10),
      //         gradient: LinearGradient(
      //           begin: Alignment.topLeft,
      //           end: Alignment.bottomRight,
      //           colors: [
      //             Color(0xffefeeee),
      //             Color(0xffefeeee),
      //           ],
      //         ),
      //         boxShadow: [
      //           BoxShadow(
      //             color: Color(0xffffffff),
      //             offset: Offset(-20.0, -20.0),
      //             blurRadius: 30,
      //             spreadRadius: 0.0,
      //           ),
      //           BoxShadow(
      //             color: Color(0xffd1d0d0),
      //             offset: Offset(20.0, 20.0),
      //             blurRadius: 30,
      //             spreadRadius: 0.0,
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // )
  