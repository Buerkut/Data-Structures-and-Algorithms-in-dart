void shellSort<E extends Comparable<E>>(List<E> a) {
  for (var i = _initInterval(a); i > 0; i = (i - 1) ~/ 3) {
    for (var g = 0; g < i; g++) {
      for (var j = i + g; j < a.length; j += i) {
        var k = j - i, t = a[j];
        while (k >= 0 && t.compareTo(a[k]) < 0) {
          a[k + i] = a[k];
          k -= i;
        }
        if (k < j - i) a[k + i] = t;
      }
    }
  }
}

int _initInterval<E>(List<E> a) {
  var interval = 1;
  while (interval < a.length ~/ 3) interval = interval * 3 + 1;
  return interval;
}
