import '../exports.dart';

class GlassmorphismView extends StatefulWidget {
  static const routeName = '/glassmorphism';

  const GlassmorphismView({Key? key}) : super(key: key);

  @override
  State<GlassmorphismView> createState() => _GlassmorphismViewState();
}

class _GlassmorphismViewState extends State<GlassmorphismView> {
  bool _show = true;

  void _toggleCodeShow() {
    setState(() {
      _show = !_show;
    });
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
              flex: 3,
              child: Container(
                width: 600.0,
                height: 600.0,
                color: Color(0xff333333),
                child: Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Color(0xff333333),
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xff242424),
                          offset: Offset(10.0, 10.0),
                          blurRadius: 4.0,
                        ),
                        BoxShadow(
                          color: Color(0xff424242),
                          offset: Offset(-10.0, -10.0),
                          blurRadius: 4.0,
                        ),
                      ],
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
            )
          ],
        ),
      ),
    );
  }
}
