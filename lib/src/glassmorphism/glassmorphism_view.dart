import '../exports.dart';
import './glassmorphism_controller.dart';
import './components/glassmorphism_card.dart';
import './components/glassmorphism_control.dart';

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
              Switch(
                activeColor: Colors.amber,
                value: _controller.showControl,
                onChanged: _controller.toggleShowControl,
              ),
              SizedBox(width: 12.0),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.download),
              ),
              SizedBox(width: 12.0),
              IconButton(
                onPressed: _openEndDrawer,
                icon: Icon(Icons.code),
              ),
            ],
          ),
          body: GestureDetector(
            onPanUpdate: (DragUpdateDetails details) {
              double curX = details.globalPosition.dx;
              double curY = details.localPosition.dy;
              double cartLeft = _cardLeft - _controller.width / 2;
              double cartTop = _cardTop - _controller.height / 2;

              if (curX >= cartLeft &&
                  curX < cartLeft + _controller.width &&
                  curY >= cartTop &&
                  curY < cartTop + _controller.height) {
                setState(() {
                  _cardTop = details.localPosition.dy;
                  _cardLeft = details.localPosition.dx;
                });
              }
            },
            child: LayoutBuilder(
              builder: (context, BoxConstraints constraints) {
                return Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: ResizeImage(
                        AssetImage(bgImg),
                        width: 960,
                        height: 720,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Visibility(
                        visible: _controller.showControl,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: GlassmorphismControl(
                            controller: _controller,
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
                );
              },
            ),
          ),
          drawer: appDrawer,
          endDrawer: SizedBox(
            width: 480.0,
            child: Drawer(
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.blue),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
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
                    Container(
                      height: 40.0,
                      alignment: Alignment.center,
                      child: IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.copy),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
