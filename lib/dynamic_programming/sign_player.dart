// Reference: https://blog.csdn.net/yangtzhou/article/details/84455392
import 'dart:math';

void main() {
  const N = 10, P = 10, X = 120;
  final r = Random();
  final S = List.generate(
      N,
      (_) =>
          List.generate(P, (_) => Player(10 + r.nextInt(20), r.nextInt(20))));

  final (tv, c, sr) = signPlayer(X, N, P, S);

  print('Total vorp: $tv\n');
  for (var i = 0; i < N; i++) {
    print(switch (sr[i]) {
      -1 => "---- Don't sign player at ${i + 1}. ----",
      _ => "Sign at ${i + 1}\t with\t${sr[i] + 1}:\t${S[i][sr[i]]}"
    });
  }
  print('\nBudget: $X, \tTotal cost: $c');
}

(int, int, List<int>) signPlayer(int X, int N, int P, List<List<Player>> S) {
  // Initialize a 2D list 'v' with dimensions (N+1) x (X+1) filled with zeros
  // 'v' will be used to store the maximum value of the player at each cost
  var v = List.generate(N + 1, (_) => List.filled(X + 1, 0)),
      // Initialize a 2D list 'p' with dimensions N x (X+1) filled with -1
      // 'p' will be used to store the index of the player that provides the maximum value at each cost
      p = List.generate(N, (_) => List.filled(X + 1, -1));

  for (var i = 1; i <= N; i++) {
    for (var x = 0; x <= X; x++) {
      // Initialize the value of the current player and cost to the value of the previous player and cost
      v[i][x] = v[i - 1][x];
      for (var j = 0; j < P; j++)
        // Check if the cost of the current player is less than or equal to the current cost
        if (S[i - 1][j].cost <= x) {
          // Calculate the total value of the current player and the value of the previous player and cost minus the cost of the current player
          var t = S[i - 1][j].vorp + v[i - 1][x - S[i - 1][j].cost];
          if (t > v[i][x]) {
            v[i][x] = t;
            p[i - 1][x] = j;
          }
        }
    }
  }

  // sr[i]: signed result for the i position.
  var c = 0, sr = List.filled(N, -1);
  void _f(int i, int x) {
    if (i < 0) return;
    if (p[i][x] == -1) {
      _f(i - 1, x);
    } else {
      c += S[i][p[i][x]].cost;
      sr[i] = p[i][x];
      _f(i - 1, x - S[i][p[i][x]].cost);
    }
  }

  _f(N - 1, X);

  return (v[N][X], c, sr);
}

final class Player {
  int cost;
  int vorp;

  Player(this.cost, this.vorp);

  @override
  String toString() => 'Person($cost, $vorp)';
}
