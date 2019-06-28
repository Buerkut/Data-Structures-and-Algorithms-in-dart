import 'dart:math';
import 'package:data_struct/sort/heap_sort.dart';
// import 'package:data_struct/queue/priority_queue2.dart';

void main() {
  var rd = Random();
  List<num> a = List.generate(12, (_) => rd.nextInt(200));
  // var queue = PriorityQueue.fromIterables(a);
  print(a);
  print('---------------------------------');
  heapSort(a);
  print(a);
}
