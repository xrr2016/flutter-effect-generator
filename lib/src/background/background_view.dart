import '../exports.dart';
import './model/gradient_item.dart';
import './background_controller.dart';

class BackgroundView extends StatefulWidget {
  static const routeName = '/background';

  BackgroundView({
    Key? key,
  }) : super(key: key);

  @override
  _BackgroundViewState createState() => _BackgroundViewState();
}

class _BackgroundViewState extends State<BackgroundView> {
  final BackgroundController controller = BackgroundController();
  final TextEditingController _textEditingController = TextEditingController();

  GradientItem defaultGradientItem = GradientItem(colors: [
    fromCssColor('blue'),
    fromCssColor('yellow'),
  ], name: 'Gradient Background');

  Map<String, TextStyle> codeTheme = {};

  List<Widget> _buildColorItems() {
    List<Widget> items = [];

    controller.gradients.asMap().forEach((key, GradientItem gradientItem) {
      items.add(
        InkWell(
          onTap: () {
            controller.changleGradient(gradientItem);
            Navigator.pop(context);
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: gradientItem.colors.first,
              gradient: LinearGradient(colors: gradientItem.colors),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: FittedBox(
              alignment: Alignment.center,
              fit: BoxFit.cover,
              child: Text(
                gradientItem.name,
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ),
        ),
      );
    });

    return items.toList();
  }

  void _openDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(10.0),
          title: Text('Choose'),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.all(10.0),
            child: GridView.count(
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0,
              crossAxisCount: 3,
              childAspectRatio: 16 / 9,
              semanticChildCount: 3,
              children: _buildColorItems(),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    codeTheme.addAll(atomOneDarkTheme);

    codeTheme.update(
      'root',
      (value) => value.copyWith(
        backgroundColor: Colors.transparent,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        final List<Color> colors = controller.gradient.colors.isNotEmpty
            ? controller.gradient.colors
            : defaultGradientItem.colors;
        final String text = controller.text.isNotEmpty
            ? controller.text
            : controller.gradient.name;

        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: const Text('Gradient Background'),
            centerTitle: false,
            actions: [
              Switch(
                activeColor: Colors.amber,
                value: controller.showControl,
                onChanged: controller.toggleShowControl,
              ),
              Builder(builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: Icon(Icons.code),
                );
              }),
            ],
          ),
          body: LayoutBuilder(builder: (context, BoxConstraints constraints) {
            return Stack(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: colors,
                    ),
                  ),
                  child: Container(
                    width: constraints.maxWidth / 2,
                    margin: EdgeInsets.only(top: 300.0),
                    padding: const EdgeInsets.symmetric(horizontal: 100.0),
                    child: Text(
                      text,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 50.0),
                    ),
                  ),
                ),
                Visibility(
                  visible: controller.showControl,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 50.0),
                      height: 160.0,
                      width: 720.0,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Text(
                              'Background',
                              style: const TextStyle(color: Colors.white),
                            ),
                            trailing: InkWell(
                              onTap: _openDialog,
                              child: Container(
                                width: 60.0,
                                height: 24.0,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  gradient: LinearGradient(
                                    colors: colors,
                                  ),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(4.0),
                                  // gradient:
                                ),
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Text(
                              'Text',
                              style: const TextStyle(color: Colors.white),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(left: 40.0),
                              child: TextField(
                                maxLength: 50,
                                controller: _textEditingController,
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  suffix: IconButton(
                                    onPressed: () {
                                      controller.clearText();
                                      _textEditingController.clear();
                                    },
                                    icon: Icon(
                                      Icons.clear_sharp,
                                      color: Colors.white,
                                    ),
                                  ),
                                  counterStyle: TextStyle(color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                style: TextStyle(color: Colors.white),
                                onChanged: (val) {
                                  controller.changeText(val);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: controller.showControl,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 600.0,
                      height: 800.0,
                      color: Colors.transparent,
                      child: SingleChildScrollView(
                        child: HighlightView(
                          controller.code,
                          theme: codeTheme,
                          language: 'dart',
                          padding: const EdgeInsets.only(top: 20.0),
                          textStyle: GoogleFonts.robotoMono(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}
