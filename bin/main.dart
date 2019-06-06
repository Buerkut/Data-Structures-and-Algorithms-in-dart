import 'dart:math';
import 'package:data_struct/hash_table/hash_table.dart';

void main() {
  var rd = Random(),
      a = List.generate(30, (_) => rd.nextInt(1000)),
      b = List.generate(30, (i) => a[i] << 1);
  var table = HashTable.fromIterables(a, b);
  print(table.length);
  print(table);

  for (var i = 0; i < a.length; i++) table.remove(a[i]);
  print(table.length);
  print(table);

  for (var i = 0; i < a.length; i++) {
    table[a[i]] = b[i];
  }
  print(table.length);
  print(table);
  print(table[1]);
  print(table[a[1]]);
}
