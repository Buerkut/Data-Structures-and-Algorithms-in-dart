import 'package:data_struct/queue/queue.dart';
import 'package:data_struct/union_find/union_find.dart';
import './edge.dart';

class EdgeWeightedGraph {
  final int nVerts;
  int _edgeCount = 0;
  List<List<Edge>> _adj;

  EdgeWeightedGraph(this.nVerts) : _adj = List.generate(nVerts, (_) => []);

  int get edgeCount => _edgeCount;

  void addEdge(Edge e) {
    var v = e.either();
    var w = e.other(v);

    _adj[v].add(e);
    _adj[w].add(e);

    _edgeCount++;
  }

  List<Edge> adj(int v) => _adj[v];

  Iterable<Edge> get edges sync* {
    for (var v = 0; v < nVerts; v++)
      for (var e in _adj[v])
        // 无向图避免重复添加边
        if (v < e.other(v)) yield e;
  }

  Iterable<Edge> primMst() {
    var edgeTo = List<Edge?>.filled(nVerts, null);
    var distTo = List.filled(nVerts, double.infinity);
    var marked = List.filled(nVerts, false);
    var pq = IndexMinPriorityQueue<num>(nVerts);

    distTo[0] = 0.0;
    pq.insert(0, 0.0);

    visit(int v) {
      marked[v] = true;
      for (var e in _adj[v]) {
        int w = e.other(v);
        if (marked[w]) continue;

        if (e.weight < distTo[w]) {
          edgeTo[w] = e;
          distTo[w] = e.weight;
          if (pq.contains(w))
            pq.changeItem(w, e.weight);
          else
            pq.insert(w, e.weight);
        }
      }
    }

    while (pq.isNotEmpty) visit(pq.delMin());

    return edgeTo.whereType<Edge>();
  }

  Iterable<Edge> kruskalMst() sync* {
    var pq = PriorityQueue(edges);
    var uf = UnionFindTree(nVerts);
    var ct = 0;

    while (!pq.isEmpty && ct < nVerts - 1) {
      var e = pq.popTop();
      var v = e.either();
      var w = e.other(v);

      if (uf.connected(v, w)) continue;

      uf.union(v, w);
      ct++;
      yield e;
    }
  }
}
