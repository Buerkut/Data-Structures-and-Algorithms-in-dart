import 'dart:math';

import 'package:data_struct/sort/sort.dart';

void main() {
  var len = 7, max = 100, rnd = Random();
  var a = List.generate(len, (_) => rnd.nextInt(max), growable: false);
  // var a = <int>[9, 4, 26, 1];
  print(a);

  print(getMinMaxInt(a));

  var b = List.generate(11, (_) => 1 + rnd.nextInt(10));
  print(b);

  final s = [1, 3, 0, 5, 3, 5, 6, 8, 8, 2, 12];

  print(s.length);
  print(b.length);
}
