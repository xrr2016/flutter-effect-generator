import 'dart:ui' as ui;
import '../exports.dart';

class GlassmorphismView extends StatefulWidget {
  static const routeName = '/glassmorphism';

  const GlassmorphismView({Key? key}) : super(key: key);

  @override
  State<GlassmorphismView> createState() => _GlassmorphismViewState();
}

class _GlassmorphismViewState extends State<GlassmorphismView> {
  bool _show = true;
  Map<String, TextStyle> theme = {};

  void _toggleCodeShow() {
    setState(() {
      _show = !_show;
    });
  }

  @override
  void initState() {
    theme.addAll(atomOneDarkTheme);

    theme.update(
      'root',
      (value) => value.copyWith(
        backgroundColor: Colors.transparent,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Glassmorphism Card'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: _toggleCodeShow,
            icon: Icon(Icons.code),
          ),
        ],
      ),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: ResizeImage(
                      NetworkImage(
                        'https://cdn.pixabay.com/photo/2017/12/10/13/37/christmas-3009949_960_720.jpg',
                      ),
                      width: 960,
                      height: 720,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32.0),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(
                      sigmaX: 30.0,
                      sigmaY: 30.0,
                      tileMode: TileMode.clamp,
                    ),
                    child: Container(
                      width: 720.0,
                      height: 400.0,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.01),
                        borderRadius: BorderRadius.circular(32.0),
                        border: Border.all(
                          width: 1.5,
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Card',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.75),
                                  ),
                                ),
                                Icon(
                                  Icons.credit_card_sharp,
                                  color: Colors.white.withOpacity(0.75),
                                )
                              ],
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'TL Templates',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.75),
                                  ),
                                ),
                                Text(
                                  '07/25',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.75),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '5555 5555 5555 4444',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.75),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeIn,
              width: _show ? 480.0 : 0.0,
              color: Colors.green,
              child: SingleChildScrollView(
                child: HighlightView(
                  '111',
                  theme: theme,
                  padding: const EdgeInsets.only(top: 20.0),
                  language: 'dart',
                  textStyle: GoogleFonts.robotoMono(
                    color: Colors.white,
                    fontSize: 13.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: appDrawer,
    );
  }
}
