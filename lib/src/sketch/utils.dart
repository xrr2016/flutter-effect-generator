import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

grid(
  Canvas canvas,
  Size size, {
  int count = 10,
  Color color = Colors.black26,
  double strokeWidth = 0.5,
}) {
  double width = size.width;
  double height = size.height;
  Paint paint = Paint()
    ..color = color
    ..strokeWidth = strokeWidth;

  canvas.save();
  double dy = height / count;
  for (int i = 0; i < count; i++) {
    Offset p1 = Offset(0, dy);
    Offset p2 = Offset(width, dy);

    canvas.drawLine(p1, p2, paint);
    canvas.translate(0, dy);
  }
  canvas.restore();

  canvas.save();
  double dx = width / count;
  for (int i = 0; i < count; i++) {
    Offset p1 = Offset(dx, 0);
    Offset p2 = Offset(dx, height);

    canvas.drawLine(p1, p2, paint);
    canvas.translate(dx, 0);
  }
  canvas.restore();
}

clear(Canvas canvas, Size size) {
  Rect rect = Offset.zero & size;
  Paint paint = Paint()..color = Colors.white;

  canvas.drawRect(rect, paint);
}

circle(
  Canvas canvas,
  Size size, {
  double x = 0.0,
  double y = 0.0,
  double radius = 20.0,
  Color color = Colors.red,
  Offset offset = Offset.zero,
  PaintingStyle style = PaintingStyle.fill,
}) {
  Paint paint = Paint()
    ..color = color
    ..style = style;
  canvas.drawCircle(Offset(x, y), radius, paint);
}

ellipse(
  Canvas canvas,
  Size size, {
  double x = 0.0,
  double y = 0.0,
  double width = 20.0,
  double height = 20.0,
  Color color = Colors.red,
  PaintingStyle style = PaintingStyle.stroke,
}) {
  Paint paint = Paint()
    ..color = color
    ..style = style;
  Rect rect = Rect.fromLTWH(x, y, width, height);
  canvas.drawOval(rect, paint);
}

arc(
  Canvas canvas,
  Size size, {
  double x = 0.0,
  double y = 0.0,
  double width = 20.0,
  double height = 20.0,
  double startAngle = 0.0,
  double sweepAngle = pi,
  bool useCenter = false,
  Color color = Colors.red,
  PaintingStyle style = PaintingStyle.stroke,
}) {
  Paint paint = Paint()
    ..color = color
    ..style = style;
  Rect rect = Rect.fromCenter(
    width: width,
    height: height,
    center: Offset(x, y),
  );

  canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
}

line(
  Canvas canvas,
  Size size, {
  double x1 = 0.0,
  double y1 = 0.0,
  double x2 = 0.0,
  double y2 = 0.0,
  double strokeWidth = 1.0,
  Color color = Colors.red,
}) {
  Paint paint = Paint()
    ..color = color
    ..strokeWidth = strokeWidth;
  Offset p1 = Offset(x1, y1);
  Offset p2 = Offset(x2, y2);

  canvas.drawLine(p1, p2, paint);
}

point(
  Canvas canvas,
  Size size, {
  double x = 0.0,
  double y = 0.0,
  double strokeWidth = 1.0,
  Color color = Colors.red,
  StrokeCap strokeCap = StrokeCap.round,
  PointMode pointMode = PointMode.points,
}) {
  Paint paint = Paint()
    ..color = color
    ..strokeCap = StrokeCap.round
    ..strokeWidth = strokeWidth;
  List<Offset> points = [Offset(x, y)];

  canvas.drawPoints(pointMode, points, paint);
}

triangle(
  Canvas canvas,
  Size size, {
  double x1 = 0.0,
  double y1 = 0.0,
  double x2 = 0.0,
  double y2 = 0.0,
  double x3 = 0.0,
  double y3 = 0.0,
  Color color = Colors.red,
  double strokeWidth = 1.0,
  PaintingStyle style = PaintingStyle.stroke,
}) {
  Paint paint = Paint()
    ..color = color
    ..style = style
    ..strokeWidth = strokeWidth;
  Path path = Path()
    ..moveTo(x1, y1)
    ..lineTo(x2, y2)
    ..lineTo(x3, y3)
    ..close();

  canvas.drawPath(path, paint);
}

