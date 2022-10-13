import 'linked_list_entry.dart' show SingleLinkedListEntry;

class SingleLinkedList<E> {
  SingleLinkedListEntry<E>? _head = null;

  SingleLinkedListEntry<E>? get head => _head;
  bool get isEmpty => _head == null;
  bool get isNotEmpty => _head != null;

  void clear() => _head = null;

  bool contains(E value) => _search(value) != null;

  void forEach(void func(E value)) {
    for (var node = _head; node != null; node = node.next) func(node.value);
  }

  void insertFirst(E value) {
    var entry = SingleLinkedListEntry(value);
    entry.next = _head;
    _head = entry;
  }

  bool insertAfter(E given, E inserted) {
    var node = _search(given);
    if (node == null) return false;

    var entry = SingleLinkedListEntry(inserted);
    entry.next = node.next;
    node.next = entry;
    return true;
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
    curr.next = null;
    return true;
  }

  E? removeFirst() {
    if (isEmpty) return null;

    var first = _head;
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
  SingleLinkedList<E> get reversed {
    var reversed = SingleLinkedList<E>();
    for (var t = head; t != null; t = t.next) reversed.insertFirst(t.value);
    return reversed;
  }

  // this will modify itself.
  void reverse() {
    if (isEmpty || _head!.next == null) return;

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
