import 'linked_list_entry.dart' show SingleLinkedListEntry;

class DoubleEndList<E> {
  SingleLinkedListEntry<E>? _head = null;
  SingleLinkedListEntry<E>? _tail = null;

  SingleLinkedListEntry<E>? get head => _head;
  SingleLinkedListEntry<E>? get tail => _tail;
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
    var entry = SingleLinkedListEntry(value);
    if (isEmpty) {
      _tail = entry;
    } else {
      entry.next = _head;
    }
    _head = entry;
  }

  bool insertAfter(E given, E inserted) {
    var node = _search(given);
    if (node == null) return false;

    var entry = SingleLinkedListEntry(inserted);
    if (node == _tail) {
      _tail = entry;
    } else {
      entry.next = node.next;
    }
    node.next = entry;
    return true;
  }

  void insertLast(E value) {
    var entry = SingleLinkedListEntry(value);
    if (isEmpty) {
      _head = entry;
    } else {
      _tail!.next = entry;
    }
    _tail = entry;
  }

  bool remove(E value) {
    SingleLinkedListEntry<E>? prev, curr = _head;
    while (curr != null && curr.value != value) {
      prev = curr;
      curr = curr.next;
    }

    if (curr == null) return false;
    if (curr == _head) {
      _head = _head!.next;
    } else {
      prev!.next = curr.next;
    }
    if (curr == _tail) {
      _tail = prev;
    } else {
      curr.next = null;
    }
    return true;
  }

  E? removeFirst() {
    if (isEmpty) return null;

    var first = _head;
    if (_head == _tail) _tail = null;
    _head = _head!.next;
    first!.next = null;
    return first.value;
  }

  SingleLinkedListEntry<E>? _search(E value) {
    var node = _head;
    while (node != null && node.value != value) node = node.next;
    return node;
  }

  // don't modify the list itself. generate a new list.
  DoubleEndList<E> get reversed {
    var reversed = DoubleEndList<E>();
    for (var t = head; t != null; t = t.next) reversed.insertFirst(t.value);
    return reversed;
  }

  // this will modify itself.
  void reverse() {
    if (isEmpty || _head == _tail) return;

    _tail = _head;
    SingleLinkedListEntry<E>? reversed = null;
    while (_head!.next != null) {
      var t = _head!.next;
      _head!.next = reversed;
      reversed = _head;
      _head = t;
    }
    _head!.next = reversed;
  }
}
