import 'package:data_struct/heap/min_heap.dart';

class PriorityQueue<E extends Comparable<E>> {
  MinHeap<E> _heap;

  PriorityQueue([Iterable<Comparable<E>> elements]) {
    _heap = MinHeap(elements);
  }

  bool get isEmpty => _heap.isEmpty;

  int get size => _heap.size;

  E get top => _heap.top;

  E popTop() => _heap.popTop();

  Iterable<E> pop(int n) sync* {
    yield* _heap.pop(n);
  }

  void push(E value) => _heap.push(value);

  E remove(int i) => _heap.remove(i);

  String toString() => _heap.toString();
}
