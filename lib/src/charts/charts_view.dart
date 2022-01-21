import './base_chart.dart';
import './chart_type.dart';
import '../exports.dart';
import './charts_select.dart';
import './charts_render.dart';
import './charts_input.dart';
import './charts_controller.dart';
import 'colors.dart';

class ChartsView extends StatefulWidget {
  static const routeName = '/charts';

  const ChartsView({Key? key}) : super(key: key);

  @override
  State<ChartsView> createState() => _ChartsViewState();
}

class _ChartsViewState extends State<ChartsView> {
  final ChartsController _chartsController = ChartsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _chartsController.toggleTheme,
            icon: const Icon(Icons.dark_mode),
          ),
          const SizedBox(width: 10.0),
          IconButton(
            onPressed: _chartsController.downloadImage,
            icon: const Icon(Icons.download),
          ),
          const SizedBox(width: 10.0),
        ],
        backgroundColor: backgroundColor,
        centerTitle: true,
        elevation: 0.0,
        foregroundColor: Colors.black,
        title: Text('Charts'),
      ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                BaseChart(
                  width: 480.0,
                  height: 360.0,
                  type: ChartType.radar,
                  title: '程序员能力组成',
                  theme: _chartsController.theme,
                  series: _chartsController.series,
                  xaxis: ['学习能力', '英语水平', '编码能力', '解决问题能力', '工作态度', '沟通能力'],
                  yaxis: ['100.0', '200.0', '300.0', '400.0', '500.0'],
                ),
                BaseChart(
                  width: 480.0,
                  height: 360.0,
                  type: ChartType.donut,
                  title: '2022 上半年游客组成',
                  theme: _chartsController.theme,
                  series: _chartsController.series,
                  datas: _chartsController.datas[0],
                  xaxis: ['1月', '2月', '3月', '4月', '5月', '6月'],
                  yaxis: ['0', '100', '200', '300', '400', '500'],
                ),
                BaseChart(
                  width: 480.0,
                  height: 360.0,
                  type: ChartType.pie,
                  title: '2022 上半年游客组成',
                  theme: _chartsController.theme,
                  series: _chartsController.series,
                  datas: _chartsController.datas[0],
                  xaxis: ['1月', '2月', '3月', '4月', '5月', '6月'],
                  yaxis: ['0', '100', '200', '300', '400', '500'],
                ),
                BaseChart(
                  width: 480.0,
                  height: 360.0,
                  type: ChartType.area,
                  title: '2022 上半年游客统计表',
                  theme: _chartsController.theme,
                  series: _chartsController.series,
                  xaxis: ['1月', '2月', '3月', '4月', '5月', '6月'],
                  yaxis: ['0', '100', '200', '300', '400', '500'],
                ),
                BaseChart(
                  width: 480.0,
                  height: 360.0,
                  type: ChartType.column,
                  title: '2022 上半年游客统计表',
                  theme: _chartsController.theme,
                  series: _chartsController.series,
                  xaxis: ['1月', '2月', '3月', '4月', '5月', '6月'],
                  yaxis: ['0', '100', '200', '300', '400', '500'],
                ),
                BaseChart(
                  width: 480.0,
                  height: 360.0,
                  type: ChartType.curve,
                  title: '2022 上半年游客统计表',
                  theme: _chartsController.theme,
                  series: _chartsController.series,
                  xaxis: ['1月', '2月', '3月', '4月', '5月', '6月'],
                  yaxis: ['0', '100', '200', '300', '400', '500'],
                ),
                BaseChart(
                  width: 480.0,
                  height: 360.0,
                  type: ChartType.line,
                  title: '2022 上半年游客统计表',
                  theme: _chartsController.theme,
                  series: _chartsController.series,
                  xaxis: ['1月', '2月', '3月', '4月', '5月', '6月'],
                  yaxis: ['0', '100', '200', '300', '400', '500'],
                ),
                BaseChart(
                  width: 480.0,
                  height: 360.0,
                  type: ChartType.bar,
                  title: '2022 上半年游客统计表',
                  theme: _chartsController.theme,
                  series: _chartsController.series,
                  xaxis: ['1月', '2月', '3月', '4月', '5月', '6月'],
                  yaxis: ['0', '100', '200', '300', '400', '500'],
                ),

                // ChartsSelect(controller: _chartsController),
                // ChartsRender(controller: _chartsController),
                // ChartsInput(controller: _chartsController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
