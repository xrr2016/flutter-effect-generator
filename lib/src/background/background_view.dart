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
                style: TextStyle(color: Colors.white),
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
            padding: const EdgeInsets.all(20.0),
            child: GridView.count(
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              crossAxisCount: 3,
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Gradient Background'),
        centerTitle: false,
        actions: [
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
      endDrawer: SizedBox(
        width: 400.0,
        child: Drawer(
          child: Container(
            constraints: BoxConstraints.tightForFinite(),
            color: Colors.white,
          ),
        ),
      ),
      body: LayoutBuilder(builder: (context, BoxConstraints constraints) {
        return AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, Widget? child) {
              final List<Color> colors = controller.gradient.colors.isNotEmpty
                  ? controller.gradient.colors
                  : defaultGradientItem.colors;
              final String text = controller.text.isNotEmpty
                  ? controller.text
                  : controller.gradient.name;

              return Stack(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    constraints: BoxConstraints.tightForFinite(),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: colors,
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(top: 300.0),
                      padding: const EdgeInsets.symmetric(horizontal: 100.0),
                      child: Text(
                        text,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 40.0),
                      ),
                    ),
                  ),
                  Align(
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
                ],
              );
            });
      }),
    );
  }
}
