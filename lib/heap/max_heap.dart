class MaxHeap<E extends Comparable<E>> {
  List<E> _heap;
  int _size;

  MaxHeap([Iterable<Comparable<E>> elements]) {
    elements ??= <E>[];
    _heap = elements.toList();
    _size = elements.length;
    _buildMaxHeap();
  }

  bool get isEmpty => _size == 0;

  int get size => _size;

  E get top => _size == 0 ? null : _heap[0];

  E popTop() => _size == 0 ? null : pop(1).first;

  Iterable<E> pop(int n) sync* {
    if (n > _size) n = _size;
    while (n-- > 0) {
      var e = _heap[0];
      _swap(0, --_size);
      _maxHeapify(0);
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
    _maxHeapify(i);
    return e;
  }

  void sort() {
    while (_size-- > 0) {
      _swap(0, _size);
      _maxHeapify(0);
    }
  }

  String toString() => _heap.getRange(0, size).toString();

  void _buildMaxHeap() {
    for (var i = (_size - 2) >> 1; i >= 0; i--) _maxHeapify(i);
  }

  void _maxHeapify(int i) {
    var mi = i, l = (i << 1) + 1, r = (i << 1) + 2;
    if (l < _size && _heap[l].compareTo(_heap[mi]) > 0) mi = l;
    if (r < _size && _heap[r].compareTo(_heap[mi]) > 0) mi = r;
    if (mi != i) {
      _swap(i, mi);
      _maxHeapify(mi);
    }
  }

  void _bubble(int i) {
    if (i == 0) return;
    var pi = (i - 1) >> 1;
    if (_heap[i].compareTo(_heap[pi]) > 0) {
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
