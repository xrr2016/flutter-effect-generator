import '../exports.dart';
import './background_controller.dart';

class BackgroundView extends StatefulWidget {
  static const routeName = '/background';

  const BackgroundView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final BackgroundController controller;

  @override
  _BackgroundViewState createState() => _BackgroundViewState();
}

class _BackgroundViewState extends State<BackgroundView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gradient Background'),
        centerTitle: false,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
      ),
    );
  }
}
