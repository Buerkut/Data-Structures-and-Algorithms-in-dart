import 'dart:math';
import 'package:data_struct/tree/samples/rbtree_sample.dart';
import 'package:data_struct/tree/samples/ternary_tree_sample.dart';
import 'package:data_struct/tree/samples/quaternary_tree_sample.dart';
import 'package:data_struct/tree/samples/octonary_tree_sample.dart';
import 'package:data_struct/tree/samples/btree_sample.dart';

void treeTest() {
  var size = 10000, loops = 1024, rd = Random();
  print('\nsize: $size, loop times: $loops\n');
  for (var i = 0; i < loops; i++) {
    print('-------------------\n'
        'the $i times test...\n'
        '-------------------\n');
    var list = List<num>.generate(size, (_) => rd.nextInt(size << 4));

    print('start rbtreeTest...\n');
    rbtreeTest(list);

    print('start ternaryTest...\n');
    ternaryTest(list);

    print('start quaternaryTest...\n');
    quaternaryTest(list);

    print('start octonaryTest...\n');
    octonaryTest(list);

    print('start btreeTest...\n');
    btreeTest(list);
  }
}
