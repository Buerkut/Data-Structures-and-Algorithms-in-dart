List<E> merge<E extends Comparable>(List<E> sortedA, List<E> sortedB) {
  var merged = List<E>(sortedA.length + sortedB.length), ai = 0, bi = 0, mi = 0;
  while (ai < sortedA.length && bi < sortedB.length) {
    merged[mi++] =
        sortedA[ai].compareTo(sortedB[bi]) <= 0 ? sortedA[ai++] : sortedB[bi++];
  }
  if (ai < sortedA.length) {
    while (ai < sortedA.length) merged[mi++] = sortedA[ai++];
  } else {
    while (bi < sortedB.length) merged[mi++] = sortedB[bi++];
  }
  return merged;
}

void mergeSort<E extends Comparable>(List<E> a) {
  if (a.length > 1) _mergeSort(a, 0, a.length - 1);
}

void _mergeSort<E extends Comparable>(List<E> a, int start, int end) {
  if (start == end) return;
  int mid = (start + end) ~/ 2;
  _mergeSort(a, start, mid);
  _mergeSort(a, mid + 1, end);
  _merge(a, start, mid, end);
}

void _merge<E extends Comparable>(List<E> a, int start, int mid, int end) {
  var merged = List<E>(end - start + 1), mi = 0, li = start, ri = mid + 1;
  while (li <= mid && ri <= end) {
    merged[mi++] = a[li].compareTo(a[ri]) <= 0 ? a[li++] : a[ri++];
  }
  if (li <= mid) {
    while (li <= mid) merged[mi++] = a[li++];
  } else {
    while (ri <= end) merged[mi++] = a[ri++];
  }
  for (var e in merged) a[start++] = e;
}
