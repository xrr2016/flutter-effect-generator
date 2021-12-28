import '../exports.dart';
import './charts_select.dart';
import './charts_render.dart';
import './charts_input.dart';
import './charts_controller.dart';

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
          const SizedBox(width: 10.0),
          IconButton(
            onPressed: _chartsController.downloadImage,
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
      backgroundColor: Color(0xffefeeee),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ChartsSelect(controller: _chartsController),
          ChartsRender(controller: _chartsController),
          ChartsInput(controller: _chartsController),
        ],
      ),
    );
  }
}
