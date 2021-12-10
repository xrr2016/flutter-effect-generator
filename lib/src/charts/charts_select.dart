import '../exports.dart';
import './charts_controller.dart';

class ChartsSelect extends StatefulWidget {
  final ChartsController controller;

  const ChartsSelect({Key? key, required this.controller}) : super(key: key);

  @override
  _ChartsSelectState createState() => _ChartsSelectState();
}

class _ChartsSelectState extends State<ChartsSelect> {
  List<Widget> _renderChartNames() {
    return List.generate(
      ChartType.values.length,
      (index) {
        if (ChartType.values[index] == widget.controller.chartType) {
          return Container(
            width: 160.0,
            height: 60.0,
            margin: EdgeInsets.only(bottom: 10.0),
            color: Color(0xffefeeee),
            alignment: Alignment.center,
            transformAlignment: Alignment.center,
            child: Container(
              color: Color(0xffefeeee),
              child: Container(
                width: 200.0,
                height: 80.0,
                alignment: Alignment.center,
                child: Text(
                  ChartType.values[index].name,
                  style: TextStyle(color: Colors.black),
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
                      offset: Offset(-5.0, -5.0),
                      blurRadius: 12,
                      spreadRadius: 0.0,
                    ),
                    BoxShadow(
                      color: Color(0xffd1d0d0),
                      offset: Offset(5.0, 5.0),
                      blurRadius: 12,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return InkWell(
          onTap: () {
            widget.controller.changeChartType(ChartType.values[index]);
          },
          child: Container(
            width: 160.0,
            height: 60.0,
            margin: EdgeInsets.only(bottom: 10.0),
            alignment: Alignment.center,
            child: Text(
              ChartType.values[index].name,
              style: TextStyle(color: Colors.black),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240.0,
      color: Color(0xffefeeee),
      child: ListView(
        padding: EdgeInsets.all(10.0),
        children: _renderChartNames(),
      ),
    );
  }
}
