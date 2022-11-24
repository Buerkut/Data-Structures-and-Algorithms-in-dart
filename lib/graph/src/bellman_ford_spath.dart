import 'directed_edge.dart';
import 'edge_weighted_digraph.dart';

class BellmanFordSP {
  EdgeWeightedDigraph graph;
  List<DirectedEdge?> edgeTo;
  List<double> distTo;
  late final bool hasNegativeCycle;

  BellmanFordSP(this.graph, int s)
      : edgeTo = List.filled(graph.nVerts, null),
        distTo = List.filled(graph.nVerts, double.infinity) {
    distTo[s] = 0;
    for (var i = 1; i < graph.nVerts; i++) {
      for (var e in graph.edges) {
        _relax(e.from);
      }
    }

    for (var e in graph.edges) {
      if (distTo[e.to] > distTo[e.from] + e.weight) {
        hasNegativeCycle = true;
      }
    }

    hasNegativeCycle = false;
  }

  bool hasPathTo(int v) => distTo[v] < double.infinity;

  Iterable<DirectedEdge?> pathTo(int v) sync* {
    if (!hasPathTo(v)) yield null;

    for (var e = edgeTo[v]; e != null; e = edgeTo[e.from]) yield e;
  }

  void _relax(int v) {
    for (var e in graph.adj(v)) {
      var w = e.to;
      if (distTo[v] + e.weight < distTo[w]) {
        distTo[w] = distTo[v] + e.weight;
        edgeTo[w] = e;
      }
    }
  }
}
