import 'dart:math';
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

void _drawText(double value, Canvas canvas, Offset offset) {
  TextSpan textSpan = TextSpan(
    text: value.toString(),
    style: TextStyle(
      fontSize: 24.0,
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
  ..isAntiAlias = true;

void drawTreeRects(
  TreeNode? node,
  Rect rootRectLeft,
  TreeNode? rootNodeLeft,
  int level,
  Canvas canvas, {
  Color? color = Colors.blue,
}) {
  if (node == null) {
    return;
  }
  if (node.left == null && node.right == null) {
    return;
  }

  Rect rectLeft;
  Rect rectRight;

  if (level.isEven) {
    paint.color = colors[Random().nextInt(colors.length)];

    double left;
    double top;
    double width;
    double height;

    top = rootRectLeft.top;
    left = rootRectLeft.left;
    width = rootRectLeft.width;
    height = (node.left!.value / rootNodeLeft!.value) * rootRectLeft.height;

    Offset rectLeftCenter = Offset(width / 2 + left, height / 2 + top);
    rectLeft = Rect.fromCenter(
      center: rectLeftCenter,
      width: width,
      height: height,
    );
    canvas.drawRect(rectLeft, paint);

    Rect rectLineLeft = Rect.fromLTWH(left, top, width, height);
    canvas.drawRect(rectLineLeft, linePaint);

    _drawText(
      node.left!.value,
      canvas,
      Offset(left + width / 2 - 12.0, top + height / 2 - 12.0),
    );

    left = rootRectLeft.left;
    top = rootRectLeft.top + height;
    width = rootRectLeft.width;
    height = (node.right!.value / rootNodeLeft.value) * rootRectLeft.height;

    Offset rectRightCenter = Offset(width / 2 + left, height / 2 + top);
    rectRight = Rect.fromCenter(
      center: rectRightCenter,
      width: width,
      height: height,
    );
    canvas.drawRect(rectRight, paint);

    Rect rectLineRight = Rect.fromLTWH(left, top, width, height);
    canvas.drawRect(rectLineRight, linePaint);

    _drawText(
      node.right!.value,
      canvas,
      Offset(left + width / 2 - 12.0, top + height / 2 - 12.0),
    );
  } else {
    paint.color = colors[Random().nextInt(colors.length)];

    double left;
    double width;
    double top = rootRectLeft.top;
    double height = rootRectLeft.height;

    // left node
    left = rootRectLeft.left;
    width = (node.left!.value / rootNodeLeft!.value) * rootRectLeft.width;

    Offset rectLeftCenter = Offset(width / 2 + left, height / 2 + top);
    rectLeft = Rect.fromCenter(
      center: rectLeftCenter,
      width: width,
      height: height,
    );
    canvas.drawRect(rectLeft, paint);

    Rect rectLineLeft = Rect.fromLTWH(left, top, width, height);
    canvas.drawRect(rectLineLeft, linePaint);

    _drawText(
      node.left!.value,
      canvas,
      Offset(left + width / 2 - 12.0, top + height / 2 - 12.0),
    );

    top = rootRectLeft.top;
    height = rootRectLeft.height;
    left = rootRectLeft.left + width;
    width = (node.right!.value / rootNodeLeft.value) * rootRectLeft.width;

    Offset rectRightCenter = Offset(width / 2 + left, height / 2 + top);
    rectRight = Rect.fromCenter(
      center: rectRightCenter,
      width: width,
      height: height,
    );
    canvas.drawRect(rectRight, paint);

    Rect rectLineRight = Rect.fromLTWH(left, top, width, height);
    canvas.drawRect(rectLineRight, linePaint);

    _drawText(
      node.right!.value,
      canvas,
      Offset(left + width / 2 - 12.0, top + height / 2 - 12.0),
    );
  }

  level++;

  // 递归绘制左节点
  drawTreeRects(
    node.left,
    rectLeft,
    node.left,
    level,
    canvas,
    color: color,
  );
  // 递归绘制右节点
  drawTreeRects(
    node.right,
    rectRight,
    node.right,
    level,
    canvas,
    color: color,
  );
}
