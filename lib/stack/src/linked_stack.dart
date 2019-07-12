import 'package:data_struct/linked_list/linked_list.dart' show LinkedList;

class Stack<E> {
  final LinkedList<E> _stack;

  Stack() : _stack = LinkedList();

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

  String get content => _stack.join(', ');
}

class StackEmptyException implements Exception {
  const StackEmptyException();
  String toString() => 'StackEmptyException';
}
