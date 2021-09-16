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
        actions: [
          Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              icon: Icon(Icons.code),
            );
          }),
        ],
      ),
      endDrawer: SizedBox(
        width: 400.0,
        child: Drawer(
          child: Container(
            constraints: BoxConstraints.tightForFinite(),
            color: Colors.white,
          ),
        ),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              constraints: BoxConstraints.tightForFinite(),
              decoration: BoxDecoration(
                color: fromCssColor('#2980b9'),
                gradient: LinearGradient(
                  colors: [
                    fromCssColor('#2980b9'),
                    fromCssColor('#2c3e50'),
                  ],
                ),
              ),
              child: Text(
                'Nighthawk',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
