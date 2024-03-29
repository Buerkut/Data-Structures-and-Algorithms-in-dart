import 'package:data_struct/queue/queue.dart';
import 'directed_edge.dart';
import 'edge_weighted_digraph.dart';

class DijkstraSP {
  EdgeWeightedDigraph graph;
  List<DirectedEdge?> edgeTo;
  List<double> distTo;
  IndexMinPriorityQueue<num> pq;

  DijkstraSP(this.graph, int s)
      : edgeTo = List.filled(graph.nVerts, null),
        distTo = List.filled(graph.nVerts, double.infinity),
        pq = IndexMinPriorityQueue(graph.nVerts) {
    distTo[s] = 0;
    pq.insert(s, 0);
    while (pq.isNotEmpty) _relax(pq.delMin());
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
        if (pq.contains(w))
          pq.changeItem(w, distTo[w]);
        else
          pq.insert(w, distTo[w]);
      }
    }
  }
}
