// the longest common subsequence
// Refer & thanks to:
// 1: https://blog.csdn.net/qq_58668057/article/details/123774788
// 2: https://alchemist-al.com/algorithms/longest-common-subsequence

import 'dart:math' as math;

void main() {
  var a = 'CVAWNB';
  var b = 'FAEUMNBP';

  print(a);
  print(b);

  var rst = dpLcs(a, b);
  print('dpLcs lcs: ${rst.keys.first}');
  print('dpLcs lcs index: ${rst.values.first}');

  var len = dpLcsLen(a, b);
  print('dpLcsLen: \t\t\t$len');
  len = recursiveLcsLen(a, b);
  print('recursiveLcsLen: \t\t$len');
  len = recursiveLcsLenInReverse(a, b);
  print('recursiveLcsLenInReverse: \t$len');
  len = memoizedLcsLen(a, b);
  print('memoizedLcsLen: \t\t$len');
  len = memoizedLcsLenInReverse(a, b);
  print('memoizedLcsLenInReverse: \t$len');

  var lcs = dpLcsStrInBook(a, b);
  print('dpLcsStrInBook: \t\t$lcs');
  lcs = dpLcsStrConcise(a, b);
  print('dpLcsStrConcise: \t\t$lcs');
  lcs = dpLcsStrInline(a, b);
  print('dpLcsStrInline: \t\t$lcs');
  lcs = dpLcsStr(a, b);
  print('dpLcsStr: \t\t\t$lcs');
  lcs = recursiveLcsStr(a, b);
  print('recursiveLcsStr: \t\t$lcs');
  lcs = recursiveLcsStrInReverse(a, b);
  print('recursiveLcsStrInReverse: \t$lcs');
  lcs = memoizedLcsStr(a, b);
  print('memoizedLcsStr: \t\t$lcs');
  lcs = memoizedLcsStrInReverse(a, b);
  print('memoizedLcsStrInReverse: \t$lcs');

  var ll = locate(lcs, a, b);
  print(ll);
}

Map<String, List<List<int>>> dpLcs(String a, String b) {
  var c = List.generate(a.length + 1, (_) => List.filled(b.length + 1, 0));
  var r = List.generate(a.length + 1, (_) => List.filled(b.length + 1, ''));

  for (var i = 1; i <= a.length; i++) {
    for (var j = 1; j <= b.length; j++) {
      if (a[i - 1] == b[j - 1]) {
        c[i][j] = c[i - 1][j - 1] + 1;
        r[i][j] = 'leftUp';
      } else if (c[i][j - 1] >= c[i - 1][j]) {
        c[i][j] = c[i][j - 1];
        r[i][j] = 'left';
      } else {
        c[i][j] = c[i - 1][j];
        r[i][j] = 'up';
      }
    }
  }

  var i = a.length, j = b.length, k = c[i][j];
  var lcs = List.filled(k, ''), ps = List.filled(k, <int>[]);
  while (k > 0) {
    if (r[i][j] == 'leftUp') {
      lcs[k - 1] = a[i - 1];
      ps[k - 1] = [i - 1, j - 1];
      i--;
      j--;
      k--;
    } else if (r[i][j] == 'left') {
      j--;
    } else {
      i--;
    }
  }

  return {lcs.join(): ps};
}

String dpLcsStrInBook(String a, String b) {
  var c = List.generate(a.length + 1, (_) => List.filled(b.length + 1, 0));
  var r = List.generate(a.length + 1, (_) => List.filled(b.length + 1, ''));

  for (var i = 1; i <= a.length; i++) {
    for (var j = 1; j <= b.length; j++) {
      if (a[i - 1] == b[j - 1]) {
        c[i][j] = c[i - 1][j - 1] + 1;
        r[i][j] = 'leftUp';
      } else if (c[i][j - 1] >= c[i - 1][j]) {
        c[i][j] = c[i][j - 1];
        r[i][j] = 'left';
      } else {
        c[i][j] = c[i - 1][j];
        r[i][j] = 'up';
      }
    }
  }

  String _genLcs(int i, int j) {
    if (i == 0 || j == 0) return '';

    if (r[i][j] == 'leftUp') {
      return '${_genLcs(i - 1, j - 1)}${a[i - 1]}';
    } else if (r[i][j] == 'up') {
      return _genLcs(i - 1, j);
    } else {
      return _genLcs(i, j - 1);
    }
  }

  return _genLcs(a.length, b.length);
}

