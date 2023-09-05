// Reference: https://blog.csdn.net/yangtzhou/article/details/84405508

void main() {
  // mons must be equal to d.length.
  var mons = 6, d = [8, 14, 9, 13, 6, 15];
  var qpm = 10, pc = 3;

  var (total, p) = inventoryPlan(mons, qpm, pc, d);
  var plan = getPlan(mons, total, p);
  print(total);
  print(plan);
}

(int, List<List<int>>) inventoryPlan(int mons, int qpm, int pc, List<int> d) {
  // accumulative demand per month.
  var acd = List.filled(mons, 0)..[0] = d[0];
  for (var i = 1; i < mons; i++) acd[i] = acd[i - 1] + d[i];

  var total = acd[mons - 1],
      cost = List.generate(mons, (_) => List.filled(total + 1, 0.0)),
      p = List.generate(mons, (_) => List.filled(total + 1, 0));

  for (var i = 0; i < mons; i++) {
    for (var j = acd[i]; j <= total; j++)
      if (i == 0) {
        cost[i][j] = _hc(j - acd[i]) + (j > qpm ? (j - qpm) * pc : 0);
        p[i][j] = j;
      } else {
        cost[i][j] = double.maxFinite;
        for (var k = 0; k <= j - acd[i - 1]; k++) {
          var t = cost[i - 1][j - k] + _hc(j - acd[i]);
          if (k > qpm) t += (k - qpm) * pc;
          if (t < cost[i][j]) {
            cost[i][j] = t;
            p[i][j] = k;
          }
        }
      }
  }

  return (total, p);
}

List<int> getPlan(int mons, int total, List<List<int>> p) {
  var plan = List.filled(p.length, 0);

  void _f(int i, int j) {
    if (i < 0) return;
    _f(i - 1, j - p[i][j]);
    plan[i] = p[i][j];
  }

  _f(mons - 1, total);

  return plan;
}

// holding cost
double _hc(int t) {
  return 2.5 * t;
}
