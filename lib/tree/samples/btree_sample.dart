import 'package:data_struct/tree/src/b_tree.dart';

void btreeTest<E extends Comparable<E>>(List<E> list) {
  for (var order = 3; order <= 1024; order++) {
    print('order: $order');
    var tree = BTree.of(list, order);
    // print('check result: ${check(tree)}');
    check(tree);
    // print('-------------------');
    // print('a.lenght: ${list.length}, tree.elementsCount: ${tree.elemCount}');
    // print('tree.order: ${tree.order}');
    // print('root: ${tree.root}  height: ${tree.height}');
    // print('tree.height: ${tree.height}');
    // tree.traverse(print);
    for (var e in list) {
      // print('-------------------');
      // print('delete: $e');
      tree.delete(e);
      // print('tree.elementsCount: ${tree.elemCount}');
      // print('new root: ${tree.root}  height: ${tree.height}');
      // print('check result: ${check(tree)}');
      check(tree);
    }
  }
}

bool check(BTree tree) {
  if (!tree.isEmpty) assert(tree.height == _walk(tree.root, tree.order));
  return true;
}

int _walk(BTreeNode r, int order) {
  assert(r.parent == null ||
      ((r.size >= (order / 2).ceil() - 1) && (r.size < order)));
  for (var i = 0; i + 1 < r.size; i++)
    assert(r.items[i].compareTo(r.items[i + 1]) < 0);

  if (r.isLeaf) return 1;
  assert(r.size + 1 == r.branches.length);
  var heights = <int>[];
  for (var b in r.branches) heights.add(_walk(b, order));
  for (var h in heights) assert(h == heights.first);
  return heights.first + 1;
}
