import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../exports.dart';

class VerticalTextLine extends StatefulWidget {
  const VerticalTextLine({
    Key? key,
    required this.speed,
    required this.maxLength,
    required this.onFinished,
  }) : super(key: key);

  final double speed;
  final int maxLength;
  final VoidCallback onFinished;

  @override
  _VerticalTextLineState createState() => _VerticalTextLineState();
}

class _VerticalTextLineState extends State<VerticalTextLine> {
  late int _maxLength;
  late Duration _stepInterval;
  final List<String> _characters = ['T', 'E', 'S', 'T'];
  late Timer _timer;

  @override
  void initState() {
    _maxLength = widget.maxLength;
    _stepInterval = Duration(milliseconds: (1000 ~/ widget.speed));
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(_stepInterval, (timer) {
      final Random random = Random();
      final String element = String.fromCharCode(random.nextInt(512));
      final RenderBox box = context.findRenderObject() as RenderBox;

      if (box.size.height >= MediaQuery.of(context).size.height * 2) {
        widget.onFinished();
        return;
      }

      setState(() {
        _characters.add(element);
      });
    });
  }

  List<Widget> _getCharacters() {
    List<Widget> textWidgets = [];
    _characters.asMap().forEach((key, value) {
      textWidgets.add(Text(
        value,
        style: TextStyle(color: Colors.white),
      ));
    });
    return textWidgets;
  }

  @override
  Widget build(BuildContext context) {
    List<double> stops = [];
    List<Color> colors = [];
    double greenStart = 0.3;
    double whiteStart = (_characters.length - 1) / (_characters.length);
    colors = [Colors.transparent, Colors.green, Colors.green, Colors.white];
    greenStart = (_characters.length - _maxLength) / _characters.length;
    stops = [0, greenStart, whiteStart, whiteStart];

    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: colors,
          stops: stops,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _getCharacters(),
      ),
    );
  }
}
