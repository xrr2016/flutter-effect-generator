import '../exports.dart';

class MatrixViewer extends StatefulWidget {
  MatrixViewer({
    required Key key,
  }) : super(key: key);

  @override
  _MatrixViewerState createState() => _MatrixViewerState();
}

class _MatrixViewerState extends State<MatrixViewer>
    with SingleTickerProviderStateMixin {
  double _progress = 0;
  late Animation<double> _animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(milliseconds: 60000),
      vsync: this,
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reset();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      })
      ..forward();

    _animation = Tween(begin: 1.0, end: 100.0).animate(controller)
      ..addListener(() {
        setState(() {
          _progress = _animation.value;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    String characters = "CodePenChallenge";

    return CustomPaint(
      size: Size(double.infinity, double.infinity),
      painter: MatrixPainter(characters, _progress),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class MatrixPainter extends CustomPainter {
  double _progress = 0;
  static String _characters = Constants.charSets;
  static List<TextStream> _textStreams = [];

  MatrixPainter(String characters, double progress) {
    Constants.buildTextPainters();
    _progress = progress;

    if (_characters != characters) {
      _textStreams.clear();
    }

    _characters = characters;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (_progress.round() % Configuration.streamGenerationInterval == 0 &&
        _textStreams.length < Configuration.maxStreams) {
      TextStream ts;
      Rect boundary = Rect.fromLTWH(0, 0, size.width, size.height);

      ts = _generateNewStream(boundary);
      _textStreams.add(ts);
    }

    paintStreams(canvas, size, _textStreams);
  }

  void paintStreams(Canvas canvas, Size size, List<TextStream> streams) {
    List<TextStream> useless = [];

    for (TextStream stream in streams) {
      final dx = stream.baseOffset.dx;
      final dy = stream.baseOffset.dy + stream.yOffset;

      stream.yOffset += stream.speed;
      stream.scaleDelta += 0.001;

      if (dy < -stream.size.height || dy > size.height) {
        if (dy > size.height) {
          useless.add(stream);
        }
        continue;
      }

      double yOffset = 0;

      for (int i = 0; i < stream.charsCount; i++) {
        TextPainter tp = stream.streamPainters[i];
        final charOffset = Offset(dx, dy + yOffset);

        tp.paint(canvas, charOffset);
        yOffset += tp.height;
      }
    }

    for (TextStream s in useless) {
      streams.remove(s);
    }

//    Logger.debug("${useless.length} streams removed. ${streams.length} streams remained.");
  }

  TextStream _generateNewStream(Rect boundary) {
    int len = Configuration.minCharacters +
        Constants.randomSeed
            .nextInt(Configuration.maxCharacters - Configuration.minCharacters);

    int id = DateTime.now().millisecondsSinceEpoch;

    return TextStream('C$id', Constants.randomString(len), boundary);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class TextStream {
  final String id;
  String text;
  late int charsCount;
  late Size size;
  late Offset baseOffset;
  int yOffset = 0;
  int fontSize = Configuration.defaultFontSize;
  double baseScale = 1.0;
  double scaleDelta = 0;
  int speed = 1;

  late TextPainter textPainter;
  List<TextPainter> streamPainters = [];

  TextStream(
    this.id,
    this.text,
    Rect boundary, {
    int speed = -1,
  }) {
    _configureStreamParameters(boundary, speed: speed);
  }

  void _configureStreamParameters(Rect boundary, {int speed = -1}) {
    charsCount = text.length;

    baseScale = 0.5 + Constants.randomSeed.nextDouble() * 0.5;

    speed = (speed == -1
        ? (1 + Constants.randomSeed.nextInt(Configuration.maxStreamSpeed))
        : speed);
    fontSize = (Configuration.defaultFontSize * baseScale).round();

    _pickupPainters();

    size = _calculatePaintersSize();

    baseOffset = Offset(
      boundary.left +
          Constants.randomSeed.nextInt(boundary.width.round()).toDouble(),
      -size.height * (Constants.randomSeed.nextDouble() + 1),
    );
  }

  void _pickupPainters() {
    streamPainters.clear();

    String key;

    for (int i = 0; i < text.length; i++) {
      if (i < Configuration.leadingCharacters) {
        key = '${text[i]}.L$i.$fontSize';
      } else if (i >= text.length - Configuration.tailCharacters) {
        key =
            '${text[i]}.T${Configuration.tailCharacters - (text.length - i)}.$fontSize';
      } else {
        key = "${text[i]}.B.$fontSize";
      }

      TextPainter? tp = Constants.textPainters[key];

      if (tp == null) {
        continue;
      }

      streamPainters.add(tp);
    }
  }

  Size _calculatePaintersSize() {
    double width = 0;
    double height = 0;
    for (var tp in streamPainters) {
      if (tp.width > width) {
        width = tp.width;
      }

      height += tp.height;
    }

    return Size(width, height);
  }
}

class GradientColor {
  final Color color;
  final double percentage;

  GradientColor(this.color, this.percentage);
}

List<Color> calculateGradientColors(int len, List<GradientColor> targetColors) {
  List<Color> outputColors = [];

  if (len <= 0 || targetColors.isEmpty) {
    return outputColors;
  }

  late GradientColor from;
  late GradientColor to;

  for (int i = 0; i < targetColors.length - 1; i++) {
    from = _getFromGradientColor(i, targetColors);
    to = _getToGradientColor(i + 1, targetColors);

    int count = ((to.percentage - from.percentage) * len).ceil();
    for (int j = 0; j < count; j++) {
      Color color = getGradientColor(
        from.color,
        to.color,
        (j / count.toDouble()),
      );

      outputColors.add(color);
    }
  }

  if (outputColors.length < len) {
    for (int i = 0; i < (len - outputColors.length); i++) {
      outputColors.add(to.color);
    }
  }

  return outputColors;
}

Color getGradientColor(Color from, Color to, double percentage) {
  return Color.fromARGB(
    from.alpha + ((to.alpha - from.alpha) * percentage).round(),
    from.red + ((to.red - from.red) * percentage).round(),
    from.green + ((to.green - from.green) * percentage).round(),
    from.blue + ((to.blue - from.blue) * percentage).round(),
  );
}

GradientColor _getFromGradientColor(int index, List<GradientColor> colors) {
  return _getGradientColor(index, colors, Colors.green, 0);
}

GradientColor _getToGradientColor(int index, List<GradientColor> colors) {
  return _getGradientColor(index, colors, Colors.black, 1);
}

GradientColor _getGradientColor(int index, List<GradientColor> colors,
    Color fallbackColor, double fallbackPercentage) {
  if (index < 0 || index >= colors.length) {
    return GradientColor(fallbackColor, fallbackPercentage);
  }

  return colors[index];
}

class Constants {
  static final randomSeed = Random(DateTime.now().millisecondsSinceEpoch);

  static final Map<String, TextPainter> textPainters = {};
  static bool _isPaintersBuilt = false;

  static final charSets = '0123456789' +
      '°C°F, .-' +
      'abcdefghijklmnopqrstuvwxyz' +
      'ABCDEFGHIJKLMNOPQRSTUVWXYZ' +
      '';

  static final _defaultTextStyle =
      TextStyle(color: Configuration.defaultColor, height: 1);

  static TextPainter _createPainter(String text, Color color, int fontSize) {
    final textStyle =
        _defaultTextStyle.copyWith(color: color, fontSize: fontSize.toDouble());

    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );

    final painter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    painter.layout();

    return painter;
  }

  static void buildTextPainters() {
    if (_isPaintersBuilt) {
      return;
    }

    List<Color> leadingColors = calculateGradientColors(
        Configuration.leadingCharacters, Configuration.leadingGradientColors);
    List<Color> tailColors = calculateGradientColors(
        Configuration.tailCharacters, Configuration.tailGradientColors);

    for (int cIndex = 0; cIndex < charSets.length; cIndex++) {
      for (int fontSize = 1;
          fontSize <= Configuration.maxFontSize;
          fontSize++) {
        for (int lIndex = 0;
            lIndex < Configuration.leadingCharacters;
            lIndex++) {
          String key = "${charSets[cIndex]}.L$lIndex.$fontSize";

          textPainters[key] =
              _createPainter(charSets[cIndex], leadingColors[lIndex], fontSize);
        }

        for (int tIndex = 0; tIndex < Configuration.tailCharacters; tIndex++) {
          String key = "${charSets[cIndex]}.T$tIndex.$fontSize";

          textPainters[key] =
              _createPainter(charSets[cIndex], tailColors[tIndex], fontSize);
        }

        String key = "${charSets[cIndex]}.B.$fontSize";

        textPainters[key] = _createPainter(
            charSets[cIndex], Configuration.defaultColor, fontSize);
      }
    }

    _isPaintersBuilt = true;
  }

  static String randomString(int len, {charset}) {
    String result = '';
    charset ??= charSets;

    for (int i = 0; i < len; i++) {
      int index = randomSeed.nextInt(charset.length);
      result += charset[index];
    }

    return result;
  }

  Size measureChars(String chars, TextStyle textStyle) {
    final singleCharTextSpan = TextSpan(
      text: chars,
      style: textStyle,
    );

    final painter = TextPainter(
      text: singleCharTextSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    painter.layout(
      minWidth: 0,
      maxWidth: 0,
    );

    return Size(painter.minIntrinsicWidth, painter.height);
  }
}

class Configuration {
  static int defaultFontSize = 48;
  static int maxFontSize = 64;

  static int leadingCharacters = 5;
  static int tailCharacters = 5;
  static int maxCharacters = 20;
  static int minCharacters = 6;

  static int streamGenerationInterval = 10;
  static int maxStreamSpeed = 10;
  static int maxStreams = 300;

  static Color defaultColor = Colors.green;

  static List<GradientColor> leadingGradientColors = [
    GradientColor(Colors.black.withAlpha(0), 0),
    GradientColor(defaultColor, 1)
  ];
  static List<GradientColor> tailGradientColors = [
    GradientColor(defaultColor, 0),
    GradientColor(Colors.white, 1)
  ];
}
