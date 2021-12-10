import 'dart:ui' as ui;
import '../exports.dart';
import './home_card.dart';

class HomeView extends StatelessWidget {
  static const routeName = '/home';

  const HomeView({Key? key}) : super(key: key);

  // List<Widget> _buildColorItems() {
  //   List<Widget> items = List.generate(
  //     30,
  //     (index) => FittedBox(
  //       fit: BoxFit.cover,
  //       child: GestureDetector(
  //         onTap: () {
  //           // Navigator.restorablePushNamed(
  //           //   context,
  //           //   BackgroundView.routeName,
  //           // );
  //         },
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             SizedBox(
  //               child: FlutterLogo(),
  //               width: 80.0,
  //               height: 80.0,
  //             ),
  //             SizedBox(height: 10.0),
  //             Text(
  //               'Gradient Background',
  //               style: TextStyle(color: Colors.white),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );

  //   return items;
  // }

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
                    HomeCard(
                      title: 'Generative',
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
