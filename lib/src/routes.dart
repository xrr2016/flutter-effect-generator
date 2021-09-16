import './exports.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  BackgroundView.routeName: (BuildContext context) =>
      const BackgroundView(controller: BackgroundController()),
};
