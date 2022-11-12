import 'package:data_struct/graph/graph.dart';

void main() {
  var g = EdgeWeightedDigraph(8);
  var e1 = DirectedEdge(4, 5, 0.35);
  var e2 = DirectedEdge(4, 7, 0.37);
  var e3 = DirectedEdge(5, 7, 0.28);
  var e4 = DirectedEdge(5, 4, 0.35);
  var e5 = DirectedEdge(7, 5, 0.28);
  var e6 = DirectedEdge(5, 1, 0.32);
  var e7 = DirectedEdge(0, 4, 0.38);
  var e8 = DirectedEdge(0, 2, 0.26);
  var e9 = DirectedEdge(7, 3, 0.39);
  var e10 = DirectedEdge(1, 3, 0.29);
  var e11 = DirectedEdge(2, 7, 0.34);
  var e12 = DirectedEdge(6, 2, 0.40);
  var e13 = DirectedEdge(3, 6, 0.52);
  var e14 = DirectedEdge(6, 0, 0.58);
  var e15 = DirectedEdge(6, 4, 0.93);

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
  g.addEdge(e11);
  g.addEdge(e12);
  g.addEdge(e13);
  g.addEdge(e14);
  g.addEdge(e15);

  var dsp = new DijkstraSP(g, 0);
  var edges = dsp.pathTo(6);
  for (var edge in edges) print(edge);
}
