import 'package:data_struct/dynamic_programming/optimal_bst.dart';

void main() {
  // const n = 5;
  // const p = [-1.0, 0.15, 0.1, 0.05, 0.1, 0.2];
  // const q = [0.05, 0.1, 0.05, 0.05, 0.05, 0.1];

  const n = 7;
  const p = [-1.0, 0.04, 0.06, 0.08, 0.02, 0.10, 0.12, 0.14];
  const q = [0.06, 0.06, 0.06, 0.06, 0.05, 0.05, 0.05, 0.05];

  var (e, root) = optimalBST(p, q, n);
  print('search cost: ${e[1][n]}');

  // root.skip(1).forEach((e) => print(e.skip(1).join('  ')));
  // print('');
  // printOptBSTRaw(root, 1, n);

  var rtNode = buildOptBST(root, 1, n);
  printOptBST(rtNode);
}
