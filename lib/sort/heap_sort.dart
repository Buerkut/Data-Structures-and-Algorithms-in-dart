void heapSort<E extends Comparable<E>>(List<E> a) {
  _buildMaxHeap(a);

  for (var i = a.length; i > 0; i--) {
    _swap(a, 0, i - 1);
    _maxHeapify(a, 0, i - 1);
  }
}

void _buildMaxHeap<E extends Comparable<E>>(List<E> a) {
  for (var i = (a.length - 2) >> 1; i >= 0; i--) _maxHeapify(a, i, a.length);
}

void _maxHeapify<E extends Comparable<E>>(List<E> a, int i, int size) {
  var mi = i, l = (i << 1) + 1, r = (i << 1) + 2;
  if (l < size && a[l].compareTo(a[mi]) > 0) mi = l;
  if (r < size && a[r].compareTo(a[mi]) > 0) mi = r;
  if (mi != i) {
    _swap(a, i, mi);
    _maxHeapify(a, mi, size);
  }
}

void _swap<E>(List<E> a, int i, int j) {
  var t = a[i];
  a[i] = a[j];
  a[j] = t;
}
