void main() {
  final n = 11;
  final s = [0, 1, 3, 0, 5, 3, 5, 6, 8, 8, 2, 12];
  final f = [0, 4, 5, 6, 7, 9, 9, 10, 11, 12, 14, 16];

  print(recursiveSelectActivity(s, f, 0, n));
  print(recursiveClosureSelectActivity(s, f, n));
  print(greedySelectActivity(s, f));
}

List<int> recursiveSelectActivity(List<int> s, List<int> f, int k, int n) {
  var m = k + 1;
  while (m <= n && s[m] < f[k]) m++;

  return switch (m > n) {
    true => [],
    _ => [m, ...recursiveSelectActivity(s, f, m, n)]
  };
}

List<int> recursiveClosureSelectActivity(List<int> s, List<int> f, int n) {
  List<int> _f(int i) {
    var j = i + 1;
    while (j <= n && s[j] < f[i]) j++;
    return j > n ? [] : [j, ..._f(j)];
  }

  return _f(0);
}

List<int> greedySelectActivity(List<int> s, List<int> f) {
  var k = 1, rst = [1];
  for (var m = 2; m < s.length; m++) {
    if (s[m] >= f[k]) {
      rst.add(m);
      k = m;
    }
  }
  return rst;
}
