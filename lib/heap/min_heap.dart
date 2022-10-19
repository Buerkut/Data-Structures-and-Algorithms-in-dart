class MinHeap<E extends Comparable<E>> {
  late List<E> _heap;
  late int _size;

  MinHeap([Iterable<E>? elements]) {
    elements ??= <E>[];
    _heap = elements.toList();
    _size = elements.length;
    _buildMinHeap();
  }

  bool get isEmpty => _size == 0;

  int get size => _size;

  E get top {
    if (isEmpty) throw StateError('The heap is empty!');
    return _heap[0];
  }

  E popTop() {
    if (isEmpty) throw StateError('The heap is empty!');
    return pop(1).first;
  }

  // pop the first n element.
  Iterable<E> pop(int n) sync* {
    if (n > _size) n = _size;
    while (n-- > 0) {
      var e = _heap[0];
      _swap(0, --_size);
      _minHeapify(0);
      yield e;
    }
  }

  void push(E value) {
    _heap.add(value);
    _bubble(_size++);
  }

  E remove(int i) {
    if (i < 0 || i > _size - 1) throw StateError('out of range!');
    var e = _heap[i];
    _swap(i, --_size);
    _minHeapify(i);
    _bubble(i);
    return e;
  }

  String toString() => _heap.getRange(0, size).toString();

  void _buildMinHeap() {
    for (var i = (_size >> 1) - 1; i >= 0; i--) _minHeapify(i);
  }

  void _minHeapify(int i) {
    var mi = i, l = (i << 1) + 1, r = (i << 1) + 2;
    if (l < _size && _heap[l].compareTo(_heap[mi]) < 0) mi = l;
    if (r < _size && _heap[r].compareTo(_heap[mi]) < 0) mi = r;
    if (mi != i) {
      _swap(i, mi);
      _minHeapify(mi);
    }
  }

  void _bubble(int i) {
    if (i == 0) return;
    var pi = (i - 1) >> 1;
    if (_heap[i].compareTo(_heap[pi]) < 0) {
      _swap(i, pi);
      _bubble(pi);
    }
  }

  void _swap(int i, int j) {
    var t = _heap[i];
    _heap[i] = _heap[j];
    _heap[j] = t;
  }
}