String dpLcsStrConcise(String a, String b) {
  var c = List.generate(a.length + 1, (_) => List.filled(b.length + 1, 0));

  for (var i = 1; i <= a.length; i++) {
    for (var j = 1; j <= b.length; j++) {
      if (a[i - 1] == b[j - 1]) {
        c[i][j] = c[i - 1][j - 1] + 1;
      } else {
        c[i][j] = math.max(c[i][j - 1], c[i - 1][j]);
      }
    }
  }

  var i = a.length, j = b.length, lcs = '';
  while (i > 0 && j > 0) {
    if (c[i][j] == c[i - 1][j]) {
      i--;
    } else if (c[i][j] == c[i][j - 1]) {
      j--;
    } else {
      lcs = '${a[i - 1]}$lcs';
      i--;
      j--;
    }
  }

  return lcs;
}

String dpLcsStrInline(String a, String b) {
  var c = List.generate(a.length + 1, (_) => List.filled(b.length + 1, 0));

  for (var i = 1; i <= a.length; i++) {
    for (var j = 1; j <= b.length; j++) {
      if (a[i - 1] == b[j - 1]) {
        c[i][j] = c[i - 1][j - 1] + 1;
      } else {
        c[i][j] = math.max(c[i][j - 1], c[i - 1][j]);
      }
    }
  }

  String _genLcs(int i, int j) {
    if (i == 0 || j == 0) return '';

    if (c[i][j] == c[i - 1][j]) {
      return _genLcs(i - 1, j);
    } else if (c[i][j] == c[i][j - 1]) {
      return _genLcs(i, j - 1);
    } else {
      return '${_genLcs(i - 1, j - 1)}${a[i - 1]}';
    }
  }

  return _genLcs(a.length, b.length);
}

int dpLcsLen(String a, String b) {
  var c = List.generate(a.length + 1, (_) => List.filled(b.length + 1, 0));

  for (var i = 1; i <= a.length; i++) {
    for (var j = 1; j <= b.length; j++) {
      if (a[i - 1] == b[j - 1]) {
        c[i][j] = c[i - 1][j - 1] + 1;
      } else {
        c[i][j] = math.max(c[i][j - 1], c[i - 1][j]);
      }
    }
  }

  return c[a.length][b.length];
}

String dpLcsStr(String a, String b) {
  var c = List.generate(a.length + 1, (_) => List.filled(b.length + 1, ''));

  for (var i = 1; i <= a.length; i++) {
    for (var j = 1; j <= b.length; j++) {
      if (a[i - 1] == b[j - 1]) {
        c[i][j] = '${c[i - 1][j - 1]}${a[i - 1]}';
      } else {
        c[i][j] = c[i][j - 1].length >= c[i - 1][j].length
            ? c[i][j - 1]
            : c[i - 1][j];
      }
    }
  }

  return c[a.length][b.length];
}

int recursiveLcsLen(String a, String b) {
  int _rlcs(int i, int j) {
    if (i == a.length || j == b.length) return 0;

    if (a[i] == b[j]) {
      return _rlcs(i + 1, j + 1) + 1;
    } else {
      return math.max(_rlcs(i + 1, j), _rlcs(i, j + 1));
    }
  }

  return _rlcs(0, 0);
}

int recursiveLcsLenInReverse(String a, String b) {
  int _rlcs(int i, int j) {
    if (i < 0 || j < 0) return 0;

    if (a[i] == b[j]) {
      return _rlcs(i - 1, j - 1) + 1;
    } else {
      return math.max(_rlcs(i - 1, j), _rlcs(i, j - 1));
    }
  }

  return _rlcs(a.length - 1, b.length - 1);
}

