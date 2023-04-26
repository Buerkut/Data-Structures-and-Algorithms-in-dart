import 'package:data_struct/dynamic_programming/matrix_chain_order.dart';

void main() {
  var p = [3, 9, 2, 3, 8, 3, 6];
  var r = matrixChainOrder(p);
  var m = r[0], s = r[1], n = p.length - 1;

  var optValue = m[1][n];
  print('the min computation is : $optValue');

  optValue = recursiveMatrixChain(p);
  print('the min computation is : $optValue');

  optValue = memoizedMatrixChain(p);
  print('the min computation is : $optValue');

  var optParens = genOptimalParens(s, 1, n, StringBuffer());
  print('the optimal parens is : $optParens');

  var dpTable = genDPTable(m);
  print('the dynamic programming table is :\n');
  print(dpTable);
}
