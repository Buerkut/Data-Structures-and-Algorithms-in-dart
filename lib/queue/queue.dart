/// based on list.

class Queue<E> {
  final List<E> _queue;

  Queue() : _queue = <E>[];

  String get content => _queue.toString();

  E get first {
    if (_queue.isEmpty) throw QueueEmptyException();
    return _queue.first;
  }

  bool get isEmpty => _queue.isEmpty;
  bool get isNotEmpty => _queue.isNotEmpty;
  int get length => _queue.length;

  void add(E e) => _queue.add(e);

  E pull() {
    if (_queue.isEmpty) throw QueueEmptyException();
    return _queue.removeAt(0);
  }
}

class QueueEmptyException implements Exception {
  const QueueEmptyException();
  String toString() => 'QueueEmptyException';
}
