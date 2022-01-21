import 'dart:ui';

import '../colors.dart';
import './tree_node.dart';
import '../models/data_item.dart';

TreeNode parseArrayToBST(List<DataItem> array, List<Color> theme) {
  int n = array.length;
  double sum = 0.0;
  List<double> sums = List.filled(n + 1, 0);
  sums[0] = 0.0;

  for (int i = 0; i < n; i++) {
    sum += array[i].value;
    sums[i + 1] = sum;
  }

  final TreeNode root =
      TreeNode(DataItem(name: 'root', value: sums.last), null, null);

  void partition(int start, int end, TreeNode node) {
    if (start >= end - 1) {
      node.item.name = array[start].name;
      node.color = theme[start];
      return;
    }

    double valueOffset = sums[start];
    double valueTarget = (node.item.value / 2) + valueOffset;
    int left = start + 1;
    int right = end - 1;

    while (left < right) {
      int mid = left + right >> 1;

      if (sums[mid] < valueTarget) {
        left = mid + 1;
      } else {
        right = mid;
      }
    }

    if ((valueTarget - sums[left - 1] < (sums[left] - valueTarget) &&
        start + 1 < left)) {
      left--;
    }

    double valueLeft = sums[left] - valueOffset;
    double valueRight = node.item.value - valueLeft;
    TreeNode nodeLeft =
        TreeNode(DataItem(name: node.item.name, value: valueLeft), null, null);
    TreeNode nodeRight =
        TreeNode(DataItem(name: node.item.name, value: valueRight), null, null);

    node.left = nodeLeft;
    node.right = nodeRight;

    partition(start, left, nodeLeft);
    partition(left, end, nodeRight);
  }

  partition(0, n, root);

  return root;
}
