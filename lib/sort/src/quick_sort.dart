void quickSort<E extends Comparable>(List<E> a) {
  _quickSort(a, 0, a.length - 1);
}

void _quickSort<E extends Comparable>(List<E> a, int start, int end) {
  if (start >= end) return;
  var pl = start, pr = end, key = a[pl];
  while (pl < pr) {
    while (a[pr].compareTo(key) >= 0 && pr > pl) pr--;
    if (pr > pl) a[pl++] = a[pr];
    while (a[pl].compareTo(key) <= 0 && pl < pr) pl++;
    if (pl < pr) a[pr--] = a[pl];
  }
  if (a[pl] != key) a[pl] = key;

  _quickSort(a, start, pl - 1);
  _quickSort(a, pl + 1, end);
}
