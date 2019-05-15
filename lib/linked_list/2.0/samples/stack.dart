// a stack on linked list.
import 'package:data_struct/linked_list/linked_list.dart';

class Stack<E> {
  final LinkedList<E> _stack;

  Stack() : _stack = LinkedList();

  bool get isEmpty => _stack.isEmpty;
  bool get isNotEmpty => !isEmpty;
  String get content => _stack.content;

  E get top {
    if (isEmpty) throw StackEmptyException();
    return _stack.first;
  }

  E pop() {
    if (isEmpty) throw StackEmptyException();
    return _stack.removeFirst();
  }

  void push(E value) => _stack.addFirst(value);
}

class StackEmptyException implements Exception {
  const StackEmptyException();
  String toString() => 'StackEmptyException';
}
