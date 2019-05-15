import 'linked_list_base.dart';
import 'linked_list.dart';

class OrderedList<E extends Comparable<E>> {
  final LinkedListBase<E> _list;

  OrderedList() : _list = LinkedList();

  E get first => _list.first;
  E get last => _list.last;
  String get content => _list.content;

  LinkedListEntry<E> get head => _list.head;
  LinkedListEntry<E> get tail => _list.tail;

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => !isEmpty;

  void clear() => _list.clear();

  bool contains(E value) => _list.contains(value);

  void insert(E value) {
    var p = head;
    while (p != null && p.value.compareTo(value) < 0) p = p.next;
    if (p == null) {
      _list.addLast(value);
    } else if (p == head) {
      _list.addFirst(value);
    } else {
      var inserted = LinkedListEntry(value);
      p.prev.next = inserted;
      inserted.prev = p.prev;
      inserted.next = p;
      p.prev = inserted;
    }
  }

  bool remove(E value) => _list.remove(value);

  E removeFirst() => _list.removeFirst();

  E removeLast() => _list.removeLast();
}
