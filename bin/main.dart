import 'dart:math';
import 'package:data_struct/hash_table/linked_hash_table.dart';
// import 'package:data_struct/hash_table/hash_table.dart';

void main() {
  var rd = Random(),
      a = List.generate(80, (_) => rd.nextInt(200)),
      b = List.generate(80, (i) => a[i] << 1);
  // var table = LinkedHashTable();
  // for (var i = 0; i < a.length; i++) table.insert(a[i], b[i]);
  var table = LinkedHashTable.fromIterables(a, b);

  print(table.length);
  print(table);

  print('----------------------');
  for (var d in a) table.remove(d);
  print(table.length);
  print(table);
  for (var d in b) table.remove(d);
}
