import 'vertex.dart';

class DirectedGraph {
  final List<Vertex?> _vertices;
  final List<List<int>> _adjMatrix;
  int _nVerts;

  DirectedGraph(int capacity)
      : _vertices = List.filled(capacity, null),
        _adjMatrix = List.generate(capacity, (_) => List.filled(capacity, 0)),
        _nVerts = 0;

  int get nVerts => _nVerts;

  List<List<int>> get adjMatrix => _adjMatrix.toList(growable: false);

  void addVertex(Vertex v) => _vertices[_nVerts++] = v;

  void addEdge(int from, int to) {
    _adjMatrix[from][to] = 1;
  }

  Iterable<Vertex> topoSort() {
    var sorted = <Vertex>[];
    while (sorted.length < _nVerts) {
      int vi = _hasNonSuccessors();
      if (vi == -1) throw StateError('Error: Graph has cycles.');
      _vertices[vi]!.wasVisited = true;
      sorted.add(_vertices[vi]!);
    }

    _reset();

    return sorted.reversed;
  }

  // Warshall
  List<List<int>> connectByWarshall() {
    var connected = <List<int>>[];
    for (var row in adjMatrix) connected.add(row.toList(growable: false));

    for (var i = 0; i < _nVerts; i++) {
      for (var j = 0; j < _nVerts; j++) {
        if (connected[i][j] == 1) {
          for (var k = 0; k < _nVerts; k++) {
            if (connected[k][i] == 1) connected[k][j] = 1;
          }
        }
      }
    }

    return connected;
  }

  int _hasNonSuccessors() {
    bool hasSuccessor;
    for (var i = 0; i < _nVerts; i++) {
      if (_vertices[i]!.wasVisited) continue;

      hasSuccessor = false;
      for (var j = 0; j < _nVerts; j++) {
        if (_adjMatrix[i][j] > 0 && !_vertices[j]!.wasVisited) {
          hasSuccessor = true;
          break;
        }
      }
      if (!hasSuccessor) return i;
    }
    return -1;
  }

  void _reset() {
    for (var i = 0; i < _nVerts; i++) _vertices[i]!.wasVisited = false;
  }
}
