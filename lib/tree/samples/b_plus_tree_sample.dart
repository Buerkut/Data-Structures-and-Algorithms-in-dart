import 'dart:math';
import 'package:data_struct/tree/src/b_plus_tree.dart';

void test() {
  var len = 1000000, rd = Random();
  for (var i = 0; i < 1024; i++) {
    for (var order = 4; order <= 1024; order++) {
      var a = List<num>.generate(len, (_) => rd.nextInt(len << 4));
      var tree = BPlusTree.of(a, a, order);
      // print(a);
      print('a.length: ${a.length}, tree.elemCount: ${tree.elemCount}');
      print(tree.height);
      // tree.traverse(print);
      print('-----------------------');
      // var d = 26;
      // print(tree.find(d));
      for (var i in a) {
        print(tree.delete(i));
      }
      print('-----------------------');
      // print('tree.height: ${tree.height}, tree.elemCount: ${tree.elemCount}');
    }
  }
}
