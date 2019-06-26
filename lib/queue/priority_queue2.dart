import 'package:data_struct/heap/min_heap.dart';

class PriorityQueue2<E extends Comparable<E>> extends MinHeap<E> {
  PriorityQueue2([Iterable<Comparable<E>> elements]) : super(elements);
}
