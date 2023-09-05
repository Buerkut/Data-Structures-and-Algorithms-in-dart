import 'dart:math';

void main() {
  var kinds = 4, years = 5, capital = 10000, f1 = 1000, f2 = 1300;
  var r = <List<double>>[
    [0, 0, 0, 0, 0, 0],
    [0, 1.1517, 1.1360, 1.2187, 1.1289, 1.1458],
    [0, 1.1314, 1.0450, 1.1805, 1.1398, 1.1340],
    [0, 1.1609, 1.0235, 1.2591, 1.0688, 1.1298],
    [0, 1.1857, 1.0155, 1.2102, 1.0789, 1.1609]
  ];

  // r.skip(1).forEach((e) => print(e.skip(1).map((e) => e.toStringAsFixed(4))));
  var (p, ens) = findInvestStrategy(capital, kinds, years, r, f1, f2);
  print(p.skip(1));
  print(ens.skip(1).map((e) => e.toStringAsFixed(2)));
}

(List<int>, List<double>) findInvestStrategy(
    int capital, int kinds, int years, List<List<double>> r, int f1, int f2) {
  var p = List.filled(years + 1, 0), ens = List.filled(years + 1, 0.0);

  for (var j = 1; j <= years; j++) {
    var q = 1;
    // 遍历每一个类别，寻找收益率最大的那个投资种类
    for (var i = 2; i <= kinds; i++) if (r[i][j] > r[q][j]) q = i;
    p[j] = q;

    // ens[j]表示当前年份的收益率，先假设不切换投资种类时，j年的收益是多少；
    ens[j] = switch (j) {
      1 => capital * r[q][j],
      _ => (ens[j - 1] - f1) * r[p[j - 1]][j]
    };

    if (j > 1 && q != p[j - 1]) {
      var t = (ens[j - 1] - f2) * r[q][j];
      if (t > ens[j]) {
        ens[j] = t;
      } else {
        p[j] = p[j - 1];
      }
    }
  }

  return (p, ens);
}

void genRTable(int kinds, int years) {
  var r = List.generate(kinds + 1, (_) => List.filled(years + 1, '0'));
  var rd = Random();
  for (var i = 1; i <= kinds; i++) {
    for (var j = 1; j <= years; j++) {
      r[i][j] = (1 + rd.nextDouble()).toStringAsFixed(4);
    }
  }
  print(r.join('\n'));
}
