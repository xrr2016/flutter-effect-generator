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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100.0),
                      child: Text(
                        controller.text,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 50.0),
                      height: 200.0,
                      width: 800.0,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Text(
                              'Background',
                              style: const TextStyle(color: Colors.white),
                            ),
                            trailing: InkWell(
                              onTap: () {},
                              child: Container(
                                width: 60.0,
                                height: 24.0,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(4.0),
                                  // gradient:
                                ),
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Text(
                              'Text',
                              style: const TextStyle(color: Colors.white),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(left: 26.0),
                              child: TextField(
                                maxLength: 50,
                                decoration: InputDecoration(
                                  counterStyle: TextStyle(color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                style: TextStyle(color: Colors.white),
                                onChanged: (val) {
                                  controller.changeText(val);
                                },
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Text(
                              'Angle',
                              style: const TextStyle(color: Colors.white),
                            ),
                            title: Slider(
                              min: 0.0,
                              max: 360,
                              value: 180.0,
                              label: '111',
                              activeColor: Colors.amber,
                              inactiveColor: Colors.white70,
                              onChanged: (val) {},
                            ),
                            trailing: Text(
                              '180.0',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
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
