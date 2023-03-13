typedef Matrix = List<List<int>>;

Matrix matrixMultiply(Matrix A, Matrix B) {
  final m = A.length, p = A.first.length, bp = B.length, n = B.first.length;

  if (p != bp) {
    throw StateError('column numbers of A is not equal to row numbers of B');
  }

  Matrix C = List.generate(m, (_) => List.filled(n, 0), growable: false);

  for (var i = 0; i < m; i++) {
    for (var j = 0; j < n; j++) {
      for (var k = 0; k < p; k++) {
        C[i][j] += A[i][k] * B[k][j];
      }
    }
  }

  return C;
}
