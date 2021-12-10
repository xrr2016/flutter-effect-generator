import 'package:flutter/material.dart';

import './parse_array_to_bst.dart';
import './tree_node.dart';
import './draw_tree_rects.dart';
import '../colors.dart';
import '../models/data_item.dart';

class TreeMap extends StatefulWidget {
  final Widget title;
  final List<DataItem> data;

  TreeMap({
    Key? key,
    required this.data,
    required this.title,
  }) : super(key: key);

  @override
  _TreeMapState createState() => _TreeMapState();
}

class _TreeMapState extends State<TreeMap> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: CustomPaint(
            painter: TreeMapPainter(
              data: widget.data,
              animation: _controller,
            ),
            child: SizedBox(width: 480.0, height: 480.0),
          ),
        ),
        Align(alignment: Alignment.topCenter, child: widget.title),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.data.length,
              (index) => Container(
                width: 50.0,
                height: 24.0,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                color: colors[index % colors.length],
                alignment: Alignment.center,
                child: Text(
                  widget.data[index].name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TreeMapPainter extends CustomPainter {
  TreeMapPainter({
    required this.data,
    required this.animation,
  }) {
    datas = data.map((e) => e.value).toList();
  }

  final List<DataItem> data;
  final Animation<double> animation;

  List<double> datas = [];

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black26
      ..style = PaintingStyle.fill;
    Rect rootRect = Rect.fromLTWH(0, 0, size.width, size.height);
    TreeNode rootNode = parseArrayToBST(datas);
    canvas.drawRect(rootRect, paint);

    drawTreeRects(
      rootNode,
      rootRect,
      rootNode,
      0,
      canvas,
      // scale: scale.value,
      // color: color.value,
    );
  }

  @override
  bool shouldRepaint(TreeMapPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(TreeMapPainter oldDelegate) => false;
}
