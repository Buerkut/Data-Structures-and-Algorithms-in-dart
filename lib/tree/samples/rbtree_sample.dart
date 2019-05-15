import 'dart:math';
import 'package:data_struct/tree/tree.dart';

void rbtreeTest<E extends Comparable<E>>(List<E> a) {
  var tree = RBTree.of(a);
  check(tree);
  for (var e in a) {
    // tree.quickDelete(e);
    tree.delete(e);
    check(tree);
  }
}

void stress(int size) {
  var rd = Random();
  var arr = List.generate(size, (_) => rd.nextDouble() * size);

  var tree = RBTree.of(arr);
  var st = DateTime.now();
  for (var d in arr) tree.delete(d);
  var ft = DateTime.now();
  print('my delete implement cost:\t${ft.difference(st)}');

  tree = RBTree.of(arr);
  st = DateTime.now();
  for (var d in arr) tree.quickDelete(d);
  ft = DateTime.now();
  print('    linux implement cost:\t${ft.difference(st)}');
}

void traverse(RBTNode r, void func(RBTNode r)) {
  if (r != null) {
    traverse(r.left, func);
    func(r);
    traverse(r.right, func);
  }
}

void check(RBTree tree) {
  assert(tree.isEmpty || (!tree.isEmpty && tree.root.isBlack));
  _walk(tree.root);
}

int _walk(RBTNode r) {
  if (r == null) return 0;
  assert(r.isBlack || (r.isRed && r.parent.isBlack));
  var lbh = _walk(r.left);
  var rbh = _walk(r.right);
  assert(lbh == rbh);
  return lbh + (r.isRed ? 0 : 1);
}
