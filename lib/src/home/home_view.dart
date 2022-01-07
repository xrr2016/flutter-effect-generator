import 'dart:ui' as ui;
import '../exports.dart';
import './home_card.dart';

class HomeView extends StatefulWidget {
  static const routeName = '/home';

  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // List<Widget> _buildColorItems() {

  @override
  void initState() {
    super.initState();

    _setWindowSize();
    _getWindowSize();
  }

  Future _getWindowSize() async {}

  Future _setWindowSize() async {
    Size winSize = Size(1480, 900);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(bgImg),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
            tileMode: TileMode.clamp,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.1),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Center(
              child: Container(
                width: 800.0,
                height: 600.0,
                padding: EdgeInsets.all(50.0),
                child: Wrap(
                  runSpacing: 50.0,
                  spacing: 50.0,
                  children: [
                    HomeCard(
                      title: 'Charts',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
