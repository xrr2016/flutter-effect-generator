import './exports.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restorationScopeId: 'app',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: ThemeData(textTheme: GoogleFonts.latoTextTheme()),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          home: HomeView(),
          routes: appRoutes,
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  // case SampleItemDetailsView.routeName:
                  //   return const SampleItemDetailsView();
                  // case SampleItemListView.routeName:
                  //   return const SampleItemListView();
                  default:
                    return const HomeView();
                }
              },
            );
          },
        );
      },
    );
  }
}
