// Actually, the go-up-stairs problem is a use of fibonacci function.

int goUpStairs(int n) {
  if (n < 2) return 1;

  var r = List.filled(n + 1, 0);
  r.fillRange(0, 2, 1);

  int _goUp(int k) {
    if (r[k] > 0) return r[k];

    r[k] = _goUp(k - 1) + _goUp(k - 2);

    return r[k];
  }

  return _goUp(n);
}
