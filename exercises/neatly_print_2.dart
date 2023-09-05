import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:data_struct/utils/int_apis.dart';

void main() async {
  var file = File('./res/news.txt');
  var lines =
      file.openRead().transform(utf8.decoder).transform(const LineSplitter());

  var capacity = 60, tc = 0;
  await for (var line in lines) {
    if (line.isEmpty) continue;
    var words = line.split(' ');
    var l = [0, ...words.map((e) => e.length)], n = words.length;
    var (c, p) = compose(l, n, capacity);
    tc += c;
    var ncps = neatlyComposing(words, p, n);
    print(ncps);
  }

  print('Cubes of sum of extra space in lines: $tc');
}

(int, List<int>) compose(List<int> l, int n, int capacity) {
  var m = math.min(capacity ~/ 2, n), mc = 0;
  var extras = List.generate(n + 1, (_) => List.filled(m, 0));

  for (var i = 1; i <= n; i++) {
    extras[i][0] = capacity - l[i];
    var j = i + 1;
    while (j - i < m && j <= n && extras[i][j - i - 1] >= l[j] + 1) {
      extras[i][j - i] = extras[i][j - i - 1] - l[j] - 1;
      j++;
    }
    if (j - i > mc) mc = j - i;
    if (j - i < m) extras[i].fillRange(j - i, m, -1);
  }

  var c = List.filled(n + 1, 0), p = List.filled(n + 1, 0);
  for (var j = 1; j <= n; j++) {
    c[j] = IntAPIs.maxFinite;
    for (var i = math.max(j - mc, 1); i <= j; i++) {
      if (extras[i][j - i] < 0) continue;
      var lc = j == n ? 0 : math.pow(extras[i][j - i], 3) as int;
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

String neatlyComposing(List<String> words, List<int> p, int j) {
  if (j == 0) return '';

  var s = neatlyComposing(words, p, p[j] - 1);
  return "$s${words.getRange(p[j] - 1, j).join(' ')}\n";
}
