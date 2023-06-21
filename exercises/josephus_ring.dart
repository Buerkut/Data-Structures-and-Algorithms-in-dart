void main() {
  var n = 10, m = 3;
  var outcome = josephusRing1(n, m);
  print(outcome);

  var last = josephusRing2(n, m);
  print(last);

  outcome = josephusRing3(n, m);
  print(outcome);
}

List<int> josephusRing1(int n, int m) {
  var outcome = List.filled(n, 0);
  var arr = List.filled(n, true);
  var left = n, c = 0, i = 0;
  while (left > 0) {
    if (arr[i]) {
      if (++c == m) {
        c = 0;
        arr[i] = false;
        outcome[n - left] = i;
        left--;
      }
    }
    if (++i == n) i = 0;
  }

  return outcome;
}

int josephusRing2(int n, int m) {
  if (n == 1) return 0;
  return (m + josephusRing2(n - 1, m)) % n;
}

List<int> josephusRing3(int n, int m) {
  var outcome = List.filled(n, 0);
  for (var i = 1; i <= n; i++) outcome[i - 1] = _josephusRing3(n, m, i);
  return outcome;
}

int _josephusRing3(int n, int m, int i) {
  if (i == 1) return (m - 1) % n;
  return (m + _josephusRing3(n - 1, m, i - 1)) % n;
}
