// import 'dart:io';
import 'package:data_struct/tree/src/ternary_tree.dart';

void ternaryTest<E extends Comparable<E>>(List<E> a) {
  var tree = TernaryTree.of(a);
  // print('check result: ${check(tree)}');
  check(tree);
  // print('-------------------');
  // print('a.lenght: ${a.length}, tree.elementsCount: ${tree.elementsCount}');
  // print('root: ${tree.root}  height: ${tree.height}');
  // stdin.readLineSync();
  // print('-------------------');
  // print('start to $i times ternary deleting test...');
  for (var e in a) {
    // print('-------------------');
    // print('delete: $e');
    tree.delete(e);
    // print('-------------------');
    // print('tree.elementsCount: ${tree.elementsCount}');
    // print('new root: ${tree.root}  height: ${tree.height}');
    // print('check result: ${check(tree)}');
    check(tree);
  }
}

bool check(TernaryTree tree) {
  if (!tree.isEmpty) assert(tree.height == _walk(tree.root!));
  return true;
}

int _walk(TerNode r) {
  assert(!r.isOverflow);
  for (var i = 0; i + 1 < r.size; i++)
    assert(r.items[i].compareTo(r.items[i + 1]) < 0);

  if (r.isLeaf) return 1;
  assert(r.size + 1 == r.branches.length);
  var heights = <int>[];
  for (var b in r.branches) heights.add(_walk(b));
  for (var h in heights) assert(h == heights.first);
  return heights.first + 1;
}
