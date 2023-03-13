int inversePairs(List<int> a) {
  return _walk(a, 0, a.length - 1);
}

int _walk(List<int> a, int start, int end) {
  if (start >= end) return 0;
  var mid = (start + end) >> 1;
  var lipc = _walk(a, start, mid); // left inverse paires count.
  var ripc = _walk(a, mid + 1, end);
  var count = _check(a, start, mid, end);

  return lipc + ripc + count;
}

int _check(List<int> a, int start, int mid, int end) {
  var merged = List<int?>.filled(end - start + 1, null),
      mi = 0,
      li = start,
      ri = mid + 1;
  var count = 0;
  while (li <= mid && ri <= end) {
    if (a[ri] < a[li]) {
      merged[mi++] = a[ri++];
      count += mid - li + 1;
    } else {
      merged[mi++] = a[li++];
    }
  }

  while (li <= mid) {
    merged[mi++] = a[li++];
  }

  while (ri <= end) {
    merged[mi++] = a[ri++];
  }

  for (var e in merged) {
    a[start++] = e!;
  }

  return count;
}
