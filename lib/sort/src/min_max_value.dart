List<int> getMinMaxInt(List<int> a) {
  var min = a[0], max = a[0];
  for (var i = a.length % 2 == 0 ? 0 : 1; i < a.length; i += 2) {
    if (a[i] < a[i + 1]) {
      if (a[i] < min) min = a[i];
      if (max < a[i + 1]) max = a[i + 1];
    } else {
      if (a[i + 1] < min) min = a[i + 1];
      if (max < a[i]) max = a[i];
    }
  }

  return [min, max];
}

List<E> getMinMax<E extends Comparable<E>>(List<E> a) {
  var min = a[0], max = a[0];
  for (var i = a.length % 2 == 0 ? 0 : 1; i < a.length; i += 2) {
    if (a[i].compareTo(a[i + 1]) < 0) {
      if (a[i].compareTo(min) < 0) min = a[i];
      if (max.compareTo(a[i + 1]) < 0) max = a[i + 1];
    } else {
      if (a[i + 1].compareTo(min) < 0) min = a[i + 1];
      if (max.compareTo(a[i]) < 0) max = a[i];
    }
  }

  return [min, max];
}
