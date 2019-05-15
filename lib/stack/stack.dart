class Stack<E> {
  final List<E> _stack;

  Stack() : _stack = <E>[];

  String get content => _stack.reversed.toString();
  bool get isEmpty => _stack.isEmpty;
  bool get isNotEmpty => _stack.isNotEmpty;
  int get size => _stack.length;

  E get top {
    if (_stack.isEmpty) throw StackEmptyException();
    return _stack.last;
  }

  E pop() {
    if (_stack.isEmpty) throw StackEmptyException();
    return _stack.removeLast();
  }

  void push(E e) => _stack.add(e);
}

class StackEmptyException implements Exception {
  const StackEmptyException();
  String toString() => 'StackEmptyException';
}
