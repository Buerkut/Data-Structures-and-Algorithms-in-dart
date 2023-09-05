// Refercence: https://blog.csdn.net/yangtzhou/article/details/84312643

// import 'dart:math';
import 'dart:io';

typedef dbMatrix = List<List<double>>;

void main() {
  var m = 4, n = 4; // rd = Random();
  // var d = List.generate(m, (_) => List.generate(n, (_) => rd.nextDouble()));
  var d = [
    [0.2244, 0.5132, 0.4105, 0.7736],
    [0.0347, 0.6325, 0.7230, 0.0058],
    [0.7681, 0.9241, 0.3047, 0.1195],
    [0.6956, 0.1266, 0.0449, 0.2965]
  ];
  // print(d.join('\n'));

  var (msd, s) = seam(d, m, n);
  print(msd.toStringAsFixed(4));
  print(s);
}

(double, List<int>) seam(dbMatrix d, int m, int n) {
  // 用sd[i, j]表示以[i,j]结尾的接缝的破坏度
  // assume sd[i][j] < 1.0
  var sd = List.generate(m, (_) => List.filled(n + 2, 1.0))
    ..[0].setRange(1, n + 1, d[0]);
  // sc[i,j]表示第i − 1 行选择的是哪个点
  var sc = List.generate(m, (_) => List.filled(n, 0));

  for (var i = 1; i < m; i++) {
    for (var j = 1; j <= n; j++) {
      var k = _trimini(sd[i - 1][j - 1], sd[i - 1][j], sd[i - 1][j + 1]);
      sd[i][j] = sd[i - 1][j + k] + d[i][j - 1];
      sc[i][j - 1] = k;
    }
  }

  // print(sd.join('\n'));
  for (var i = 0; i < m; i++) {
    for (var j = 1; j <= n; j++) {
      stdout.write('${sd[i][j].toStringAsFixed(4)}, ');
    }
    stdout.writeln();
  }
  stdout.writeln();

  var msd = sd[m - 1][1], msj = 0;
  for (var j = 2; j <= n; j++) {
    if (sd[m - 1][j] < msd) {
      msd = sd[m - 1][j];
      msj = j - 1;
    }
  }

  var s = List.filled(m, 0);
  for (var i = m - 1; i >= 0; i--) {
    // print((i, msj));
    s[i] = msj;
    msj += sc[i][msj];
  }

  return (msd, s);
}

// get the minimum index, if a is minimu, return -1, or b return 0, c return 1.
int _trimini(num a, num b, num c) {
  return switch ((a < b, b < c, a < c)) {
    (true, _, true) => -1,
    (false, true, _) => 0,
    _ => 1
  };
}
