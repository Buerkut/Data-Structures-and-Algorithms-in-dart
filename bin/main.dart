// import 'dart:math';
import 'package:data_struct/hash_table/hash_table.dart';

void main() {
  var a = List.generate(10, (i) => '$i'), b = List.generate(10, (i) => i << 1);
  var table = HashTable(6);
  for (var i = 0; i < a.length; i++) table.insert(a[i], b[i]);
  print(table);
}
