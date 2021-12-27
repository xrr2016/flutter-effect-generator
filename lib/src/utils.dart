import './exports.dart';


  // void downloadImage() async {
  // final ScreenshotController screenshotController = ScreenshotController();

  //   try {
  //     final double pixelRatio = MediaQuery.of(context).devicePixelRatio;

  //     screenshotController
  //         .captureFromWidget(
  //           state.preview,
  //           pixelRatio: pixelRatio,
  //         )
  //         .then(_capturedImage)
  //         .catchError(_catchError);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  //   void _capturedImage(Uint8List image) async {
  //   final base64data = base64Encode(image);
  //   final a = html.AnchorElement(href: 'data:image/jpeg;base64,$base64data');
  //   a.download = 'Neumorphism.jpg';
  //   a.click();
  //   a.remove();

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(AppLocalizations.of(context)!.download),
  //       action: SnackBarAction(
  //         label: 'OK',
  //         textColor: Colors.amber,
  //         onPressed: () {
  //           ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //         },
  //       ),
  //     ),
  //   );
  // }