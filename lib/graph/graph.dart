import 'package:data_struct/stack/stack.dart';
import 'package:data_struct/queue/queue.dart' show Queue;
import './vertex.dart';

class Graph {
  final List<Vertex?> _vertices;
  final List<List<int>> _adjMatrix;
  int _nVerts;

  Graph(int capacity)
      : _vertices = List.filled(capacity, null),
        _adjMatrix = List.generate(capacity, (_) => List.filled(capacity, 0)),
        _nVerts = 0;

  int get nVerts => _nVerts;

  void addVertex(Vertex v) => _vertices[_nVerts++] = v;

  void addEdge(int start, int end) {
    _adjMatrix[start][end] = 1;
    _adjMatrix[end][start] = 1;
  }

  void dfs(void f(Vertex? v)) {
    var vxs = Stack<Vertex>();
    for (var i = 0; i < nVerts; i++) {
      if (!_vertices[i]!.wasVisited) {
        _vertices[i]!.wasVisited = true;
        f(_vertices[i]);
        vxs.push(_vertices[i]!);

        while (vxs.isNotEmpty) {
          var nbs = _getUnvisited(_vertices.indexOf(vxs.top));
          var j = nbs.isNotEmpty ? nbs.first : -1;
          if (j == -1) {
            vxs.pop();
          } else {
            _vertices[j]!.wasVisited = true;
            f(_vertices[j]);
            vxs.push(_vertices[j]!);
          }
        }
      }
    }

    _reset();
  }

  void bfs(void f(Vertex v)) {
    var vxq = Queue<Vertex>();
    for (var i = 0; i < nVerts; i++) {
      if (!_vertices[i]!.wasVisited) {
        _vertices[i]!.wasVisited = true;
        f(_vertices[i]!);
        vxq.push(_vertices[i]!);

        while (vxq.isNotEmpty)
          for (var j in _getUnvisited(_vertices.indexOf(vxq.pull()))) {
            _vertices[j]!.wasVisited = true;
            f(_vertices[j]!);
            vxq.push(_vertices[j]!);
          }
      }
    }

    _reset();
  }

  Iterable<int> _getUnvisited(int i) sync* {
    for (var j = 0; j < _nVerts; j++)
      if (_adjMatrix[i][j] == 1 && !_vertices[j]!.wasVisited) yield j;
  }

  void _reset() {
    for (var i = 0; i < _nVerts; i++) _vertices[i]!.wasVisited = false;
  }
}
