void permute<E>(Set<E> s, int m) {
  if (m < 0 || m > s.length) throw StateError('m is not in [0, ${s.length}]');

  _fill(<E>[], s, m);
  print('-------------------');
  _fillFixed(List<E?>.filled(m, null), s, 0, m);
}

void permuteAll(List a, int k) {
  if (k < a.length - 1) {
    for (int i = k; i < a.length; i++) {
      if (i != k) _swap(a, k, i);
      permuteAll(a, k + 1);
      if (i != k) _swap(a, k, i);
    }
  } else {
    print(a);
  }
}

void permuteAll2<E>(Set<E> s) => permute(s, s.length);

void _fill<E>(List<E> pm, Set<E> s, int m) {
  if (pm.length < m) {
    for (var e in s) {
      pm.add(e);
      _fill(pm, _rest(s, e), m);
    }
  } else {
    print(pm);
  }
  if (pm.isNotEmpty) pm.removeLast();
}

void _fillFixed<E>(List<E> pm, Set<E> s, int i, int m) {
  if (i < m) {
    for (var e in s) {
      pm[i] = e;
      _fillFixed(pm, _rest(s, e), i + 1, m);
    }
  } else {
    print(pm);
  }
}

Set _rest<E>(Set<E> s, E e) {
  var t = s.toSet();
  t.remove(e);
  return t;
}

void _swap(List a, int i, int j) {
  var t = a[i];
  a[i] = a[j];
  a[j] = t;
}
