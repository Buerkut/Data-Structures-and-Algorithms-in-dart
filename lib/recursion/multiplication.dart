int commonMultiplication(int a, int b) => a * b;

int plusMultiplication(int a, int b) {
  var t = a > b ? b : a, r = 0;
  if (t == a) {
    a = b;
    b = t;
  }

  while (b-- > 0) r += a;
  return r;
}

int bitMultiplication(int a, int b, int order) {
  var t = a > b ? b : a, r = 0;
  if (t == a) {
    a = b;
    b = t;
  }

  for (var i = _bitShift(b, order); i > 0; i = _bitShift(b, order)) {
    r += a << i;
    b -= 1 << i;
  }

  return b == 1 ? r + a : r;
}

int _bitShift(int d, int order) {
  if (order == 0) return 0;
  var i = 0;
  for (var t = d; (t >>= order) > 0; d = t, t = d) i += order;
  return i + _bitShift(d, order >> 1);
}
