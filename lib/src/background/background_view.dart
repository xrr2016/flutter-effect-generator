import '../exports.dart';
import './background_controller.dart';

class BackgroundView extends StatefulWidget {
  static const routeName = '/background';

  BackgroundView({
    Key? key,
  }) : super(key: key) {
    controller = BackgroundController();
  }

  late final BackgroundController controller;

  @override
  _BackgroundViewState createState() => _BackgroundViewState();
}

class _BackgroundViewState extends State<BackgroundView> {
  late final BackgroundController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
  }

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
      body: LayoutBuilder(builder: (context, BoxConstraints constraints) {
        return AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, Widget? child) {
              return Stack(
                children: [
                  Container(
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
                      controller.text,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20.0,
                    left: constraints.maxWidth / 2 - 150.0,
                    child: Container(
                      width: 300.0,
                      color: Colors.amber,
                      child: TextField(
                        onChanged: (val) {
                          controller.changeText(val);
                        },
                      ),
                    ),
                  ),
                ],
              );
            });
      }),
    );
  }
}
