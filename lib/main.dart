import './src/exports.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App(settingsController: settingsController));
}
