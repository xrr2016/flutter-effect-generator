import 'dart:ui';

class SketchContext {
  late Canvas _canvas;
  late Image _image;
  late PictureRecorder _recorder;
  late Size _size = Size(100, 100);

  void start() {
    _recorder = PictureRecorder();
    _canvas = Canvas(_recorder);
  }

  void end() async {
    final Picture picture = _recorder.endRecording();
    _image = await picture.toImage(_size.width.round(), _size.height.round());
  }
}
