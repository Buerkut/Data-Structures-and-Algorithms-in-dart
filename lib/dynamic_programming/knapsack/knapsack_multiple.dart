// Reference:
// https://blog.csdn.net/weixin_72060925/article/details/128404378
// https://blog.csdn.net/qq_73176808/article/details/131928256

import 'dart:math';

void main() {
  // N: the number of goods, TV: total volume of the knapsack.
  const N = 10, TV = 100;
  // v: volume, w: wealth, q: quantity of each goods.
  final v = [0, 18, 11, 13, 14, 17, 18, 15, 16, 12, 15],
      w = [0, 14, 18, 13, 12, 15, 14, 17, 16, 11, 24],
      q = [0, 3, 1, 2, 7, 4, 9, 5, 3, 6, 2];

  var maxw = fill(N, TV, v, w, q);
  print(maxw);
  print('');
  maxw = fill2(N, TV, v, w, q);
  print(maxw);
}

int fill(int N, int TV, List<int> v, List<int> w, List<int> q) {
  var dp = List.generate(N + 1, (_) => List.filled(TV + 1, 0));

  for (var i = 1; i <= N; i++) {
    for (var j = 0; j <= TV; j++)
      for (var k = 0; k <= q[i] && v[i] * k <= j; k++)
        dp[i][j] = max(dp[i][j], dp[i - 1][j - v[i] * k] + w[i] * k);
  }

  return dp[N][TV];
}

// 通过二进制优化来优化性能
int fill2(int N, int TV, List<int> v, List<int> w, List<int> q) {
  // 通过二进制优化，将多重背包转化为0-1背包问题
  var bv = [0], bw = [0];
  for (var i = 1; i <= N; i++) {
    var c = q[i];
    for (var k = 1; k <= c; k << 1) {
      bv.add(v[i] * k);
      bw.add(w[i] * k);
      c -= k;
    }
    if (c > 0) {
      bv.add(v[i] * c);
      bw.add(w[i] * c);
    }
  }

  // 空间优化版本的0-1背包解决方案
  var dp = List.filled(TV + 1, 0);
  for (var i = 1; i < bv.length; i++) {
    for (var j = TV; j >= bv[i]; j--) dp[j] = max(dp[j], dp[j - bv[i]] + bw[i]);
  }

  return dp[TV];
}
