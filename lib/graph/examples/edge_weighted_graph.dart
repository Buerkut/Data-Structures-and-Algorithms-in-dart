import 'package:data_struct/graph/graph.dart';

void main() {
  var g = new EdgeWeightedGraph(8);
  var e1 = Edge(4, 5, 0.35),
      e2 = Edge(4, 7, 0.37),
      e3 = Edge(5, 7, 0.28),
      e4 = Edge(0, 7, 0.16),
      e5 = Edge(1, 5, 0.32),
      e6 = Edge(0, 4, 0.38),
      e7 = Edge(2, 3, 0.17),
      e8 = Edge(1, 7, 0.19),
      e9 = Edge(0, 2, 0.26),
      e10 = Edge(1, 2, 0.36),
      e11 = Edge(1, 3, 0.29),
      e12 = Edge(2, 7, 0.34),
      e13 = Edge(6, 2, 0.40),
      e14 = Edge(3, 6, 0.52),
      e15 = Edge(6, 0, 0.58),
      e16 = Edge(6, 4, 0.93);

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
  g.addEdge(e16);

  for (var e in g.primMst()) print(e);

  print('-----------------------------------------');

  for (var e in g.kruskalMst()) print(e);
}
