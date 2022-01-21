import 'dart:math' as math;

import '../models/data_item.dart';
import '../../exports.dart';

import './tree_node.dart';
import './parse_array_to_bst.dart';
import './draw_tree_rects.dart';

void drawTreeMapChart(
  List<DataItem>? datas,
  List<Color> theme,
  double paddding,
  Canvas canvas,
  Size size,
) {
  Rect rootRect = Rect.fromLTWH(
    paddding,
    paddding,
    size.width - paddding * 2,
    size.height - paddding,
  );
  TreeNode rootNode = parseArrayToBST(datas!, theme);

  drawTreeRects(
    canvas,
    rootNode,
    rootRect,
    rootNode,
    0,
    datas,
  );
}
