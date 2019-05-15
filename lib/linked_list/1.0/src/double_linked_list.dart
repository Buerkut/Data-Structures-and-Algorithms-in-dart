import 'linked_list_entry.dart' show DoubleLinkedListEntry;

class DoubleLinkedList<E> {
  DoubleLinkedListEntry<E> _head;
  DoubleLinkedListEntry<E> _tail;

  DoubleLinkedListEntry<E> get head => _head;
  DoubleLinkedListEntry<E> get tail => _tail;
  bool get isEmpty => _head == null;
  bool get isNotEmpty => _head != null;

  void clear() {
    _head = null;
    _tail = null;
  }

  bool contains(E value) => _search(value) != null;

  void forEach(void func(E value)) {
    for (var node = _head; node != null; node = node.next) func(node.value);
  }

  void insertFirst(E value) {
    var entry = DoubleLinkedListEntry(value);
    if (isEmpty) {
      _tail = entry;
    } else {
      entry.next = _head;
      _head.prev = entry;
    }
    _head = entry;
  }

  bool insertAfter(E given, E inserted) {
    var node = _search(given);
    if (node == null) return false;

    var entry = DoubleLinkedListEntry(inserted);
    if (node == _tail) {
      _tail = entry;
    } else {
      entry.next = node.next;
      node.next.prev = entry;
    }
    entry.prev = node;
    node.next = entry;
    return true;
  }

  void insertLast(E value) {
    var entry = DoubleLinkedListEntry(value);
    if (isEmpty) {
      _head = entry;
    } else {
      entry.prev = _tail;
      _tail.next = entry;
    }
    _tail = entry;
  }

  E removeFirst() {
    if (isEmpty) return null;

    var first = _head;
    _head = _head.next;
    if (_head == null) {
      _tail == null;
    } else {
      _head.prev = null;
      first.next = null;
    }
    return first.value;
  }

  bool remove(E value) {
    var node = _search(value);
    if (node == null) return false;

    if (node == _head) {
      _head = _head.next;
      if (_head == null) {
        _tail = null;
      } else {
        _head.prev = null;
        node.next = null;
      }
    } else {
      node.prev.next = node.next;
      if (node == _tail) {
        _tail = _tail.prev;
      } else {
        node.next.prev = node.prev;
        node.next = null;
      }
      node.prev = null;
    }
    return true;
  }

  E removeLast() {
    if (isEmpty) return null;

    var last = _tail;
    _tail = _tail.prev;
    if (_tail == null) {
      _head = null;
    } else {
      _tail.next = null;
      last.prev = null;
    }
    return last.value;
  }

  DoubleLinkedListEntry<E> _search(E value) {
    var node = head;
    while (node != null && node.value != value) node = node.next;
    return node;
  }
}
