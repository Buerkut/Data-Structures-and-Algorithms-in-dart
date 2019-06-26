import 'dart:math';
import 'package:data_struct/sort/heap_sort.dart';

void main() {
  var rd = Random();
  List<num> a = List.generate(10, (_) => rd.nextInt(200));

  print(a);
  print('----------------------');
  heapSort(a);
  print(a);
  print('----------------------');
}
