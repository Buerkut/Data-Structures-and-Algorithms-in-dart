import 'directed_edge.dart';

class EdgeWeightedDigraph {
  final int nVerts;
  int _edgeCount = 0;
  List<List<DirectedEdge>> _adj;

  EdgeWeightedDigraph(this.nVerts) : _adj = List.generate(nVerts, (_) => []);

  int get edgeCount => _edgeCount;

  void addEdge(DirectedEdge e) {
    _adj[e.from].add(e);
    _edgeCount++;
  }

  List<DirectedEdge> adj(int v) => _adj[v];

  Iterable<DirectedEdge> get edges sync* {
    for (var v = 0; v < nVerts; v++) for (var e in _adj[v]) yield e;
  }
}
