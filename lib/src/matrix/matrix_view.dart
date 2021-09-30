import 'package:flutter/rendering.dart';

import '../exports.dart';
import './vertical_textline.dart';
import './matrix_patinter.dart';

class MatrixView extends StatefulWidget {
  static const routeName = '/matrix';

  const MatrixView({Key? key}) : super(key: key);

  @override
  State<MatrixView> createState() => _MatrixViewState();
}

class _MatrixViewState extends State<MatrixView> {
  late Timer _timer;
  final List<Widget> _verticalLines = [];

  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 300), (timer) {
      setState(() {
        _verticalLines.add(_getVerticalTextLine(context));
      });
    });
  }

  Widget _getVerticalTextLine(BuildContext context) {
    GlobalKey key = GlobalKey();

    return Positioned(
      key: key,
      left: Random().nextDouble() * MediaQuery.of(context).size.width,
      child: VerticalTextLine(
        speed: 1 + Random().nextDouble() * 9,
        maxLength: Random().nextInt(10) + 5,
        onFinished: () {
          setState(() {
            _verticalLines.removeWhere((element) => element.key == key);
          });
        },
      ),
    );
  }

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomPaint(
          // child: Container(
          //   constraints: BoxConstraints.tightForFinite(),
          // ),
          // painter: MatrixPainter(),
          ),
    );
  }
}
