import '../../exports.dart';
import '../models/data_item.dart';

class TreeNode {
  DataItem item;
  TreeNode? left;
  TreeNode? right;
  Color? color;

  TreeNode(
    this.item,
    this.left,
    this.right, {
    this.color,
  });

  @override
  String toString() {
    debugPrint('TreeNode: $item');
    return super.toString();
  }
}
