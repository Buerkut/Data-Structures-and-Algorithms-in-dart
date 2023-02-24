const _radix = 10;

void radixSort(List<int> a) {
  var max = a[0];
  for (var i = 0; i < a.length; i++) {
    if (a[i] > max) max = a[i];
  }

  var buckets = List.filled(_radix, 0);
  for (var d = 1; max ~/ d > 0; d *= _radix) {
    for (var i = 0; i < a.length; i++) buckets[(a[i] ~/ d) % _radix]++;
    buckets[0]--;
    for (var i = 1; i < buckets.length; i++) buckets[i] += buckets[i - 1];

    var sorted = List.filled(a.length, 0);
    for (var i = a.length - 1; i >= 0; i--) {
      var k = (a[i] ~/ d) % _radix;
      sorted[buckets[k]] = a[i];
      buckets[k]--;
    }

    a.setAll(0, sorted);
    buckets.fillRange(0, _radix, 0);
  }
}
