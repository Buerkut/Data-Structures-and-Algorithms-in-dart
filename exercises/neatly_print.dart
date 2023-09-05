// Reference: https://blog.csdn.net/yangtzhou/article/details/83451027

import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:data_struct/utils/int_apis.dart';

void main() async {
  // var words = <String>[], capacity = 80;
  // var lines = <String>[];
  var file = File('./res/news.txt');

  // var content = file.openRead().transform(utf8.decoder);
  // await for (var str in content) words = str.split(' ');

  // var content =
  //     file.openRead().transform(utf8.decoder).transform(const LineSplitter());
  // await for (var line in content) {
  //   words.addAll(line.split(' '));
  // }

  var content =
      file.openRead().transform(utf8.decoder).transform(const LineSplitter());
  var capacity = 64, tc = 0;
  await for (var line in content) {
    // lines.add(line);
    // Avoid too large files. So deal with each line separately.
    if (line.isEmpty) continue;
    var words = line.split(' ');
    var l = [0, ...words.map((e) => e.length)], n = words.length;
    var (c, p) = compose(l, n, capacity);
    tc += c;
    // neatlyPrint(words, p, n);
    var ncps = neatlyComposing(words, p, n);
    print(ncps); // or can write to a file using FileMode.append mode.
  }

  // for (var line in lines) {
  //   var words = line.split(' ');
  //   var l = [0, ...words.map((e) => e.length)], n = words.length;
  //   var (c, p) = compose(l, n, capacity);
  //   tc += c;
  //   neatlyPrint(words, p, n);
  // }

  // var l = [0, ...words.map((e) => e.length)], n = words.length;
  // var (c, p) = compose(l, n, capacity);

  print('Cubes of sum of extra space in lines: $tc');
  // neatlyPrint(words, p, n);
}

(int, List<int>) compose(List<int> l, int n, int M) {
  var extras = List.generate(n + 1, (_) => List.filled(n + 1, 0));
  var lc = List.generate(n + 1, (_) => List.filled(n + 1, 0));
  var c = List.filled(n + 1, 0);
  var p = List.filled(n + 1, 0);

  var pairs = List.filled(n + 1, (0, 0));

  for (var i = 1; i <= n; i++) {
    extras[i][i] = M - l[i];
    var j = i + 1;
    while (j <= n && extras[i][j - 1] >= l[j] + 1) {
      extras[i][j] = extras[i][j - 1] - l[j] - 1;
      j++;
    }
    extras[i].fillRange(j, n + 1, -1);
    pairs[i] = (i, j);
    // i = j > n ? j : j - 2;
  }

  // 一个从extras寻找有效的ij对的问题
  // 此循环可以省去的
  for (var i = 1; i <= n; i++) {
    for (var j = i; j <= n; j++) {
      if (extras[i][j] < 0) {
        lc[i].fillRange(j, n + 1, IntAPIs.maxFinite);
        break;
      } else if (j == n) {
        lc[i][j] = 0;
      } else {
        lc[i][j] = math.pow(extras[i][j], 3) as int;
      }
    }
  }

  for (var j = 1; j <= n; j++) {
    c[j] = IntAPIs.maxFinite;
    for (var i = 1; i <= j; i++) {
      if (lc[i][j] != IntAPIs.maxFinite && lc[i][j] + c[i - 1] < c[j]) {
        c[j] = lc[i][j] + c[i - 1];
        p[j] = i;
      }
    }
  }

  return (c[n], p);
}

void neatlyPrint(List<String> words, List<int> p, int j) {
  if (j == 0) return;

  neatlyPrint(words, p, p[j] - 1);
  // 'getRange' doesn't generate sublist.
  print(words.getRange(p[j] - 1, j).join(' '));
}

String neatlyComposing(List<String> words, List<int> p, int j) {
  if (j == 0) return '';

  var s = neatlyComposing(words, p, p[j] - 1);
  return "$s${words.getRange(p[j] - 1, j).join(' ')}\n";
}

// switch expression
// 尝试看看递归能否实现
