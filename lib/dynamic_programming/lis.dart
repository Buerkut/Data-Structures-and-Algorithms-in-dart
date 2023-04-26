// the longest increasing subsequence

void main() {
  var a = [8, 1, 2, 3, 4, 6, 4, 8, 0, 10, 3, 2];
  // var a = [9, 6, 8, 2];
  // var a = [1, 2, 3, 4];
  // var a = <int>[3];
  print(lis(a));
  print(lis2(a));
  print(lis5(a));
  print(lis9(a));
}

// consecutive in greedy algorithm. O(n).
// [start, end]: start: inclusive, end: exclusive.
List<int> lis(List<int> a) {
  if (a.isEmpty) return [-1, 0];

  var p = 0, ml = 1;
  for (var i = 1; i < a.length; i++) {
    var l = 1;
    for (; i < a.length && a[i] > a[i - 1]; i++) l++;
    if (l > ml) {
      ml = l;
      p = i - l;
    }
  }

  return [p, p + ml];
}

// consecutive, O(n)
List<int> lis2(List<int> a) {
  if (a.isEmpty) return [-1, 0];

  var q = 0, ml = 1, ll = List.filled(a.length, 1);
  for (var i = 1; i < a.length; i++) {
    if (a[i] > a[i - 1]) {
      ll[i] = ll[i - 1] + 1;
      if (ml < ll[i]) {
        ml = ll[i];
        q = i;
      }
    }
  }

  return [q - ml + 1, q + 1];
}

// consecutive, O(n*n)
List<int> lis5(List<int> a) {
  if (a.isEmpty) return [-1, 0];

  var p = 0, ml = 1;
  for (var i = 0; i < a.length; i++) {
    var j = i + 1;
    while (j < a.length && a[j] > a[j - 1]) j++;
    if (j - i > ml) {
      ml = j - i;
      p = i;
    }
  }

  return [p, p + ml];
}

// inconsecutive, O(n*n)
// in inconsecutive increasing subsequence, the start and end position will be
// nonsense. so it returns the subsequence itself.
List<int> lis9(List<int> a) {
  var ml = 0, lis = <int>[];
  for (var i = 0; i < a.length; i++) {
    var t = a[i], l = 1, clis = [t];
    for (var j = i + 1; j < a.length; j++) {
      if (a[j] > t) {
        t = a[j];
        clis.add(t);
        l++;
      }
    }

    if (l > ml) {
      ml = l;
      lis = clis;
    }
  }

  return lis;
}