int memoizedLcsLen(String a, String b) {
  var c = List.generate(a.length, (_) => List.filled(b.length, -1));

  int _mlcs(int i, int j) {
    if (i == a.length || j == b.length) return 0;

    if (c[i][j] >= 0) return c[i][j];

    if (a[i] == b[j]) {
      c[i][j] = _mlcs(i + 1, j + 1) + 1;
    } else {
      c[i][j] = math.max(_mlcs(i + 1, j), _mlcs(i, j + 1));
    }

    return c[i][j];
  }

  return _mlcs(0, 0);
}

int memoizedLcsLenInReverse(String a, String b) {
  var c = List.generate(a.length, (_) => List.filled(b.length, -1));

  int _mlcs(int i, int j) {
    if (i < 0 || j < 0) return 0;

    if (c[i][j] >= 0) return c[i][j];

    if (a[i] == b[j]) {
      c[i][j] = _mlcs(i - 1, j - 1) + 1;
    } else {
      c[i][j] = math.max(_mlcs(i - 1, j), _mlcs(i, j - 1));
    }

    return c[i][j];
  }

  return _mlcs(a.length - 1, b.length - 1);
}

String recursiveLcsStr(String a, String b) {
  String _rlcs(int i, int j) {
    if (i == a.length || j == b.length) return '';

    if (a[i] == b[j]) {
      return '${a[i]}${_rlcs(i + 1, j + 1)}';
    } else {
      var s1 = _rlcs(i + 1, j);
      var s2 = _rlcs(i, j + 1);
      return s1.length >= s2.length ? s1 : s2;
    }
  }

  return _rlcs(0, 0);
}

String recursiveLcsStrInReverse(String a, String b) {
  String _rlcs(int i, int j) {
    if (i < 0 || j < 0) return '';

    if (a[i] == b[j]) {
      return '${_rlcs(i - 1, j - 1)}${a[i]}';
    } else {
      var s1 = _rlcs(i - 1, j);
      var s2 = _rlcs(i, j - 1);
      return s1.length >= s2.length ? s1 : s2;
    }
  }

  return _rlcs(a.length - 1, b.length - 1);
}

String memoizedLcsStr(String a, String b) {
  var c = List.generate(a.length, (_) => List.filled(b.length, ''));

  String _mlcs(int i, int j) {
    if (i == a.length || j == b.length) return '';

    if (c[i][j].isNotEmpty) return c[i][j];

    if (a[i] == b[j]) {
      c[i][j] = '${a[i]}${_mlcs(i + 1, j + 1)}';
    } else {
      var s1 = _mlcs(i + 1, j);
      var s2 = _mlcs(i, j + 1);

      c[i][j] = s1.length >= s2.length ? s1 : s2;
    }

    return c[i][j];
  }

  return _mlcs(0, 0);
}

String memoizedLcsStrInReverse(String a, String b) {
  var c = List.generate(a.length, (_) => List.filled(b.length, ''));

  String _mlcs(int i, int j) {
    if (i < 0 || j < 0) return '';

    if (c[i][j].isNotEmpty) return c[i][j];

    if (a[i] == b[j]) {
      c[i][j] = '${_mlcs(i - 1, j - 1)}${a[i]}';
    } else {
      var s1 = _mlcs(i - 1, j);
      var s2 = _mlcs(i, j - 1);

      c[i][j] = s1.length >= s2.length ? s1 : s2;
    }

    return c[i][j];
  }

  return _mlcs(a.length - 1, b.length - 1);
}

List<List<int>?> locate(String lcs, String a, String b) {
  var ll = List<List<int>?>.filled(lcs.length, null);
  for (var c = 0, i = 0, j = 0; c < lcs.length; c++) {
    while (i < a.length && a[i] != lcs[c]) i++;
    while (j < b.length && b[j] != lcs[c]) j++;
    ll[c] = [i++, j++];
  }
  return ll;
}
