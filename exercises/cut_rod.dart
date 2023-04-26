import 'package:data_struct/dynamic_programming/cut_rod.dart';

void main() {
  var n = 16;
  var p = [1, 5, 8, 9, 10, 17, 18, 20, 24, 30, 32, 36, 38, 40, 42, 45];
  // print(p.length);
  var maxr = cutRod(n, p);
  print('max1 revenue : $maxr');
  maxr = memoizedCutRod(n, p);
  print('max2 revenue : $maxr');
  maxr = bottomUpCutRod(n, p);
  print('max3 revenue : $maxr');
  var output = extendedBottomUpCutRod(n, p);
  print('max4 revenue : ${output.keys.first}');
  print('cut solution : ${output.values.first}');
}
