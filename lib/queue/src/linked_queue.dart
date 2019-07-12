import 'package:data_struct/linked_list/linked_list.dart' show LinkedList;

class Queue<E> {
  final LinkedList<E> _queue;

  Queue() : _queue = LinkedList();

  bool get isEmpty => _queue.isEmpty;
  bool get isNotEmpty => _queue.isNotEmpty;
  int get length => _queue.length;

  E get first {
    if (isEmpty) throw QueueEmptyException();
    return _queue.first;
  }

  E pull() {
    if (isEmpty) throw QueueEmptyException();
    return _queue.removeFirst();
  }

  void push(E value) => _queue.add(value);

  String get content => _queue.join(', ');
}

class QueueEmptyException implements Exception {
  const QueueEmptyException();
  String toString() => 'QueueEmptyException';
}
