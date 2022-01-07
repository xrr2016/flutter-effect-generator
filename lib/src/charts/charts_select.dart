import '../exports.dart';
import './charts_controller.dart';
import './chart_type.dart';

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
            height: 50.0,
            color: Color(0xffefeeee),
            alignment: Alignment.center,
            child: Container(
              // color: Color(0xffefeeee),
              color: Colors.amber,
              child: Container(
                height: 60.0,
                alignment: Alignment.center,
                child: Text(
                  ChartType.values[index].name,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                decoration: BoxDecoration(
                  // color: Color(0xffefeeee),
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5.0),
                    bottomRight: Radius.circular(5.0),
                  ),
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
            height: 50.0,
            alignment: Alignment.center,
            child: Text(
              ChartType.values[index].name,
              style: TextStyle(color: Colors.black54),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, Widget? child) {
        return Container(
          margin: EdgeInsets.only(top: 40.0),
          width: 180.0,
          child: ListView(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0, right: 20.0),
            children: _renderChartNames(),
          ),
        );
      },
    );
  }
}
