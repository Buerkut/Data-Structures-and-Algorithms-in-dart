// Refer to: https://blog.csdn.net/qq_44502283/article/details/105346274

import 'dart:convert';
import 'dart:io';

void main() async {
  var vn = 6, adj = List.generate(vn, (_) => List.filled(vn, 0.0));
  var file = File('./res/g2.txt');
  var lines =
      file.openRead().transform(utf8.decoder).transform(const LineSplitter());
  await for (var line in lines) {
    var [a, b, w] = line.split(' ');
    adj[int.parse(a)][int.parse(b)] = double.parse(w);
  }

  var graph = DAG(vn, adj);
  var from = 2, to = 5;
  print(graph.topoSort());
  print(graph.findLongestPath(from, to));
  print(graph.findLongestPath2(from, to));
  print(graph.findLongestPathInGraph());
}

class DAG {
  int vtxNum;
  List<List<double>> adj;
  DAG(this.vtxNum, this.adj);

  List<int> _countIndegree() {
    var indgr = List.filled(vtxNum, 0);

    for (var r in adj) {
      for (var j = 0; j < vtxNum; j++) if (r[j] > 0) indgr[j]++;
    }

    return indgr;
  }

  List<int> topoSort() {
    var indgr = _countIndegree(), s = List.filled(vtxNum, 0);
    var c = 0, i = indgr.indexWhere((x) => x == 0);

    while (i != -1) {
      s[c++] = i;
      for (var j = 0; j < vtxNum; j++) if (adj[i][j] > 0) indgr[j] -= 1;
      indgr[i] = -1;
      i = indgr.indexWhere((x) => x == 0);
    }

    return s;
  }

  double findLongestPath(int from, int to) {
    var lp = [for (var e in adj) e.toList()], tp = topoSort();
    var s = tp.indexWhere((x) => x == from), t = tp.indexWhere((x) => x == to);

    for (var l = 1; l <= t - s; l++) {
      for (var i = s; i < t - l + 1; i++) {
        var j = i + l;
        for (var k = i + 1; k <= j; k++) {
          if (lp[tp[i]][tp[k]] + lp[tp[k]][tp[j]] > lp[tp[i]][tp[j]])
            lp[tp[i]][tp[j]] = lp[tp[i]][tp[k]] + lp[tp[k]][tp[j]];
        }
      }
    }

    return lp[from][to];
  }

  double findLongestPath2(int from, int to) {
    var s = 0, t = 0, c = 0, tp = topoSort();
    for (var i = 0; i < tp.length && c < 2; i++) {
      if (tp[i] == from) {
        s = i;
        c++;
      }
      if (tp[i] == to) {
        t = i;
        c++;
      }
    }
    var lp = List.filled(t - s + 1, 0.0);

    for (var j = s + 1; j <= t; j++) {
      var mp = 0.0;
      for (var i = s; i < j; i++) {
        if (adj[tp[i]][tp[j]] > 0 && lp[i - s] + adj[tp[i]][tp[j]] > mp)
          mp = lp[i - s] + adj[tp[i]][tp[j]];
      }
      lp[j - s] = mp;
    }

    return lp[t - s];
  }

  // Find the longest path in graph.
  // Note: the longest path is maybe not from tp[0] to tp[vertNum-1].
  double findLongestPathInGraph() {
    var lp = List.filled(vtxNum, 0.0), tp = topoSort();

    // calculate all the longest path from tp[0] to all the other vertex.
    for (var j = 1; j < vtxNum; j++) {
      var mp = 0.0;
      for (var i = 0; i < j; i++) {
        if (adj[tp[i]][tp[j]] > 0 && lp[i] + adj[tp[i]][tp[j]] > mp)
          mp = lp[i] + adj[tp[i]][tp[j]];
      }
      lp[j] = mp;
    }

    // find the longest path in graph.
    var mp = lp[0];
    for (var t in lp) if (t > mp) mp = t;

    return mp;
  }
}
