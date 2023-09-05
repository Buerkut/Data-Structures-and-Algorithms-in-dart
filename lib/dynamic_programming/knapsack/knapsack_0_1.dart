// Reference:
// https://blog.csdn.net/qq_73176808/article/details/131928256

import 'dart:math';

void main() {
  // N: the number of goods, TV: total volume of the knapsack.
  const N = 10, TV = 100;
  final v = [0, 18, 11, 13, 14, 17, 18, 15, 16, 12, 15],
      w = [0, 14, 18, 13, 12, 15, 14, 17, 16, 11, 24];

  var maxw = fill(N, TV, v, w);
  print(maxw);

  maxw = fill2(N, TV, v, w);
  print(maxw);
}

int fill(int N, int TV, List<int> v, List<int> w) {
  var dp = List.generate(N + 1, (_) => List.filled(TV + 1, 0));

  for (var i = 1; i <= N; i++) {
    for (var j = 0; j <= TV; j++)
      dp[i][j] = switch (j >= v[i]) {
        false => dp[i - 1][j],
        true => max(dp[i - 1][j], dp[i - 1][j - v[i]] + w[i])
      };
  }

  return dp[N][TV];
}

int fill2(int N, int TV, List<int> v, List<int> w) {
  var dp = List.filled(TV + 1, 0);

  for (var i = 1; i <= N; i++) {
    for (var j = TV; j >= v[i]; j--) dp[j] = max(dp[j], dp[j - v[i]] + w[i]);
  }

  return dp[TV];
}
