import 'dart:math' as math;

void main() {
  const a = [
    [7],
    [3, 8],
    [8, 1, 0],
    [2, 7, 4, 4],
    [4, 5, 2, 6, 5]
  ];
  var r = maxSum(a);
  print('recursive: bottom to up: \t\t$r');
  r = maxSum2(a);
  print('recursive: up to bottom: \t\t$r');
  r = maxSum3(a);
  print('recursive: memoized and up to bottom: \t$r');
  r = maxSumDP(a);
  print('dynamic programming: \t\t\t$r');
  r = maxSumDP2(a);
  print('dynamic programming sp opt: \t\t$r');
}

// recursive: bottom to up
int maxSum(List<List<int>> a) {
  int _ms(int i, int j) {
    if (i == 0 && j == 0) {
      return a[i][j];
    } else if (j == 0) {
      return a[i][j] + _ms(i - 1, j);
    } else if (i == j) {
      return a[i][j] + _ms(i - 1, j - 1);
    } else {
      return a[i][j] + math.max(_ms(i - 1, j - 1), _ms(i - 1, j));
    }
  }

  var m = 0, n = a.length - 1, c = a.last.length;
  for (var k = 0; k < c; k++) {
    var t = _ms(n, k);
    if (m < t) m = t;
  }
  return m;
}

// recursive: up to bottom
int maxSum2(List<List<int>> a) {
  int _ms(int i, int j) {
    if (i == a.length - 1) return a[i][j];
    return a[i][j] + math.max(_ms(i + 1, j), _ms(i + 1, j + 1));
  }

  return _ms(0, 0);
}

// recursive: memoized and up to bottom
int maxSum3(List<List<int>> a) {
  var m = List.generate(a.length, (_) => List.filled(a.length, -1));

  int _ms(int i, int j) {
    if (m[i][j] != -1) return m[i][j];

    if (i == a.length - 1) {
      m[i][j] = a[i][j];
    } else {
      m[i][j] = a[i][j] + math.max(_ms(i + 1, j), _ms(i + 1, j + 1));
    }

    return m[i][j];
  }

  return _ms(0, 0);
}

// dynamic programming
int maxSumDP(List<List<int>> a) {
  var m = List.generate(a.length + 1, (_) => List.filled(a.length + 1, 0));

  for (var i = a.length - 1; i >= 0; i--) {
    for (var j = 0; j <= i; j++)
      m[i][j] = a[i][j] + math.max(m[i + 1][j], m[i + 1][j + 1]);
  }

  return m[0][0];
}

// dynamic programming and spatial optimization
int maxSumDP2(List<List<int>> a) {
  var m = List.filled(a.length + 1, 0);
  for (var i = a.length - 1; i >= 0; i--) {
    for (var j = 0; j <= i; j++) m[j] = a[i][j] + math.max(m[j], m[j + 1]);
  }
  return m[0];
}
