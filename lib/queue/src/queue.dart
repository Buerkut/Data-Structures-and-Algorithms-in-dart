/// based on list.

class Queue<E> {
  final List<E> _queue;

  Queue() : _queue = [];

  bool get isEmpty => _queue.isEmpty;
  bool get isNotEmpty => _queue.isNotEmpty;
  int get length => _queue.length;

  E get first {
    if (isEmpty) throw QueueEmptyException();
    return _queue.first;
  }

  E pull() {
    if (isEmpty) throw QueueEmptyException();
    return _queue.removeAt(0);
  }

  void push(E e) => _queue.add(e);

  String get content => _queue.toString();
}

class QueueEmptyException implements Exception {
  const QueueEmptyException();
  String toString() => 'QueueEmptyException';
}
