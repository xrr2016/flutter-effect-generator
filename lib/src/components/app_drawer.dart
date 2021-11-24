import '../exports.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Container(),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.restorablePushNamed(context, HomeView.routeName);
            },
          ),
          ListTile(
            title: Text('Gradient Background'),
            onTap: () {
              Navigator.restorablePushNamed(context, BackgroundView.routeName);
            },
          ),
          ListTile(
            title: Text('Glassmorphism Card'),
            onTap: () {
              Navigator.restorablePushNamed(
                context,
                GlassmorphismView.routeName,
              );
            },
          ),
          ListTile(
            title: Text('Matrix'),
            onTap: () {
              Navigator.restorablePushNamed(
                context,
                MatrixView.routeName,
              );
            },
          ),
          ListTile(
            title: Text('Charts'),
            onTap: () {
              Navigator.restorablePushNamed(
                context,
                ChartsView.routeName,
              );
            },
          ),
        ],
      ),
    );
  }
}

AppDrawer appDrawer = AppDrawer();
