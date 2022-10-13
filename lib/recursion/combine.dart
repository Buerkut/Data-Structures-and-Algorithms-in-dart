void combine<E>(Set<E> s, int m) {
  if (m > 0 && m <= s.length) _fill(List<E?>.filled(m, null), s, 0, m);
}

void combineAll<E>(Set<E> s) {
  for (var i = 1; i <= s.length; i++) combine(s, i);
}

void _fill<E>(List<E> cm, Set<E> s, int i, int m) {
  if (m < s.length) {
    cm[i] = s.first;
    if (m > 1) {
      _fill(cm, _rest(s, s.first), i + 1, m - 1);
    } else {
      print(cm);
    }
    _fill(cm, _rest(s, s.first), i, m);
  } else {
    for (var e in s) cm[i++] = e;
    print(cm);
  }
}

Set _rest<E>(Set<E> s, E e) {
  var t = s.toSet();
  t.remove(e);
  return t;
}
