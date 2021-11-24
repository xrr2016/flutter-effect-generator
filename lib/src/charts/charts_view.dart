import '../exports.dart';
import './tree_map/tree_map.dart';

class ChartsView extends StatelessWidget {
  static const routeName = '/charts';

  const ChartsView({Key? key}) : super(key: key);

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
                child: Column(
                  children: [],
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    width: 500.0,
                    height: 500.0,
                    color: Colors.blue,
                    child: TreeMap(datas: [2, 10, 4, 3, 7, 5, 9, 8, 1, 6, 9]),
                  ),
                ),
              ),
              Container(
                width: 200.0,
                color: Colors.pink,
                child: Column(
                  children: [],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
