import 'package:flutter/material.dart';

import '../colors.dart';
import './tree_node.dart';
import '../models/data_item.dart';

TextPainter _textPainter = TextPainter(
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

  _textPainter
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
  Rect rect,
  Color color,
  String text,
) {
  paint.color = color;
  canvas.drawRect(rect, paint);
  canvas.drawRect(rect, linePaint);
  _drawText(
    text,
    canvas,
    Offset(
        rect.left + rect.width / 2 - 12.0, rect.top + rect.height / 2 - 12.0),
  );
}

void drawTreeRects(
  Canvas canvas,
  TreeNode? node,
  Rect rootRectLeft,
  TreeNode? rootNodeLeft,
  int level,
  List<DataItem> data,
  double animationValue,
) {
  if (node == null) {
    return;
  }
  if (node.left == null && node.right == null) {
    return;
  }

  Rect rectLeft;
  Rect rectRight;
  double left;
  double top;
  double width;
  double height;

  if (level.isEven) {
    top = rootRectLeft.top;
    left = rootRectLeft.left;
    width = rootRectLeft.width;
    height = (node.left!.item.value / rootNodeLeft!.item.value) *
        rootRectLeft.height;
    rectLeft = Rect.fromLTWH(left, top, width, height);

    _drawPartRect(
      canvas,
      rectLeft,
      node.left?.color ?? colors[0],
      (node.left!.item.value * animationValue).toStringAsFixed(0),
    );

    left = rootRectLeft.left;
    top = rootRectLeft.top + height;
    width = rootRectLeft.width;
    height = (node.right!.item.value / rootNodeLeft.item.value) *
        rootRectLeft.height;
    rectRight = Rect.fromLTWH(left, top, width, height);

    _drawPartRect(
      canvas,
      rectRight,
      node.right?.color ?? colors[0],
      (node.right!.item.value * animationValue).toStringAsFixed(0),
    );
  } else {
    top = rootRectLeft.top;
    height = rootRectLeft.height;
    left = rootRectLeft.left;
    width =
        (node.left!.item.value / rootNodeLeft!.item.value) * rootRectLeft.width;
    rectLeft = Rect.fromLTWH(left, top, width, height);

    _drawPartRect(
      canvas,
      rectLeft,
      node.left?.color ?? colors[0],
      (node.left!.item.value * animationValue).toStringAsFixed(0),
    );

    top = rootRectLeft.top;
    height = rootRectLeft.height;
    left = rootRectLeft.left + width;
    width =
        (node.right!.item.value / rootNodeLeft.item.value) * rootRectLeft.width;
    rectRight = Rect.fromLTWH(left, top, width, height);

    _drawPartRect(
      canvas,
      rectRight,
      node.right?.color ?? colors[0],
      (node.right!.item.value * animationValue).toStringAsFixed(0),
    );
  }

  level++;
  // 递归绘制左节点
  drawTreeRects(
      canvas, node.left, rectLeft, node.left, level, data, animationValue);
  // 递归绘制右节点
  drawTreeRects(
      canvas, node.right, rectRight, node.right, level, data, animationValue);
}
