import 'package:data_struct/heap/min_heap.dart';

class PriorityQueue<E extends Comparable<E>> extends MinHeap<E> {
  PriorityQueue([Iterable<Comparable<E>> elements]) : super(elements);
}
