import 'directed_edge.dart';

class EdgeWeightedDigraph {
  final int vCount;
  int _edgeCount = 0;
  List<List<DirectedEdge>> _adj;

  EdgeWeightedDigraph(this.vCount) : _adj = List.generate(vCount, (_) => []);

  int get edgeCount => _edgeCount;

  void addEdge(DirectedEdge e) {
    var v = e.from;
    _adj[v].add(e);
    _edgeCount++;
  }

  List<DirectedEdge> adj(int v) => _adj[v];

  Iterable<DirectedEdge> get edges sync* {
    for (var v = 0; v < vCount; v++) for (var e in _adj[v]) yield e;
  }
}
