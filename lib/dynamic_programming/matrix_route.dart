void main() {
  var matrix = (3, 7);
  print(route(matrix));
  print(memoizedRoute(matrix));
  print(dpRoute(matrix));
  print(dpRouteOpt(matrix));
}

int route((int, int) matrix) {
  int _rt(int m, int n) {
    return switch ((m, n)) {
      (0, _) || (_, 0) => 1,
      _ => _rt(m - 1, n) + _rt(m, n - 1)
    };
  }

  var (m, n) = matrix;
  return _rt(m - 1, n - 1);
}

// memoized
int memoizedRoute((int, int) matrix) {
  var (m, n) = matrix;
  var r = List.generate(m, (_) => List.filled(n, -1));

  int _rt(int m, int n) {
    if (r[m][n] >= 0) return r[m][n];

    r[m][n] = switch ((m, n)) {
      (0, _) || (_, 0) => 1,
      _ => _rt(m - 1, n) + _rt(m, n - 1)
    };

    return r[m][n];
  }

  return _rt(m - 1, n - 1);
}

int dpRoute((int, int) matrix) {
  var (m, n) = matrix;
  var dp = List.generate(m + 1, (_) => List.filled(n + 1, 0))..[0][1] = 1;

  for (var i = 1; i <= m; i++) {
    for (var j = 1; j <= n; j++) dp[i][j] = dp[i - 1][j] + dp[i][j - 1];
  }

  return dp[m][n];
}

int dpRouteOpt((int, int) matrix) {
  var (m, n) = matrix;
  if (m > n) (m, n) = (n, m);

  var dp = List.filled(m, 1);
  for (var i = 1; i < n; i++) {
    for (var j = 1; j < m; j++) dp[j] += dp[j - 1];
  }

  return dp[m - 1];
}
