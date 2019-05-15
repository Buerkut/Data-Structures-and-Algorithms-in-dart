class Stack<E> {
  final List<E> _stack;
  final int capacity;
  int _cursor;

  Stack(this.capacity)
      : _cursor = -1,
        _stack = List<E>(capacity);

  bool get isEmpty => _cursor == -1;
  bool get isNotEmpty => _cursor >= 0;
  bool get isFull => _cursor == capacity - 1;
  int get size => _cursor + 1;

  String get content => _stack.toString();

  void push(E e) {
    if (isFull) throw StackOverFlowException();
    _stack[++_cursor] = e;
  }

  E pop() {
    if (isEmpty) throw StackEmptyException();
    _stack.removeAt(_cursor);
    return _stack[_cursor--];
  }

  E get top {
    if (isEmpty) throw StackEmptyException();
    return _stack[_cursor];
  }
}

class StackOverFlowException implements Exception {
  const StackOverFlowException();
  String toString() => 'StackOverFlowException';
}

class StackEmptyException implements Exception {
  const StackEmptyException();
  String toString() => 'StackEmptyException';
}