quad(
  Canvas canvas,
  Size size, {
  double x1 = 0.0,
  double y1 = 0.0,
  double x2 = 0.0,
  double y2 = 0.0,
  double x3 = 0.0,
  double y3 = 0.0,
  double x4 = 0.0,
  double y4 = 0.0,
  Color color = Colors.red,
  double strokeWidth = 1.0,
  PaintingStyle style = PaintingStyle.stroke,
}) {
  Paint paint = Paint()
    ..color = color
    ..style = style
    ..strokeWidth = strokeWidth;
  Path path = Path()
    ..moveTo(x1, y1)
    ..lineTo(x2, y2)
    ..lineTo(x3, y3)
    ..lineTo(x4, y4)
    ..close();

  canvas.drawPath(path, paint);
}

rect(
  Canvas canvas,
  Size size, {
  double x = 0.0,
  double y = 0.0,
  double width = 0.0,
  double height = 0.0,
  double radius = 0.0,
  Color color = Colors.red,
  double strokeWidth = 1.0,
  PaintingStyle style = PaintingStyle.stroke,
}) {
  Paint paint = Paint()
    ..color = color
    ..style = style
    ..strokeWidth = strokeWidth;
  Rect rect = Rect.fromLTWH(x, y, width, height);
  Radius _radius = Radius.circular(radius);
  RRect rRect = RRect.fromRectAndRadius(rect, _radius);

  canvas.drawRRect(rRect, paint);
}

square(
  Canvas canvas,
  Size size, {
  double x = 0.0,
  double y = 0.0,
  double width = 0.0,
  double radius = 0.0,
  Color color = Colors.red,
  double strokeWidth = 1.0,
  PaintingStyle style = PaintingStyle.stroke,
}) {
  Paint paint = Paint()
    ..color = color
    ..style = style
    ..strokeWidth = strokeWidth;
  Rect rect = Rect.fromLTWH(x, y, width, width);
  Radius _radius = Radius.circular(radius);
  RRect rRect = RRect.fromRectAndRadius(rect, _radius);

  canvas.drawRRect(rRect, paint);
}

image(
  Canvas canvas,
  Size size, {
  double x = 0.0,
  double y = 0.0,
  required String image,
}) async {
  final _image = await loadImage(image);

  canvas.drawImage(_image, Offset(x, y), Paint());
}

generate(Canvas canvas, Size size) async {
  final recorder = ui.PictureRecorder();
  // final canvas = Canvas(recorder, Offset(0.0, 0.0) & size);

  final picture = recorder.endRecording();
  final img = await picture.toImage(200, 200);
  final bytes = await img.toByteData(format: ui.ImageByteFormat.png);

  return bytes;
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/canvas.png').create(recursive: true);
}

Future<String> writeFile(Uint8List image) async {
  final file = await _localFile;
  file.writeAsBytes(image);

  return file.path;
}

save(GlobalKey key) async {
  final RenderRepaintBoundary boundary =
      key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  BuildContext? context = key.currentContext;
  double pixelRatio = 1.0;

  if (context != null) {
    pixelRatio = MediaQuery.of(context).devicePixelRatio;
  }
  final ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
  final ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
  final Uint8List bytes = byteData!.buffer.asUint8List();

  writeFile(bytes);
}

Future<ui.Image> loadImage(String img) async {
  final ByteData data = await rootBundle.load(img);
  final Completer<ui.Image> completer = Completer();
  final Uint8List list = Uint8List.view(data.buffer);

  ui.decodeImageFromList(list, (ui.Image img) {
    return completer.complete(img);
  });

  return completer.future;
}
