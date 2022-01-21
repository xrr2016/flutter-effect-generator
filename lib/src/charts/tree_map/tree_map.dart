import 'package:flutter/material.dart';

import '../chart_container.dart';
import '../chart_type.dart';
import '../charts_controller.dart';
import '../colors.dart';
import './tree_node.dart';
import './parse_array_to_bst.dart';
import './draw_tree_rects.dart';
import '../models/data_item.dart';

class TreeMap extends StatefulWidget {
  final String title;
  final List<Color> theme;
  final List<DataItem> data;

  TreeMap({
    Key? key,
    required this.data,
    required this.theme,
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
      duration: Duration(milliseconds: 300),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChartContainer(
      title: Row(
        children: [
          SizedBox(width: 20.0),
          Text(
            widget.title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      painter: TreeMapPainter(
        data: widget.data,
        theme: widget.theme,
        animation: _controller,
      ),
      type: ChartType.treeMap,
      legend: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          widget.data.length,
          (index) => Container(
            width: 50.0,
            height: 22.0,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            color: colors1[index % colors1.length],
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
    );
  }
}

class TreeMapPainter extends CustomPainter {
  TreeMapPainter({
    required this.data,
    required this.theme,
    required this.animation,
  }) : super(repaint: animation) {
    _total = data.fold(0, (sum, item) => sum + item.value);
    _rootNode = parseArrayToBST(data, theme);
  }

  final List<Color> theme;
  final List<DataItem> data;
  final Animation<double> animation;

  double _total = 0.0;
  late TreeNode _rootNode;

  @override
  void paint(Canvas canvas, Size size) {
    Rect rootRect = Rect.fromLTWH(0, 0, size.width, size.height);

    drawTreeRects(canvas, _rootNode, rootRect, _rootNode, 0, data);
  }

  @override
  bool shouldRepaint(TreeMapPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(TreeMapPainter oldDelegate) => false;
}
