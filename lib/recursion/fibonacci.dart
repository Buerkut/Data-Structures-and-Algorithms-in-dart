int fibonacci(int n) {
  if (n <= 0) throw StateError('n cannot be <= 0!');
  return n > 2 ? fibonacci(n - 1) + fibonacci(n - 2) : 1;
}

int fibonacciNonrecursive(int n) {
  if (n <= 0) throw StateError('n cannot be <= 0!');
  if (n < 3) return 1;
  int a = 1, b = 1;
  while (n-- > 2) {
    b += a;
    a = b - a;
  }
  return b;
}
