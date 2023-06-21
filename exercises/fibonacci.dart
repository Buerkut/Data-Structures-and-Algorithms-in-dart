import 'package:data_struct/dynamic_programming/fibonacci.dart';

void main() {
  var n = 40;
  print('n : $n');

  var r = optimizedBottomUpFibonacci(n);
  print('n4 in fib-seq : $r');

  r = bottomUpFibonacci(n);
  print('n3 in fib-seq : $r');

  r = memoizedFibonacci(n);
  print('n2 in fib-seq : $r');

  r = fibonacci(n);
  print('n1 in fib-seq : $r');
}
