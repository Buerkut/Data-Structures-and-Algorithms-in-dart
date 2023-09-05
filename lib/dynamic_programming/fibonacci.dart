int fib(int n) {
  if (n <= 2) return 1;
  return fib(n - 1) + fib(n - 2);
}

int memoizedFib(int n) {
  if (n <= 2) return 1;

  var r = List.filled(n + 1, 0);
  r.fillRange(1, 3, 1);

  int _calc(int k) {
    if (r[k] > 0) return r[k];
    r[k] = _calc(k - 1) + _calc(k - 2);
    return r[k];
  }

  return _calc(n);
}

int bottomUpFib(int n) {
  if (n <= 2) return 1;

  var fib = List.filled(n + 1, 0);
  fib.fillRange(1, 3, 1);
  for (var i = 3; i <= n; i++) fib[i] = fib[i - 1] + fib[i - 2];

  return fib[n];
}

int optimizedBottomUpFib(int n) {
  if (n < 2) return n;

  var p = 0, r = 1;
  for (var i = 2; i <= n; i++) {
    r += p;
    p = r - p;
  }

  return r;
}
