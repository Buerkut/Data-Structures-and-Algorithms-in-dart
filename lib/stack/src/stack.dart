class Stack<E> {
  final List<E> _stack;

  Stack() : _stack = [];

  bool get isEmpty => _stack.isEmpty;
  bool get isNotEmpty => _stack.isNotEmpty;

  int get size => _stack.length;

  E get top {
    if (isEmpty) throw StackEmptyException();
    return _stack.last;
  }

  E pop() {
    if (isEmpty) throw StackEmptyException();
    return _stack.removeLast();
  }

  void push(E value) => _stack.add(value);

  String get content => _stack.reversed.toString();
}

class StackEmptyException implements Exception {
  const StackEmptyException();
  String toString() => 'StackEmptyException';
}
