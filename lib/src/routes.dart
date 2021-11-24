import './exports.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  HomeView.routeName: (BuildContext context) => HomeView(),
  MatrixView.routeName: (BuildContext context) => MatrixView(),
  ChartsView.routeName: (BuildContext context) => ChartsView(),
  BackgroundView.routeName: (BuildContext context) => BackgroundView(),
  GlassmorphismView.routeName: (BuildContext context) => GlassmorphismView(),
};
