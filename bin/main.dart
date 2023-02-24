import 'dart:math';

import 'package:data_struct/sort/sort.dart';

void main() {
  var len = 16, max = 11000, rnd = Random();
  var a = List.generate(len, (_) => rnd.nextInt(max), growable: false);
  print(a);
  radixSort(a);
  print(a);
}
