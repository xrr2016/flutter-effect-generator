import '../exports.dart';
import './charts_controller.dart';

/// charts
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
import './guage/guage_chart.dart';
import './wave/wave_chart.dart';

class ChartsRender extends StatefulWidget {
  final ChartsController controller;

  const ChartsRender({Key? key, required this.controller}) : super(key: key);

  @override
  _ChartsRenderState createState() => _ChartsRenderState();
}

class _ChartsRenderState extends State<ChartsRender> {
  Widget _renderChart() {
    switch (widget.controller.chartType) {
      case ChartType.area:
        return AreaChart(
          data: widget.controller.datas,
          title: Text(
            '游客访问量 - 2040年',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        );
      case ChartType.gauge:
        return GuageChart(
          data: widget.controller.datas,
          title: Text(
            '制作进度 - 2040年',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        );
      case ChartType.wave:
        return WaveChart(
          data: widget.controller.datas,
          title: Text(
            '制作进度 - 2040年',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        );
      case ChartType.calenderHeatMap:
        return SizedBox(
          width: 1200.0,
          height: 300.0,
          child: CalenderHeatMap(
            data:
                widget.controller.datas.isEmpty ? [] : widget.controller.datas,
            title: Text(
              '提交记录 - 2021年',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        );
      case ChartType.treeMap:
        return TreeMap(
          data: widget.controller.datas,
          title: Text(
            '商品产量比例 - 2020年',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        );
      case ChartType.pie:
        return PieChart(
          data: widget.controller.datas,
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
          data: widget.controller.datas,
          title: Text(
            '商品产量比例 - 2020年',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        );
      case ChartType.column:
        return ColumnChart(
          data: widget.controller.datas,
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
            events: widget.controller.events,
            title: Text(
              '1949-2021 大事记',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        );
      case ChartType.line:
        return LineChart(
          data: widget.controller.datas,
          title: Text(
            '产品销售量-2022年',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        );
      case ChartType.curve:
        return CurveChart(
          data: widget.controller.datas,
          title: Text(
            '产品销售量-2022年',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        );
      case ChartType.bar:
        return BarChart(
          data: widget.controller.datas,
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
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, Widget? child) {
        return Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 80.0),
            alignment: Alignment.topCenter,
            child: Container(
              width: 960.0,
              height: 640.0,
              child: _renderChart(),
              decoration: BoxDecoration(
                color: Color(0xffefeeee),
                borderRadius: BorderRadius.circular(5),
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
        );
      },
    );
  }
}
