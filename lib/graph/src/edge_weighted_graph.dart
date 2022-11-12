import 'package:data_struct/queue/queue.dart';
import 'package:data_struct/union_find/union_find.dart';
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

  Iterable<Edge> get edges {
    var es = <Edge>[];
    for (int v = 0; v < vCount; v++) {
      for (var e in _adj[v])
        // 无向图避免重复添加边
        if (v < e.other(v)) es.add(e);
    }
    return es;
  }

  Iterable<Edge> primMst() {
    var edgeTo = List<Edge?>.filled(vCount, null);
    var distTo = List.filled(vCount, double.infinity);
    var marked = List.filled(vCount, false);
    var pq = IndexMinPriorityQueue<num>(vCount);

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

    while (!pq.isEmpty) visit(pq.delMin());

    return edgeTo.whereType<Edge>();
  }

  Iterable<Edge> kruskalMst() {
    var pq = PriorityQueue(edges);
    var uf = UnionFindTree(vCount);
    var mst = <Edge>[];

    while (!pq.isEmpty && mst.length < vCount - 1) {
      var e = pq.popTop();
      var v = e.either();
      var w = e.other(v);

      if (uf.connected(v, w)) continue;

      uf.union(v, w);
      mst.add(e);
    }

    return mst;
  }
}
