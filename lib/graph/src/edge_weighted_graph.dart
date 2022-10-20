import './edge.dart';

class EdgeWeightedGraph {
  final int vCount;
  int _edgeCount = 0;
  late List<List<Edge>> _adj;

  EdgeWeightedGraph(this.vCount) {
    _adj = List.generate(vCount, (_) => []);
  }

  int get edgeCount => _edgeCount;

  void addEdge(Edge e) {
    var v = e.either();
    var w = e.other(v);

    _adj[v].add(e);
    _adj[w].add(e);

    _edgeCount++;
  }

  List<Edge> adj(int v) => _adj[v];

  List<Edge> get edges {
    var es = <Edge>[];
    for (int v = 0; v < vCount; v++) {
      for (var e in _adj[v])
        // 无向图避免重复添加边
        if (v < e.other(v)) es.add(e);
    }
    return es;
  }
}
