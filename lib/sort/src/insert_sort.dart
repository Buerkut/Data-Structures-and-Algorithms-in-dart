void insertSort<E extends Comparable<E>>(List<E> a) {
  for (var i = 1; i < a.length; i++) {
    var j = i - 1, t = a[i];
    while (j >= 0 && t.compareTo(a[j]) < 0) {
      a[j + 1] = a[j];
      j--;
    }
    // if (j < i - 1) a[j + 1] = t;
    a[j + 1] = t;
  }
}
