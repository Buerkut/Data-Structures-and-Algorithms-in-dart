import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:data_struct/utils/int_apis.dart';

void main() async {
  var file = File('./res/news.txt');
  var lines =
      file.openRead().transform(utf8.decoder).transform(const LineSplitter());

  var capacity = 64, tc = 0;
  await for (var line in lines) {
    var words = line.split(' ');
    var l = [0, ...words.map((e) => e.length)], n = words.length;
    var (c, p) = compose(l, n, capacity);
    tc += c;
    neatlyPrint(words, p, n);
  }

  print('\nCubes of sum of extra space in lines: $tc');
}

(int, List<int>) compose(List<int> l, int n, int capacity) {
  var m = math.min(capacity ~/ 2, n);
  var c = List.filled(n + 1, 0), p = List.filled(n + 1, 0);
  for (var j = 1; j <= n; j++) {
    c[j] = IntAPIs.maxFinite;
    var ext = capacity;
    for (var i = j; i >= math.max(j - m, 1); i--) {
      if (ext < l[i] + (i == j ? 0 : 1)) break;
      ext -= l[i] + (i == j ? 0 : 1);
      var lc = j == n ? 0 : math.pow(ext, 3) as int;
      if (lc + c[i - 1] < c[j]) {
        c[j] = lc + c[i - 1];
        p[j] = i;
      }
    }
  }

  return (c[n], p);
}

void neatlyPrint(List<String> words, List<int> p, int j) {
  if (j == 0) return;

  neatlyPrint(words, p, p[j] - 1);
  print(words.getRange(p[j] - 1, j).join(' '));
}
