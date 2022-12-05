import 'package:data_struct/graph/graph.dart';

void main() {
  var g = EdgeWeightedDigraph(5);
  var e1 = DirectedEdge(0, 1, 6);
  var e2 = DirectedEdge(0, 2, 7);
  var e3 = DirectedEdge(1, 2, 8);
  var e4 = DirectedEdge(1, 3, 5);
  var e5 = DirectedEdge(1, 4, -4);
  var e6 = DirectedEdge(2, 3, -3);
  var e7 = DirectedEdge(2, 4, 9);
  var e8 = DirectedEdge(3, 1, -2);
  var e9 = DirectedEdge(4, 0, 2);
  var e10 = DirectedEdge(4, 3, 7);

  // negative cycle test
  // var e11 = DirectedEdge(0, 3, 2);

  g.addEdge(e1);
  g.addEdge(e2);
  g.addEdge(e3);
  g.addEdge(e4);
  g.addEdge(e5);
  g.addEdge(e6);
  g.addEdge(e7);
  g.addEdge(e8);
  g.addEdge(e9);
  g.addEdge(e10);

  // negative cycle test
  // g.addEdge(e11);

  var src = 0, dest = 4;

  // if the graph has negative cycle, Dijkstra algorithm doesn't work.
  var dsp = DijkstraSP(g, src);
  print('');
  print('src = $src, dest = $dest\n');
  print(dsp.distTo[dest]);
  for (var e in dsp.pathTo(dest)) print(e);

  print('\n-----------------------\n');

  var bfsp = BellmanFordSP(g, src);
  print('has negative cycle: ${bfsp.hasNegativeCycle}\n');
  print('src = $src, dest = $dest\n');
  print(bfsp.distTo[dest]);
  for (var e in bfsp.pathTo(dest)) print(e);
  print('');
}
