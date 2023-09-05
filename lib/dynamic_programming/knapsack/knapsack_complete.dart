// Reference:
// https://blog.csdn.net/qq_73176808/article/details/131928256

import 'dart:math';

void main() {
  // N: the number of goods, TV: total volume of the knapsack.
  const N = 10, TV = 100;
  // v: volume, w: wealth
  final v = [0, 18, 11, 13, 14, 17, 18, 15, 16, 12, 15],
      w = [0, 14, 18, 13, 12, 15, 14, 17, 16, 11, 24];

  var maxw = fill(N, TV, v, w);
  print(maxw);

  maxw = fill2(N, TV, v, w);
  print(maxw);

  maxw = fill3(N, TV, v, w);
  print(maxw);
}

int fill(int N, int TV, List<int> v, List<int> w) {
  var dp = List.generate(N + 1, (_) => List.filled(TV + 1, 0));

  for (var i = 1; i <= N; i++) {
    for (var j = 0; j <= TV; j++)
      for (var k = 0; v[i] * k <= j; k++)
        dp[i][j] = max(dp[i][j], dp[i - 1][j - v[i] * k] + w[i] * k);
  }

  return dp[N][TV];
}

// 循环优化
int fill2(int N, int TV, List<int> v, List<int> w) {
  var dp = List.generate(N + 1, (_) => List.filled(TV + 1, 0));

  for (var i = 1; i <= N; i++) {
    for (int j = 0; j <= TV; j++) {
      dp[i][j] = dp[i - 1][j];
      if (j >= v[i]) dp[i][j] = max(dp[i][j], dp[i][j - v[i]] + w[i]);
    }
  }

  return dp[N][TV];
}

// 空间优化
int fill3(int N, int TV, List<int> v, List<int> w) {
  var dp = List.filled(TV + 1, 0);

  for (var i = 1; i <= N; i++) {
    for (int j = v[i]; j <= TV; j++) dp[j] = max(dp[j], dp[j - v[i]] + w[i]);
  }

  return dp[TV];
}
