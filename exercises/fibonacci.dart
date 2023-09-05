import 'package:data_struct/dynamic_programming/fibonacci.dart';

void main() {
  var n = 40;
  print('n : $n');

  var r = optimizedBottomUpFib(n);
  print('n4 in fib-seq : $r');

  r = bottomUpFib(n);
  print('n3 in fib-seq : $r');

  r = memoizedFib(n);
  print('n2 in fib-seq : $r');

  r = fib(n);
  print('n1 in fib-seq : $r');
}
