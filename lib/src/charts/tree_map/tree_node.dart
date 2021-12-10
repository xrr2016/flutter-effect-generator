import '../../exports.dart';
import '../models/data_item.dart';

class TreeNode {
  DataItem item;
  TreeNode? left;
  TreeNode? right;

  TreeNode(
    this.item,
    this.left,
    this.right,
  );

  @override
  String toString() {
    debugPrint('TreeNode: $item');
    return super.toString();
  }
}
