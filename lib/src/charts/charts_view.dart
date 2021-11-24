import '../exports.dart';
import './tree_map/tree_map.dart';

class ChartsView extends StatefulWidget {
  static const routeName = '/charts';

  const ChartsView({Key? key}) : super(key: key);

  @override
  State<ChartsView> createState() => _ChartsViewState();
}

class _ChartsViewState extends State<ChartsView> {
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
      (index) => ListTile(
        title: Text(
          _charts[index],
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(builder: (context, BoxConstraints constraints) {
        return Container(
          height: constraints.maxHeight,
          // constraints: BoxConstraints.tightForFinite(),
          color: Colors.amber,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 200.0,
                color: Colors.purple,
                child: Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(10.0),
                    children: _renderCharts(),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    width: 500.0,
                    height: 500.0,
                    color: Colors.blue,
                    child: TreeMap(datas: _datas),
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
        );
      }),
    );
  }
}
