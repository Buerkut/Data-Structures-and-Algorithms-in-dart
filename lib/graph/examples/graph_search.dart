import 'dart:io';
import 'dart:math';
import 'package:data_struct/graph/src/vertex.dart';
import 'package:data_struct/graph/src/graph.dart';

void main() {
  var labels = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'];
  var vertices = <Vertex>[], g = Graph(10);

  for (var label in labels) vertices.add(Vertex(label));
  for (var v in vertices) g.addVertex(v);

  var rd = Random();
  for (var i = 0; i < 10; i++) {
    var start = rd.nextInt(g.nVerts), end = rd.nextInt(g.nVerts);
    if (start != end) {
      print('${vertices[start].label} ${vertices[end].label}');
      g.addEdge(start, end);
    }
  }

  print('---------------------------------');
  print('Visits by dfs: ');
  g.dfs((v) => stdout.write('${v.label} '));
  print('\n---------------------------------');
  print('Visits by bfs: ');
  g.bfs((v) => stdout.write('${v.label} '));

  // var mstTree = g.mst();
  print('\n---------------------------------');
  g.displayMstTree();
}
