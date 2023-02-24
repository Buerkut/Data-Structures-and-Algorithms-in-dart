void bucketSort(List<int> a, {int bucketSize = 8}) {
  var min = a[0], max = min;
  for (var i = 0; i < a.length; i++) {
    if (a[i] > max) max = a[i];
    if (a[i] < min) min = a[i];
  }

  var bucketCount = (max - min) ~/ bucketSize + 1;
  var buckets = List.generate(bucketCount, (_) => <int>[], growable: false);

  for (var i = 0; i < a.length; i++) {
    buckets[(a[i] - min) ~/ bucketSize].add(a[i]);
  }

  for (var i = 0, c = 0; i < bucketCount; i++) {
    buckets[i].sort();

    // for (var j = 0; j < buckets[i].length; j++) a[c++] = buckets[i][j];
    a.setAll(c, buckets[i]);
    c += buckets[i].length;
  }
}
