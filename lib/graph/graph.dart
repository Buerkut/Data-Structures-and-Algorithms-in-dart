import 'package:data_struct/stack/stack.dart';
import 'package:data_struct/queue/queue.dart' show Queue;
import './vertex.dart';

class Graph {
  final List<Vertex> _vertices;
  final List<List<int>> _adjMatrix;
  int _nVerts;

  Graph(int capacity)
      : _vertices = List(capacity),
        _adjMatrix = List.generate(capacity, (_) => List.filled(capacity, 0)),
        _nVerts = 0;

  int get nVerts => _nVerts;

  void addVertex(Vertex v) => _vertices[_nVerts++] = v;

  void addEdge(int start, int end) {
    _adjMatrix[start][end] = 1;
    _adjMatrix[end][start] = 1;
  }

  void dfs(void f(Vertex v)) {
    var vts = Stack<Vertex>();
    for (var i = 0; i < nVerts; i++) {
      if (!_vertices[i].wasVisited) {
        _vertices[i].wasVisited = true;
        f(_vertices[i]);
        vts.push(_vertices[i]);

        while (vts.isNotEmpty) {
          var j = _getUnvisited(_vertices.indexOf(vts.top));
          if (j == -1) {
            vts.pop();
          } else {
            _vertices[j].wasVisited = true;
            f(_vertices[j]);
            vts.push(_vertices[j]);
          }
        }
      }
    }

    _reset();
  }

  void bfs(void f(Vertex v)) {
    for (var i = 0; i < nVerts; i++) {}
  }

  int _getUnvisited(int i) {
    for (var j = 0; j < _nVerts; j++)
      if (_adjMatrix[i][j] == 1 && !_vertices[j].wasVisited) return j;
    return -1;
  }

  void _reset() {
    for (var i = 0; i < _nVerts; i++) _vertices[i].wasVisited = false;
  }
}
