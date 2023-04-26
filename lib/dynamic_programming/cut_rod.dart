int cutRod(int n, List<int> p) {
  if (n == 0) return 0;

  var q = -1;
  for (var i = 1; i <= n; i++) {
    q = max(q, p[i - 1] + cutRod(n - i, p));
    // print('q = $q');
  }

  return q;
}

int memoizedCutRod(int n, List<int> p) {
  var r = List.filled(n + 1, -1); // 0...n, n+1 cases in total.

  int _cut(int k) {
    if (r[k] >= 0) return r[k];

    var q = -1;
    if (k == 0) {
      q = 0;
    } else {
      for (var i = 1; i <= k; i++) q = max(q, p[i - 1] + _cut(k - i));
    }

    r[k] = q;
    return q;
  }

  return _cut(n);
}

int bottomUpCutRod(int n, List<int> p) {
  var r = List.filled(n + 1, 0); // 0...n, n+1 cases in total.
  for (var i = 1; i <= n; i++) {
    var q = -1;
    for (var j = 1; j <= i; j++) {
      q = max(q, p[j - 1] + r[i - j]);
    }
    r[i] = q;
  }
  return r[n];
}

Map<int, List<int>> extendedBottomUpCutRod(int n, List<int> p) {
  var r = List.filled(n + 1, 0); // 0...n, n+1 cases in total.
  var poc = List.filled(n, 0); // position of cut

  for (var i = 1; i <= n; i++) {
    var q = -1;
    for (var j = 1; j <= i; j++) {
      if (q < p[j - 1] + r[i - j]) {
        q = p[j - 1] + r[i - j];
        poc[i - 1] = j; // best cut location so far for length i
      }
    }
    r[i] = q;
  }

  var s = <int>[];
  for (var l = n; l > 0; l -= poc[l - 1]) s.add(poc[l - 1]);

  return {r[n]: s};
}

int max(int a, int b) => a > b ? a : b;
