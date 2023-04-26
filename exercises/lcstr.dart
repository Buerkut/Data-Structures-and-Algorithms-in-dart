// the longest common substring.

void main() {
  // var a = 'abcdugernm';
  var a = 'muiabcys';
  var b = 'dabcers';
  // var b = '';
  var s = lcstr10(a, b);
  print(a);
  print(b);
  print(s);
  var len = lcstrLen(a, b);
  print(len);
  s = lcstr(a, b);
  print(s);

  var m = lcstrLenAndPosition(a, b);
  len = m.keys.first;
  var p = m[len];
  print('$len: $p');
  print(a.substring(p![0], p[0] + len));
}

int lcstrLen(String a, String b) {
  var ml = 0;
  for (var i = 0; i < a.length; i++) {
    var j = 0, l = 0;
    while (j < b.length && b[j] != a[i]) j++;
    if (j < b.length) {
      for (; i < a.length && j < b.length && a[i] == b[j]; i++, j++) l++;
      if (l > ml) ml = l;
    }
  }
  return ml;
}

String lcstr(String a, String b) {
  var p = -1, ml = 0;

  for (var i = 0; i < a.length; i++) {
    var j = 0, l = 0;
    while (j < b.length && b[j] != a[i]) j++;
    if (j < b.length) {
      for (; i < a.length && j < b.length && a[i] == b[j]; i++, j++) l++;
      if (l > ml) {
        ml = l;
        p = i - l;
      }
    }
  }

  return p >= 0 ? a.substring(p, p + ml) : '';
}

Map<int, List<int>> lcstrLenAndPosition(String a, String b) {
  var pa = -1, pb = -1, ml = 0;

  for (var i = 0; i < a.length; i++) {
    var j = 0, l = 0;
    while (j < b.length && b[j] != a[i]) j++;
    if (j < b.length) {
      for (; i < a.length && j < b.length && a[i] == b[j]; i++, j++) l++;
      if (l > ml) {
        ml = l;
        pa = i - l;
        pb = j - l;
      }
    }
  }

  return {
    ml: [pa, pb]
  };
}

String lcstr10(String a, String b) {
  var i = 0, maxLen = 0;
  var starts = List.filled(2, -1);
  while (i < a.length) {
    var j = 0, l = 0;
    while (j < b.length && b[j] != a[i]) j++;
    if (j < b.length) {
      var s1 = i, s2 = j;
      while (i < a.length && j < b.length && a[i] == b[j]) {
        i++;
        j++;
        l++;
      }
      if (l > maxLen) {
        starts[0] = s1;
        starts[1] = s2;
        maxLen = l;
      }
    }
    i++;
  }
  print(starts);
  print(maxLen);
  if (maxLen > 0) {
    return a.substring(starts[0], starts[0] + maxLen);
  } else {
    return '';
  }
}
