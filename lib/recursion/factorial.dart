int factorial(int n) {
  if (n < 0) throw StateError('n cannot be < 0!');
  return n == 0 ? 1 : n * factorial(n - 1);
}

int factorialNonrecursive(int n) {
  if (n < 0) throw StateError('n cannot be < 0!');
  var result = 1;
  while (n > 0) result *= n--;
  return result;
}
