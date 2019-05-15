import 'package:data_struct/recursion/permute.dart';
// import 'dart:math';

void main() {
  var s = {1, 2, 3};
  permute(s, 3);
  print('---------------------\n');
  permuteAll(s.toList(), 0);
  print('---------------------\n');
  permuteAll2(s);
}
