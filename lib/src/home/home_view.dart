import 'dart:ui' as ui;
import '../exports.dart';

class HomeView extends StatelessWidget {
  static const routeName = '/home';

  const HomeView({Key? key}) : super(key: key);

  List<Widget> _buildColorItems() {
    List<Widget> items = List.generate(
      30,
      (index) => FittedBox(
        fit: BoxFit.cover,
        child: GestureDetector(
          onTap: () {
            // Navigator.restorablePushNamed(
            //   context,
            //   BackgroundView.routeName,
            // );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: FlutterLogo(),
                width: 80.0,
                height: 80.0,
              ),
              SizedBox(height: 10.0),
              Text(
                'Gradient Background',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      return Scaffold(
        // appBar: AppBar(
        //   elevation: 0.0,
        //   backgroundColor: Colors.transparent,
        //   title: Row(
        //     children: const [
        //       Spacer(),
        //       SizedBox(width: 300.0, child: TextField()),
        //       Spacer(),
        //     ],
        //   ),
        // ),
        body: Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          constraints: BoxConstraints.tightForFinite(),
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage(bgImg),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(
              sigmaX: 10.0,
              sigmaY: 10.0,
              tileMode: TileMode.clamp,
            ),
            child: Container(
                padding: EdgeInsets.only(left: 250.0, right: 250.0, top: 50.0),
                color: Colors.black.withOpacity(.3),
                constraints: BoxConstraints.tightForFinite(),
                child: Table(
                  columnWidths: {
                    0: FlexColumnWidth(100.0),
                    1: FlexColumnWidth(100.0),
                    2: FlexColumnWidth(100.0),
                    3: FlexColumnWidth(100.0),
                    4: FlexColumnWidth(100.0),
                    5: FlexColumnWidth(100.0),
                    6: FlexColumnWidth(100.0),
                  },
                  children: [
                    TableRow(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.restorablePushNamed(
                              context,
                              BackgroundView.routeName,
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: FlutterLogo(),
                                width: 80.0,
                                height: 80.0,
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Gradient Background',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.0),
                              ),
                              SizedBox(height: 60.0),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.restorablePushNamed(
                              context,
                              BackgroundView.routeName,
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: FlutterLogo(),
                                width: 80.0,
                                height: 80.0,
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Gradient Background',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.restorablePushNamed(
                              context,
                              BackgroundView.routeName,
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: FlutterLogo(),
                                width: 80.0,
                                height: 80.0,
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Gradient Background',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.restorablePushNamed(
                              context,
                              BackgroundView.routeName,
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: FlutterLogo(),
                                width: 80.0,
                                height: 80.0,
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Gradient Background',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.restorablePushNamed(
                              context,
                              BackgroundView.routeName,
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: FlutterLogo(),
                                width: 80.0,
                                height: 80.0,
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Gradient Background',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.restorablePushNamed(
                              context,
                              BackgroundView.routeName,
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: FlutterLogo(),
                                width: 80.0,
                                height: 80.0,
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Gradient Background',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.restorablePushNamed(
                              context,
                              BackgroundView.routeName,
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: FlutterLogo(),
                                width: 80.0,
                                height: 80.0,
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Gradient Background',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.restorablePushNamed(
                              context,
                              BackgroundView.routeName,
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: FlutterLogo(),
                                width: 80.0,
                                height: 80.0,
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Gradient Background',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.restorablePushNamed(
                              context,
                              BackgroundView.routeName,
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: FlutterLogo(),
                                width: 80.0,
                                height: 80.0,
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Gradient Background',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.restorablePushNamed(
                              context,
                              BackgroundView.routeName,
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: FlutterLogo(),
                                width: 80.0,
                                height: 80.0,
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Gradient Background',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.restorablePushNamed(
                              context,
                              BackgroundView.routeName,
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: FlutterLogo(),
                                width: 80.0,
                                height: 80.0,
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Gradient Background',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.restorablePushNamed(
                              context,
                              BackgroundView.routeName,
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: FlutterLogo(),
                                width: 80.0,
                                height: 80.0,
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Gradient Background',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.restorablePushNamed(
                              context,
                              BackgroundView.routeName,
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: FlutterLogo(),
                                width: 80.0,
                                height: 80.0,
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Gradient Background',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.restorablePushNamed(
                              context,
                              BackgroundView.routeName,
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: FlutterLogo(),
                                width: 80.0,
                                height: 80.0,
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Gradient Background',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ),
      );
    });
  }
}

//  GridView.count(
//                 padding: EdgeInsets.only(
//                   left: 250.0,
//                   right: 250.0,
//                   top: 50.0,
//                   bottom: 20.0,
//                 ),
//                 crossAxisSpacing: 110,
//                 mainAxisSpacing: 50,
//                 crossAxisCount: 7,
//                 children: _buildColorItems(),
//               )