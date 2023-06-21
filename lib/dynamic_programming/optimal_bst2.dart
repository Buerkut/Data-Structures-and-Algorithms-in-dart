// this file was written by ChatGPT.

class Node {
  String key;
  int frequency;
  Node? left;
  Node? right;

  Node(this.key, this.frequency);
}

double optimalBST(List<String> keys, List<double> frequencies) {
  int n = keys.length;

  // Create a 2D table to store optimal cost values
  List<List<double>> costTable =
      List.generate(n + 1, (_) => List<double>.filled(n + 1, 0));

  // Initialize costTable with frequencies
  for (int i = 0; i < n; i++) {
    costTable[i][i] = frequencies[i];
  }

  // Fill in the costTable using the optimal BST algorithm
  for (int len = 2; len <= n; len++) {
    for (int i = 0; i <= n - len; i++) {
      // Fix: Change n - len + 1 to n - len
      int j = i + len - 1;
      costTable[i][j] = double.infinity;
      double sum = getSum(frequencies, i, j);

      for (int k = i; k <= j; k++) {
        double cost = sum +
            (k > i ? costTable[i][k - 1] : 0) +
            (k < j ? costTable[k + 1][j] : 0);

        if (cost < costTable[i][j]) {
          costTable[i][j] = cost;
        }
      }
    }
  }

  // Return the optimal cost of the root node
  return costTable[0][n - 1];
}

double getSum(List<double> frequencies, int i, int j) {
  double sum = 0;
  for (int k = i; k <= j; k++) {
    sum += frequencies[k];
  }
  return sum;
}

void main() {
  List<String> keys = ['A', 'B', 'C', 'D', 'E'];
  List<double> frequencies = [3, 2, 4, 1, 5];

  double optimalCost = optimalBST(keys, frequencies);
  print('Optimal cost of the BST: $optimalCost');
}
