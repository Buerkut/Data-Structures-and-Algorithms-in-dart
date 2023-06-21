import 'dart:io';

typedef dbList = List<double>;
typedef dbMatrix = List<List<double>>;
typedef intMatrix = List<List<int>>;

(dbMatrix, intMatrix) optimalBST(dbList p, dbList q, int n) {
  var e = List.generate(n + 2, (_) => List.filled(n + 2, 0.0));
  var w = List.generate(n + 2, (_) => List.filled(n + 2, 0.0));
  var root = List.generate(n + 1, (_) => List.filled(n + 1, 0));

  for (var i = 1; i < n + 2; i++) {
    w[i][i - 1] = q[i - 1];
    e[i][i - 1] = q[i - 1];
  }

  for (var l = 1; l <= n; l++) {
    for (var i = 1; i <= n - l + 1; i++) {
      var j = i + l - 1;
      e[i][j] = double.infinity;
      w[i][j] = w[i][j - 1] + p[j] + q[j];

      for (var r = i; r <= j; r++) {
        var t = e[i][r - 1] + e[r + 1][j] + w[i][j];
        if (t < e[i][j]) {
          e[i][j] = t;
          root[i][j] = r;
        }
      }
    }
  }

  return (e, root);
}

void printOptBSTRaw(intMatrix root, int i, int j) {
  if (i > j) return;

  var rt = root[i][j];
  stdout.writeln('root is: $rt');

  if (i < j) {
    stdout.write("the left-child-tree's ");
    printOptBSTRaw(root, i, rt - 1);
    stdout.write("the right-child-tree's ");
    printOptBSTRaw(root, rt + 1, j);
  }
  stdout.writeln();
}

class Node {
  int key;
  Node? left;
  Node? right;

  Node(this.key);
}

Node? buildOptBST(intMatrix root, int i, int j) {
  if (i > j) return null;

  var rt = root[i][j];
  var rtNode = Node(rt);

  if (i < j) {
    rtNode.left = buildOptBST(root, i, rt - 1);
    rtNode.right = buildOptBST(root, rt + 1, j);
  }

  return rtNode;
}

void printOptBST(Node? rtNode) {
  if (rtNode == null) return;
  stdout.writeln('root is: ${rtNode.key}');

  if (rtNode.left != null) {
    stdout.write("the left-child-tree's ");
    printOptBST(rtNode.left);
  }

  if (rtNode.right != null) {
    stdout.write("the right-child-tree's ");
    printOptBST(rtNode.right);
  }
}
