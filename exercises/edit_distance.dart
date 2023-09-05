// Reference:
// https://github.com/walkccc/CLRS/blob/main/docs/Chap15/Problems/15-5.md
// https://blog.csdn.net/yangtzhou/article/details/83451229

import 'dart:math' as math;
import 'package:data_struct/utils/int_apis.dart';

// EDIT(x, y, i, j)
//     let m = x.length
//     let n = y.length
//     if i == m
//         return (n - j)cost(insert)
//     if j == n
//         return min{(m - i)cost(delete), cost(kill)}
//     initialize o1, ..., o5 to ∞
//     if x[i] == y[j]
//         o1 = cost(copy) + EDIT(x, y, i + 1, j + 1)
//     o2 = cost(replace) + EDIT(x, y, i + 1, j + 1)
//     o3 = cost(delete) + EDIT(x, y, i + 1, j)
//     o4 = cost(insert) + EDIT(x, y, i, j + 1)
//     if i < m - 1 and j < n - 1
//         if x[i] == y[j + 1] and x[i + 1] == y[j]
//             o5 = cost(twiddle) + EDIT(x, y, i + 2, j + 2)
//     return min_{i ∈ [5]}{o_i}

void main() {
  // copy, replace, delete, insert, twiddle, kill;
  const c = [1, 1, 4, 4, 2, 99];
  var x = 'algorithm', y = 'altruistic';
  var d = edit(x, y, c);
  print(d);
  d = memoizedEdit(x, y, c);
  print(d);
}

int edit(String x, String y, List<int> c) {
  var m = x.length, n = y.length;

  int _f(int i, int j) {
    if (i == m) return (n - j) * c[3];
    if (j == n) return math.min((m - i) * c[2], c[5]);

    // copy, replace, delete, insert, twiddle;
    var op = List.filled(5, IntAPIs.maxFinite);
    if (x[i] == y[j]) op[0] = c[0] + _f(i + 1, j + 1);
    op[1] = c[1] + _f(i + 1, j + 1);
    op[2] = c[2] + _f(i + 1, j);
    op[3] = c[3] + _f(i, j + 1);
    if ((i < m - 1 && j < n - 1) && (x[i] == y[j + 1] && x[i + 1] == y[j])) {
      op[4] = c[4] + _f(i + 2, j + 2);
    }

    var d = IntAPIs.maxFinite;
    for (var t in op) if (t < d) d = t;

    return d;
  }

  return _f(0, 0);
}

int memoizedEdit(String x, String y, List<int> c) {
  var m = x.length, n = y.length;
  var d = List.generate(m, (_) => List.filled(n, IntAPIs.maxFinite));

  int _f(int i, int j) {
    if (i == m) return (n - j) * c[3];
    if (j == n) return math.min((m - i) * c[2], c[5]);
    if (d[i][j] < IntAPIs.maxFinite) return d[i][j];

    // copy, replace, delete, insert, twiddle;
    var op = List.filled(5, IntAPIs.maxFinite);
    if (x[i] == y[j]) op[0] = c[0] + _f(i + 1, j + 1);
    op[1] = c[1] + _f(i + 1, j + 1);
    op[2] = c[2] + _f(i + 1, j);
    op[3] = c[3] + _f(i, j + 1);
    if ((i < m - 1 && j < n - 1) && (x[i] == y[j + 1] && x[i + 1] == y[j])) {
      op[4] = c[4] + _f(i + 2, j + 2);
    }

    for (var t in op) if (t < d[i][j]) d[i][j] = t;

    return d[i][j];
  }

  return _f(0, 0);
}
