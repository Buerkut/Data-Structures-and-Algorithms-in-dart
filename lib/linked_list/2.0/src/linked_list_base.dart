// double linked and double end list.
abstract class LinkedListBase<E> {
  LinkedListEntry<E>? _head = null;
  LinkedListEntry<E>? _tail = null;

  LinkedListEntry<E>? get head => _head;
  LinkedListEntry<E>? get tail => _tail;
  bool get isEmpty => head == null;
  bool get isNotEmpty => !isEmpty;

  E get first {
    if (isEmpty) throw LinkedListEmptyException();
    return head!.value;
  }

  E get last {
    if (isEmpty) throw LinkedListEmptyException();
    return tail!.value;
  }

  String get content {
    var sb = StringBuffer();
    sb.write('[');
    if (isNotEmpty) {
      for (var node = head; node != tail; node = node.next) {
        sb.write('${node!.value}, ');
      }
      sb.write(tail!.value);
    }
    sb.write(']');
    return sb.toString();
  }

  bool contains(Object? value) => search(value) != null;

  void forEach(void func(E value)) {
    for (var node = head; node != null; node = node.next) func(node.value!);
  }

  void clear() {
    _head = null;
    _tail = null;
  }

  void addFirst(E value) {
    var entry = LinkedListEntry(value);
    _link(null, head, entry);
    if (isEmpty) _tail = entry;
    _head = entry;
  }

  void addLast(E value) {
    var entry = LinkedListEntry(value);
    _link(tail, null, entry);
    if (isEmpty) _head = entry;
    _tail = entry;
  }

  bool insertAfter(E given, E value) {
    var node = search(given as Object);
    if (node == null) return false;

    var inserted = LinkedListEntry(value);
    _link(node, node.next, inserted);
    if (node == tail) _tail = inserted;
    return true;
  }

  bool insertBefore(E given, E value) {
    var node = search(given as Object);
    if (node == null) return false;

    var inserted = LinkedListEntry(value);
    _link(node.prev, node, inserted);
    if (node == head) _head = inserted;
    return true;
  }

  bool remove(E value) {
    var removed = search(value as Object);
    if (removed == null) return false;

    if (removed == head) _head = head!.next;
    if (removed == tail) _tail = tail!.prev;
    _unlink(removed);
    return true;
  }

  E removeFirst() {
    if (isEmpty) throw LinkedListEmptyException();
    var node = head;
    _head = head!.next;
    if (isEmpty) _tail = null;
    return _unlink(node!);
  }

  E removeLast() {
    if (isEmpty) throw LinkedListEmptyException();
    var node = tail;
    _tail = tail!.prev;
    if (tail == null) _head = null;
    return _unlink(node!);
  }

  LinkedListEntry<E>? search(Object? value) {
    var node = head;
    while (node != null && node.value != value) node = node.next;
    return node;
  }

  String toString() => content;

  void _link(LinkedListEntry<E>? prev, LinkedListEntry<E>? next,
      LinkedListEntry<E> entry) {
    if (prev != null) {
      prev.next = entry;
      entry.prev = prev;
    }
    if (next != null) {
      entry.next = next;
      next.prev = entry;
    }
  }

  E _unlink(LinkedListEntry<E> removed) {
    // if (removed == null) return null;
    var prev = removed.prev, next = removed.next;
    if (prev != null) {
      prev.next = next;
      removed.prev = null;
    }
    if (next != null) {
      next.prev = prev;
      removed.next = null;
    }
    return removed.value!;
  }
}

class LinkedListEntry<E> {
  // E _value;
  E value;
  // LinkedListEntry<E> _prev;
  // LinkedListEntry<E> _next;
  LinkedListEntry<E>? prev = null;
  LinkedListEntry<E>? next = null;

  LinkedListEntry(this.value);

  // E get value => _value;
  // LinkedListEntry<E> get prev => _prev;
  // LinkedListEntry<E> get next => _next;
}

class LinkedListEmptyException implements Exception {
  const LinkedListEmptyException();
  String toString() => 'LinkedListEmptyException';
}

/**
 * Creates errors throw by [List] when the element count is wrong.
 * Copied from dart-sdk.
 */
abstract class ListError {
  /** Error thrown thrown by, e.g., [List.first] when there is no result. */
  static StateError noElement() => StateError("No element");
  /** Error thrown by, e.g., [List.single] if there are too many results. */
  static StateError tooMany() => StateError("Too many elements");
  /** Error thrown by, e.g., [List.setRange] if there are too few elements. */
  static StateError tooFew() => StateError("Too few elements");
}
