void countSort(List<int> a) {
  var min = a[0], max = min;
  for (var i = 0; i < a.length; i++) {
    if (a[i] > max) max = a[i];
    if (a[i] < min) min = a[i];
  }

  var countArr = List.filled(max - min + 1, 0);
  for (var i = 0; i < a.length; i++) countArr[a[i] - min]++;
  countArr[0]--;
  for (var i = 1; i < countArr.length; i++) countArr[i] += countArr[i - 1];

  var sorted = List.filled(a.length, 0);
  for (var i = a.length - 1; i >= 0; i--) {
    sorted[countArr[a[i] - min]] = a[i];
    countArr[a[i] - min]--;
  }

  a.setAll(0, sorted);
}
