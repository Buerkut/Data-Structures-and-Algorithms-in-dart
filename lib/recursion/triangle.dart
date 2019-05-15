int triangle(int n) {
  if (n <= 0) throw StateError('n cannot be <= 0!');
  return n == 1 ? 1 : n + triangle(n - 1);
}

int triangleNonrecursive(int n) {
  if (n <= 0) throw StateError('n cannot be <= 0!');
  int result = 0;
  while (n > 0) result += n--;
  return result;
}
