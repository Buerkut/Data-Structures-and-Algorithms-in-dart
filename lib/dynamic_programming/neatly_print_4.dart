import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:data_struct/utils/int_apis.dart';

void main() async {
  var file = File('./res/news.txt'), cap = 64;
  var lines =
      file.openRead().transform(utf8.decoder).transform(const LineSplitter());

  await for (var line in lines) {
    var words = line.split(' ');
    var p = compose(words, cap);
    neatlyPrint(words, p);
  }
}

List<int> compose(List<String> words, int cap) {
  var s = List.filled(words.length + 1, 0), p = List.filled(words.length, 0);
  for (var j = 1; j <= words.length; j++) {
    s[j] = IntAPIs.maxFinite;
    var ext = cap;
    for (var i = j; i > 0 && j - i < math.min(cap >> 1, words.length); i--) {
      ext -= words[i - 1].length + (i == j ? 0 : 1);
      if (ext < 0) break;

      var c = (j == words.length) ? 0 : math.pow(ext, 3) as int;
      if (c + s[i - 1] < s[j]) {
        s[j] = c + s[i - 1];
        p[j - 1] = i - 1;
      }
    }
  }

  return p;
}

void neatlyPrint(List<String> words, List<int> p) {
  void _f(int k) {
    if (k < 0) return;
    _f(p[k] - 1);
    print(words.getRange(p[k], k + 1).join(' '));
  }

  _f(words.length - 1);
}
