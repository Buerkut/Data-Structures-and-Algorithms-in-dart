import 'package:data_struct/utils/int_apis.dart';

void main() {
  var len = 20, spl = [4, 8, 10];
  var (c, sp) = rsplit(len, spl);
  print(c);
  print(sp.join('\n'));

  var l = [0, ...spl, len];
  printSplitSeq(sp, l, 0, l.length - 1);
  var seq = getSplitSeq(sp, spl);
  print(seq);

  print('----------');
  (c, sp) = dpSplit(len, spl);
  print(c);
  print(sp.join('\n'));
  printSplitSeq(sp, l, 0, l.length - 1);
  seq = getSplitSeq(sp, spl);
  print(seq);
}

// Return the cost of splitting and the split position. Implement in recursion.
(int, List<List<int>>) rsplit(int len, List<int> spl) {
  var l = [0, ...spl, len],
      cost = List.generate(l.length, (_) => List.filled(l.length, -1)),
      sp = List.generate(l.length, (_) => List.filled(l.length, 0));

  int _f(int i, int j) {
    if (cost[i][j] >= 0) return cost[i][j];

    if (j == i + 1) {
      cost[i][j] = 0;
    } else {
      cost[i][j] = IntAPIs.maxFinite;
      for (var k = i + 1; k < j; k++) {
        var c = _f(i, k) + _f(k, j) + l[j] - l[i];
        if (c < cost[i][j]) {
          cost[i][j] = c;
          sp[i][j] = k;
        }
      }
    }

    return cost[i][j];
  }

  return (_f(0, l.length - 1), sp);
}

// Implement in dynamic programming.
(int, List<List<int>>) dpSplit(int len, List<int> spl) {
  var l = [0, ...spl, len],
      cost = List.generate(l.length, (_) => List.filled(l.length, 0)),
      sp = List.generate(l.length, (_) => List.filled(l.length, 0));

  for (var intv = 2; intv < l.length; intv++) {
    for (var i = 0; i < l.length - intv; i++) {
      var j = i + intv;
      cost[i][j] = IntAPIs.maxFinite;
      for (var k = i + 1; k < j; k++) {
        var c = cost[i][k] + cost[k][j] + l[j] - l[i];
        if (c < cost[i][j]) {
          cost[i][j] = c;
          sp[i][j] = k;
        }
      }
    }
  }

  return (cost[0][l.length - 1], sp);
}

void printSplitSeq(List<List<int>> sp, List<int> l, int i, int j) {
  if (j <= i + 1) return;

  print(l[sp[i][j]]);
  printSplitSeq(sp, l, i, sp[i][j]);
  printSplitSeq(sp, l, sp[i][j], j);
}

List<int> getSplitSeq(List<List<int>> sp, List<int> spl) {
  var seq = List.filled(spl.length, 0), k = 0;
  void _f(int i, int j) {
    if (j <= i + 1) return;

    seq[k++] = spl[sp[i][j] - 1];
    _f(i, sp[i][j]);
    _f(sp[i][j], j);
  }

  _f(0, spl.length + 1);

  return seq;
}
