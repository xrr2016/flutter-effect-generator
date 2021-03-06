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
import './chart_type.dart';

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
          title: widget.controller.title,
          theme: widget.controller.theme,
          series: widget.controller.series,
        );
      // case ChartType.gauge:
      //   return GuageChart(
      //     title: _chartTitle(),
      //     data: widget.controller.datas[0],
      //   );
      // case ChartType.wave:
      //   return WaveChart(
      //     title: _chartTitle(),
      //     data: widget.controller.datas[0],
      //   );
      // case ChartType.calenderHeatMap:
      //   return CalenderHeatMap(
      //     title: _chartTitle(),
      //     data: widget.controller.datas[0].isEmpty ? [] : widget.controller.datas[0],
      //   );
      case ChartType.treeMap:
        return TreeMap(
          title: widget.controller.title,
          data: widget.controller.datas[0],
          theme: widget.controller.theme,
        );
      case ChartType.pie:
        return PieChart(
          title: widget.controller.title,
          data: widget.controller.datas[0],
        );
      case ChartType.radar:
        return RadarChart(
          title: Text('111'),
          datas: [
            [
              DataItem(name: '??????', value: 80.0),
              DataItem(name: '??????', value: 70.0),
              DataItem(name: '??????', value: 60.0),
              DataItem(name: '??????', value: 50.0),
              DataItem(name: '??????', value: 90.0),
              DataItem(name: '??????', value: 80.0),
            ],
            [
              DataItem(name: '??????', value: 50.0),
              DataItem(name: '??????', value: 90.0),
              DataItem(name: '??????', value: 30.0),
              DataItem(name: '??????', value: 70.0),
              DataItem(name: '??????', value: 60.0),
              DataItem(name: '??????', value: 40.0),
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
          features: ['????????????', '????????????', '????????????', '??????????????????', '????????????', '????????????'],
        );
      case ChartType.donut:
        return DonutCahrt(
          title: widget.controller.title,
          data: widget.controller.datas[0],
        );
      case ChartType.column:
        return ColumnChart(
          title: widget.controller.title,
          data: widget.controller.datas[0],
        );
      // case ChartType.timeSheet:
      //   return TimeSheet(
      //     title: _chartTitle(),
      //     startDate: DateTime(1949),
      //     endDate: DateTime(2021),
      //     events: widget.controller.events,
      //   );
      case ChartType.line:
        return LineChart(
          title: widget.controller.title,
          datas: widget.controller.datas,
          theme: widget.controller.theme,
        );
      case ChartType.curve:
        return CurveChart(
          title: widget.controller.title,
          data: widget.controller.datas[0],
        );
      case ChartType.bar:
        return BarChart(
          title: widget.controller.title,
          data: widget.controller.datas[0],
        );
      default:
        return SizedBox.shrink();
    }
  }

  Widget _renderhart() {
    Widget chart = AspectRatio(
      aspectRatio: 16.0 / 9.0,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xffe7e7e7),
            width: 1.0,
          ),
          // color: Color(0xffefeeee),
          borderRadius: BorderRadius.circular(2),
          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   colors: [
          //     Color(0xffefeeee),
          //     Color(0xffefeeee),
          //   ],
          // ),
          boxShadow: [
            // BoxShadow(
            //   color: Color(0xffffffff),
            //   offset: Offset(-20.0, -20.0),
            //   blurRadius: 30,
            //   spreadRadius: 0.0,
            // ),
            // BoxShadow(
            //   color: Color(0xffd1d0d0),
            //   offset: Offset(20.0, 20.0),
            //   blurRadius: 30,
            //   spreadRadius: 0.0,
            // ),
          ],
        ),
        child: _renderChart(),
      ),
    );

    widget.controller.image = chart;
    return chart;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, Widget? child) {
        return Container(
          width: 960.0,
          margin: EdgeInsets.only(top: 60.0),
          alignment: Alignment.topCenter,
          child: _renderhart(),
        );
      },
    );
  }
}
