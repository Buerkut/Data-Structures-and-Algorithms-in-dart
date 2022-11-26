import 'directed_edge.dart';
import 'edge_weighted_digraph.dart';

class BellmanFordSP {
  EdgeWeightedDigraph graph;
  // late List<DirectedEdge> _edges;
  List<DirectedEdge?> edgeTo;
  List<double> distTo;
  late final bool hasNegativeCycle;

  BellmanFordSP(this.graph, int s)
      : edgeTo = List.filled(graph.nVerts, null),
        distTo = List.filled(graph.nVerts, double.infinity) {
    distTo[s] = 0;
    // _edges = _edgeFrom(s);
    for (var i = 1; i < graph.nVerts; i++) {
      // for (var e in _edges) _relax(e);
      for (var e in graph.edges) _relax(e);
    }

    hasNegativeCycle = _check();
  }

  bool hasPathTo(int v) {
    // if the graph has negative cycles, the path will be invalid
    // and the next func 'pathTo' will fall into the infinite loop.
    if (hasNegativeCycle) throw StateError('the graph has negative cycle!');

    return distTo[v] < double.infinity;
  }

  Iterable<DirectedEdge?> pathTo(int v) sync* {
    if (!hasPathTo(v)) yield null;

    for (var e = edgeTo[v]; e != null; e = edgeTo[e.from]) yield e;
  }

  // Get all edges started from the vertex 's'
  // List<DirectedEdge> _edgeFrom(int s) {
  //   var edges = <DirectedEdge>[];
  //   edges.addAll(graph.adj(s));
  //   for (var v = 0; v < s; v++) {
  //     edges.addAll(graph.adj(v));
  //   }
  //   for (var v = s + 1; v < graph.nVerts; v++) {
  //     edges.addAll(graph.adj(v));
  //   }
  //   return edges;
  // }

  void _relax(DirectedEdge e) {
    if (distTo[e.from] + e.weight < distTo[e.to]) {
      distTo[e.to] = distTo[e.from] + e.weight;
      edgeTo[e.to] = e;
    }
  }

  // check if the graph has negative cycles.
  bool _check() {
    // for (var e in _edges) {
    for (var e in graph.edges) {
      if (distTo[e.to] > distTo[e.from] + e.weight) return true;
    }
    return false;
  }
}
