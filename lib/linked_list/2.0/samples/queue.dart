// a queue on linked list.
import 'package:data_struct/linked_list/linked_list.dart';

class Queue<E> {
  final LinkedList<E> _queue;

  Queue() : _queue = LinkedList();

  bool get isEmpty => _queue.isEmpty;
  bool get isNotEmpty => !isEmpty;
  String get content => _queue.content;

  E get first {
    if (isEmpty) throw QueueEmptyException();
    return _queue.first;
  }

  E get last {
    if (isEmpty) throw QueueEmptyException();
    return _queue.last;
  }

  E pull() {
    if (isEmpty) throw QueueEmptyException();
    return _queue.removeFirst();
  }

  void push(E value) => _queue.addLast(value);
}

class QueueEmptyException implements Exception {
  const QueueEmptyException();
  String toString() => 'QueueEmptyException';
}
