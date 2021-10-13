import '../../exports.dart';
import '../glassmorphism_controller.dart';

class GlassmorphismControl extends StatefulWidget {
  final GlassmorphismController controller;

  const GlassmorphismControl({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<GlassmorphismControl> createState() => _GlassmorphismControlState();
}

class _GlassmorphismControlState extends State<GlassmorphismControl> {
  List<Widget> _buildColorItems() {
    List<Widget> items = [];

    colors.asMap().forEach((key, color) {
      items.add(
        InkWell(
          onTap: () {
            widget.controller.changeColor(color);
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
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
          title: Text('Color'),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.5,
            padding: const EdgeInsets.all(20.0),
            child: GridView.count(
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              crossAxisCount: 10,
              children: _buildColorItems(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 50.0),
      height: 800.0,
      width: 400.0,
      child: Column(
        children: [
          ListTile(
            leading: Text(
              'Color',
              style: TextStyle(color: Colors.white),
            ),
            trailing: InkWell(
              onTap: () {
                _openDialog();
              },
              child: Container(
                width: 24.0,
                height: 24.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.controller.color,
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Text(
              'Width',
              style: TextStyle(color: Colors.white),
            ),
            title: Slider(
              min: 200.0,
              max: 800.0,
              value: widget.controller.width,
              activeColor: Colors.amber,
              inactiveColor: Colors.white70,
              onChanged: widget.controller.changeWidth,
            ),
            trailing: Text(
              widget.controller.width.toInt().toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: Text(
              'Height',
              style: TextStyle(color: Colors.white),
            ),
            title: Slider(
              min: 200.0,
              max: 600.0,
              value: widget.controller.height,
              activeColor: Colors.amber,
              inactiveColor: Colors.white70,
              onChanged: widget.controller.changeHeight,
            ),
            trailing: Text(
              widget.controller.height.toInt().toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: Text(
              'Opacity',
              style: TextStyle(color: Colors.white),
            ),
            title: Slider(
              min: 0.1,
              max: 0.8,
              value: widget.controller.opacity,
              activeColor: Colors.amber,
              inactiveColor: Colors.white70,
              onChanged: widget.controller.changeOpacity,
            ),
            trailing: Text(
              widget.controller.opacity.toStringAsFixed(1),
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: Text(
              'Blur',
              style: TextStyle(color: Colors.white),
            ),
            title: Slider(
              min: 1.0,
              max: 30.0,
              value: widget.controller.blur,
              activeColor: Colors.amber,
              inactiveColor: Colors.white70,
              onChanged: widget.controller.changeBlur,
            ),
            trailing: Text(
              widget.controller.blur.toStringAsFixed(1),
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: Text(
              'Radius',
              style: TextStyle(color: Colors.white),
            ),
            title: Slider(
              min: 1.0,
              max: 30.0,
              value: widget.controller.radius,
              activeColor: Colors.amber,
              inactiveColor: Colors.white70,
              onChanged: widget.controller.changeRadius,
            ),
            trailing: Text(
              widget.controller.radius.toStringAsFixed(1),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
