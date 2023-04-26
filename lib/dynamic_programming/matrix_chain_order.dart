// Refer & thanks to: https://liuyangjun.blog.csdn.net/article/details/94356886

final maxFiniteInt = double.maxFinite.floor();

List<List<List<int>>> matrixChainOrder(List<int> p) {
  var len = p.length, n = p.length - 1;
  var m = List.generate(len, (_) => List.filled(len, 0));
  var s = List.generate(len, (_) => List.filled(len, 0));

  for (var l = 2; l <= n; l++) {
    for (var i = 1; i <= n - l + 1; i++) {
      var j = i + l - 1;
      m[i][j] = maxFiniteInt;
      for (var k = i; k < j; k++) {
        var t = m[i][k] + m[k + 1][j] + p[i - 1] * p[k] * p[j];
        if (t < m[i][j]) {
          m[i][j] = t;
          s[i][j] = k;
        }
      }
    }
  }
  return [m, s];
}

String genDPTable(List<List<int>> m) {
  var buff = StringBuffer();
  for (var i = 1; i < m.length; i++) buff.writeln(m[i].skip(1).join('\t'));

  return buff.toString();
}

String genOptimalParens(List<List<int>> s, int i, int j, StringBuffer buff) {
  if (i == j) {
    buff.write('A$i');
  } else {
    buff.write('(');
    genOptimalParens(s, i, s[i][j], buff);
    genOptimalParens(s, s[i][j] + 1, j, buff);
    buff.write(')');
  }

  return buff.toString();
}

int recursiveMatrixChain(List<int> p) {
  var m = List.generate(p.length, (_) => List.filled(p.length, maxFiniteInt));

  int _recursive(int i, int j) {
    if (i == j) return 0;

    for (var k = i; k < j; k++) {
      var q = _recursive(i, k) + _recursive(k + 1, j) + p[i - 1] * p[k] * p[j];
      if (q < m[i][j]) m[i][j] = q;
    }

    return m[i][j];
  }

  return _recursive(1, p.length - 1);
}

int memoizedMatrixChain(List<int> p) {
  var m = List.generate(p.length, (_) => List.filled(p.length, maxFiniteInt));

  int _lookup(int i, int j) {
    if (m[i][j] < maxFiniteInt) return m[i][j];

    if (i == j) {
      m[i][j] = 0;
    } else {
      for (var k = i; k < j; k++) {
        var q = _lookup(i, k) + _lookup(k + 1, j) + p[i - 1] * p[k] * p[j];
        if (q < m[i][j]) m[i][j] = q;
      }
    }

    return m[i][j];
  }

  return _lookup(1, p.length - 1);
}
