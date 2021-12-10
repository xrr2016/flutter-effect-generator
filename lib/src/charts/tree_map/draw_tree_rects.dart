import 'package:flutter/material.dart';

import '../colors.dart';
import './tree_node.dart';

TextPainter textPainter = TextPainter(
  text: TextSpan(),
  textAlign: TextAlign.center,
  textDirection: TextDirection.ltr,
)..layout(
    minWidth: 0.0,
    maxWidth: 100.0,
  );

void _drawText(String text, Canvas canvas, Offset offset) {
  TextSpan textSpan = TextSpan(
    text: text,
    style: TextStyle(
      fontSize: 20.0,
      color: Colors.white,
    ),
  );

  textPainter
    ..text = textSpan
    ..layout(
      minWidth: 0.0,
      maxWidth: 100.0,
    )
    ..paint(canvas, offset);
}

Paint linePaint = Paint()
  ..style = PaintingStyle.stroke
  ..color = Colors.white
  ..strokeWidth = 2.0
  ..isAntiAlias = true;

Paint paint = Paint()
  ..style = PaintingStyle.fill
  ..isAntiAlias = true
  ..color = colors[0];

void _drawPartRect(
  Canvas canvas,
  double left,
  double top,
  double width,
  double height,
  String text,
) {
  Rect rect = Rect.fromLTWH(left, top, width, height);
  canvas.drawRect(rect, paint);
  canvas.drawRect(rect, linePaint);
  _drawText(
    text,
    canvas,
    Offset(left + width / 2 - 12.0, top + height / 2 - 12.0),
  );
}

void drawTreeRects(
  Canvas canvas,
  TreeNode? node,
  Rect rootRectLeft,
  TreeNode? rootNodeLeft,
  int level,
  double total,
) {
  if (node == null) {
    return;
  }
  if (node.left == null && node.right == null) {
    return;
  }

  Rect rectLeft;
  Rect rectRight;

  if (level.isEven) {
    double left;
    double top;
    double width;
    double height;

    top = rootRectLeft.top;
    left = rootRectLeft.left;
    width = rootRectLeft.width;
    height = (node.left!.item.value / rootNodeLeft!.item.value) *
        rootRectLeft.height;

    rectLeft = Rect.fromLTWH(left, top, width, height);

    _drawPartRect(
      canvas,
      left,
      top,
      width,
      height,
      node.left!.item.value.toString(),
    );

    left = rootRectLeft.left;
    top = rootRectLeft.top + height;
    width = rootRectLeft.width;
    height = (node.right!.item.value / rootNodeLeft.item.value) *
        rootRectLeft.height;

    _drawPartRect(
      canvas,
      left,
      top,
      width,
      height,
      node.right!.item.value.toString(),
    );
    rectRight = Rect.fromLTWH(left, top, width, height);
  } else {
    double left;
    double width;
    double top = rootRectLeft.top;
    double height = rootRectLeft.height;

    // left node
    left = rootRectLeft.left;
    width =
        (node.left!.item.value / rootNodeLeft!.item.value) * rootRectLeft.width;

    _drawPartRect(
      canvas,
      left,
      top,
      width,
      height,
      node.left!.item.value.toString(),
    );
    rectLeft = Rect.fromLTWH(left, top, width, height);

    top = rootRectLeft.top;
    height = rootRectLeft.height;
    left = rootRectLeft.left + width;
    width =
        (node.right!.item.value / rootNodeLeft.item.value) * rootRectLeft.width;

    _drawPartRect(
      canvas,
      left,
      top,
      width,
      height,
      node.right!.item.value.toString(),
    );

    rectRight = Rect.fromLTWH(left, top, width, height);
  }

  level++;

  // 递归绘制左节点
  drawTreeRects(
    canvas,
    node.left,
    rectLeft,
    node.left,
    level,
    total,
  );
  // 递归绘制右节点
  drawTreeRects(
    canvas,
    node.right,
    rectRight,
    node.right,
    level,
    total,
  );
}
