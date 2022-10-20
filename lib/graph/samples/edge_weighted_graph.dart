import 'package:data_struct/graph/graph.dart';

void main() {
  var g = EdgeWeightedGraph(5);
  var e1 = Edge(0, 1, 1);
  var e2 = Edge(1, 2, 2);
  var e3 = Edge(4, 3, 3);
  g.addEdge(e1);
  g.addEdge(e2);
  g.addEdge(e3);
  print(g.edges);
}
