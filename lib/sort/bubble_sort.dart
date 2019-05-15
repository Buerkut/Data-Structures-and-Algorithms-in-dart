void bubbleSort<E extends Comparable>(List<E> a) {
  for (var i = a.length - 1; i > 0; i--)
    for (var j = 0; j < i; j++)
      if (a[j].compareTo(a[j + 1]) > 0) _swap(a, j, j + 1);
}

void _swap<E>(List<E> a, int i, int j) {
  var t = a[i];
  a[i] = a[j];
  a[j] = t;
}
