import 'package:data_struct/queue/queue.dart' show IndexMinPriorityQueue;

void main() {
  var arr = ["S", "O", "R", "T", "E", "X", "A", "M", "P", "L", "E"];
  var indexMinPQ = IndexMinPriorityQueue<String>(20);
  for (var i = 0; i < arr.length; i++) indexMinPQ.insert(i, arr[i]);

  print(indexMinPQ.size);

  print(indexMinPQ.minIndex);

  // 测试修改
  indexMinPQ.changeItem(0, "Z");
  var mi;
  var sb = StringBuffer();
  while (!indexMinPQ.isEmpty) {
    mi = indexMinPQ.delMin();
    sb.write('$mi, ');
  }
  print(sb);
}
