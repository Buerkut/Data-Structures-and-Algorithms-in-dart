// Reference:
// https://blog.csdn.net/qq_73176808/article/details/131928256

import 'dart:math';

void main() {
  // N: the number of goods, TV: total volume of the knapsack.
  const N = 3, TV = 5;
  final v = [
        [1, 2],
        [3],
        [4]
      ],
      w = [
        [2, 4],
        [4],
        [5]
      ];

  var maxw = fill(N, TV, v, w);
  print(maxw);
}

int fill(int N, int TV, List<List<int>> v, List<List<int>> w) {
  var dp = List.filled(TV + 1, 0);

  for (var i = 0; i < N; i++) {
    for (var j = TV; j >= 1; j--)
      for (var k = 0; k < v[i].length; k++)
        if (v[i][k] <= j) dp[j] = max(dp[j], dp[j - v[i][k]] + w[i][k]);
  }

  return dp[TV];
}
