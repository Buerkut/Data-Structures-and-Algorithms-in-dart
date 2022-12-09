void selectSort<E extends Comparable<E>>(List<E> a) {
  for (var i = 0; i < a.length - 1; i++) {
    var mi = i;
    for (var j = i + 1; j < a.length; j++) {
      if (a[j].compareTo(a[mi]) < 0) mi = j;
    }
    // if (i != mi) _swap(a, i, mi);
    _swap(a, i, mi);
  }
}

void _swap<E>(List<E> a, int i, int j) {
  var t = a[i];
  a[i] = a[j];
  a[j] = t;
}
