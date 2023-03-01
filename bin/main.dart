import 'dart:math';

import 'package:data_struct/sort/sort.dart';

void main() {
  var len = 7, max = 100, rnd = Random();
  var a = List.generate(len, (_) => rnd.nextInt(max), growable: false);
  // var a = <int>[9, 4, 26, 1];
  print(a);

  print(getMinMaxInt(a));
}
