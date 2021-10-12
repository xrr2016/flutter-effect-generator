import '../exports.dart';
import './glassmorphism_controller.dart';
import './components/glassmorphism_card.dart';

class GlassmorphismView extends StatefulWidget {
  static const routeName = '/glassmorphism';

  const GlassmorphismView({Key? key}) : super(key: key);

  @override
  State<GlassmorphismView> createState() => _GlassmorphismViewState();
}

class _GlassmorphismViewState extends State<GlassmorphismView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openEndDrawer() {
    _controller.changeCode();
    _scaffoldKey.currentState!.openEndDrawer();
  }

  Map<String, TextStyle> theme = {};

  final GlassmorphismController _controller = GlassmorphismController();

  double _cardTop = 400.0;
  double _cardLeft = 600.0;

  List<Widget> _buildColorItems() {
    List<Widget> items = [];

    colors.asMap().forEach((key, color) {
      items.add(
        InkWell(
          onTap: () {
            _controller.changeColor(color);
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    });

    return items.toList();
  }

  void _openDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(10.0),
          title: Text('Color'),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.5,
            padding: const EdgeInsets.all(20.0),
            child: GridView.count(
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              crossAxisCount: 10,
              children: _buildColorItems(),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    theme.addAll(atomOneDarkTheme);

    theme.update(
      'root',
      (value) => value.copyWith(
        backgroundColor: Colors.transparent,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: const Text('Glassmorphism Card'),
              centerTitle: false,
              actions: [
                IconButton(
                  onPressed: _openEndDrawer,
                  icon: Icon(Icons.code),
                ),
              ],
            ),
            body: SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: ResizeImage(
                            AssetImage(
                              'assets/images/bg.jpg',
                            ),
                            width: 960,
                            height: 720,
                          ),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.black,
                      ),
                      child: GestureDetector(
                        onPanUpdate: (DragUpdateDetails details) {
                          setState(() {
                            _cardTop = details.localPosition.dy;
                            _cardLeft = details.localPosition.dx;
                          });
                        },
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 50.0),
                                height: 800.0,
                                width: 400.0,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Text(
                                        'Color',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      trailing: InkWell(
                                        onTap: () {
                                          _openDialog();
                                        },
                                        child: Container(
                                          width: 24.0,
                                          height: 24.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: _controller.color,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      leading: Text(
                                        'Width',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      title: Slider(
                                        min: 200.0,
                                        max: 800.0,
                                        value: _controller.width,
                                        activeColor: Colors.amber,
                                        inactiveColor: Colors.white70,
                                        onChanged: _controller.changeWidth,
                                      ),
                                      trailing: Text(
                                        _controller.width.toInt().toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    ListTile(
                                      leading: Text(
                                        'Height',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      title: Slider(
                                        min: 200.0,
                                        max: 600.0,
                                        value: _controller.height,
                                        activeColor: Colors.amber,
                                        inactiveColor: Colors.white70,
                                        onChanged: _controller.changeHeight,
                                      ),
                                      trailing: Text(
                                        _controller.height.toInt().toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    ListTile(
                                      leading: Text(
                                        'Opacity',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      title: Slider(
                                        min: 0.1,
                                        max: 0.5,
                                        value: _controller.opacity,
                                        activeColor: Colors.amber,
                                        inactiveColor: Colors.white70,
                                        onChanged: _controller.changeOpacity,
                                      ),
                                      trailing: Text(
                                        _controller.opacity.toStringAsFixed(1),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    ListTile(
                                      leading: Text(
                                        'Blur',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      title: Slider(
                                        min: 1.0,
                                        max: 30.0,
                                        value: _controller.blur,
                                        activeColor: Colors.amber,
                                        inactiveColor: Colors.white70,
                                        onChanged: _controller.changeBlur,
                                      ),
                                      trailing: Text(
                                        _controller.blur.toStringAsFixed(1),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    ListTile(
                                      leading: Text(
                                        'Radius',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      title: Slider(
                                        min: 1.0,
                                        max: 30.0,
                                        value: _controller.radius,
                                        activeColor: Colors.amber,
                                        inactiveColor: Colors.white70,
                                        onChanged: _controller.changeRadius,
                                      ),
                                      trailing: Text(
                                        _controller.radius.toStringAsFixed(1),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: _cardTop - _controller.height / 2,
                              left: _cardLeft - _controller.width / 2,
                              child: GlassmorphismCard(
                                width: _controller.width,
                                height: _controller.height,
                                blur: _controller.blur,
                                opacity: _controller.opacity,
                                radius: _controller.radius,
                                color: _controller.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // AnimatedContainer(
                  //   duration: Duration(milliseconds: 300),
                  //   curve: Curves.easeIn,
                  //   width: _show ? 480.0 : 0.0,
                  //   color: Colors.black,
                  //   child: SingleChildScrollView(
                  //     child: HighlightView(
                  //       _controller.code,
                  //       theme: theme,
                  //       padding: const EdgeInsets.only(top: 20.0),
                  //       language: 'dart',
                  //       textStyle: GoogleFonts.robotoMono(
                  //         color: Colors.white,
                  //         fontSize: 13.0,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            drawer: appDrawer,
            endDrawer: SizedBox(
              width: 480.0,
              child: MediaQuery.removePadding(
                context: context,
                child: Drawer(
                  elevation: 2.0,
                  child: Container(
                    color: Colors.blue,
                    width: 480.0,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SingleChildScrollView(
                          child: Container(
                            color: Colors.black,
                            child: HighlightView(
                              _controller.code,
                              theme: theme,
                              padding: const EdgeInsets.only(top: 20.0),
                              language: 'dart',
                              textStyle: GoogleFonts.robotoMono(
                                color: Colors.white,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
