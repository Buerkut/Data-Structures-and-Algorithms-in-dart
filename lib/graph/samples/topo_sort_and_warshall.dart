import 'package:data_struct/graph/graph.dart';

void main() {
  var graph = DirectedGraph(8);
  graph.addVertex(Vertex('A'));
  graph.addVertex(Vertex('B'));
  graph.addVertex(Vertex('C'));
  graph.addVertex(Vertex('D'));
  graph.addVertex(Vertex('E'));
  graph.addVertex(Vertex('F'));
  graph.addVertex(Vertex('G'));
  graph.addVertex(Vertex('H'));
  graph.addEdge(0, 3);
  graph.addEdge(0, 4);
  graph.addEdge(1, 4);
  graph.addEdge(2, 5);
  graph.addEdge(3, 6);
  graph.addEdge(4, 6);
  graph.addEdge(5, 7);
  graph.addEdge(6, 7);
  print(graph.topoSort().join(' '));

  var adjM = graph.adjMatrix;
  var connectM = graph.connectByWarshall();

  print('-------------------');
  for (var row in adjM) print(row.join(' '));
  print('-------------------');
  for (var row in connectM) print(row.join(' '));
}
