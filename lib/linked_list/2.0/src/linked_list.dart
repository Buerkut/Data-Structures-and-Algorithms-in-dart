import 'linked_list_base.dart';

class LinkedList<E> extends LinkedListBase<E> implements Iterable<E> {
  int _length = 0;

  LinkedList();

  factory LinkedList.of(Iterable<E> elements) {
    var list = LinkedList<E>();
    list.addAll(elements);
    return list;
  }

  Iterator<E> get iterator => _LinkedListIterator(this);
  int get length => _length;

  Iterable<E> get reversed sync* {
    for (var ptr = tail; ptr != null; ptr = ptr.prev) yield ptr.value;
  }

  E get single {
    if (isEmpty) throw LinkedListEmptyException();
    if (head != tail) throw StateError('too many elements!');
    return head.value;
  }

  void add(E value) => addLast(value);

  void addAll(Iterable<E> elements) {
    for (var e in elements) add(e);
  }

  void addFirst(E value) {
    super.addFirst(value);
    _length++;
  }

  void addLast(E value) {
    super.addLast(value);
    _length++;
  }

  void clear() {
    super.clear();
    _length = 0;
  }

  LinkedList<E> copy() => LinkedList<E>.of(this);

  bool insertAfter(E given, E value) {
    if (super.insertAfter(given, value)) {
      _length++;
      return true;
    }
    return false;
  }

  bool insertBefore(E given, E value) {
    if (super.insertBefore(given, value)) {
      _length++;
      return true;
    }
    return false;
  }

  bool remove(E value) {
    var removed = search(value);
    if (removed == null) return false;
    _remove(removed);
    return true;
  }

  E removeFirst() => _remove(head);

  E removeLast() => _remove(tail);

  void removeWhere(bool test(E element)) {
    var ptr = head;
    while (ptr != null) {
      if (test(ptr.value)) {
        var removed = ptr;
        ptr = ptr.next;
        _remove(removed);
      } else {
        ptr = ptr.next;
      }
    }
  }

  void retainWhere(bool test(E element)) => removeWhere((e) => !test(e));

  void sort(int compare(E a, E b)) {
    if (length > 1) _sort(compare, head, tail);
  }

  LinkedList<E> sublist(int start, [int end]) {
    if (start < 0) throw RangeError('out of range.');
    end ??= length;
    if (start > end || end > length) throw RangeError('out of range.');
    var i = 0, ptr = head, list = LinkedList<E>();
    while (i++ < start) ptr = ptr.next;
    i--;
    while (i++ < end) {
      list.add(ptr.value);
      ptr = ptr.next;
    }
    return list;
  }

  bool any(bool test(E element)) {
    for (var e in this) {
      if (test(e)) return true;
    }
    return false;
  }

  Map<int, E> asMap() {
    var map = <int, E>{}, i = 0;
    for (var e in this) map[i++] = e;
    return Map.unmodifiable(map);
  }

  Iterable<R> cast<R>() sync* {
    for (var e in this) yield e as R;
  }

  E elementAt(int index) {
    if (index < 0 || index > length - 1) throw RangeError('out of range.');
    var count = 0, ptr = head;
    while (count++ < index) ptr = ptr.next;
    return ptr.value;
  }

  bool every(bool test(E element)) {
    for (var e in this) {
      if (!test(e)) return false;
    }
    return true;
  }

  Iterable<T> expand<T>(Iterable<T> func(E element)) sync* {
    for (var e in this) {
      for (var ee in func(e)) yield ee;
    }
  }

  E firstWhere(bool test(E element), {E orElse()}) {
    for (var e in this) {
      if (test(e)) return e;
    }
    if (orElse != null) return orElse();
    return null;
  }

  E lastWhere(bool test(E element), {E orElse()}) {
    for (var right = tail; right != null; right = right.prev) {
      if (test(right.value)) return right.value;
    }
    if (orElse != null) return orElse();
    return null;
  }

  T fold<T>(T initialValue, T combine(T previousValue, E element)) {
    var value = initialValue;
    for (var e in this) value = combine(value, e);
    return value;
  }

  Iterable<E> followedBy(Iterable<E> other) sync* {
    for (var e in this) yield e;
    for (var e in other) yield e;
  }

  String join([String separator = '']) {
    var iter = iterator;
    if (!iter.moveNext()) return '';
    var sb = StringBuffer();
    sb.write(iter.current);
    if (separator == null || separator == '') {
      while (iter.moveNext()) sb.write(iter.current);
    } else {
      while (iter.moveNext()) sb..write(separator)..write(iter.current);
    }
    return sb.toString();
  }

  Iterable<T> map<T>(T func(E element)) sync* {
    for (var e in this) yield func(e);
  }

  E reduce(E combine(E value, E element)) {
    var iter = iterator;
    if (!iter.moveNext()) throw LinkedListEmptyException();
    var result = iter.current;
    while (iter.moveNext()) result = combine(result, iter.current);
    return result;
  }

  E singleWhere(bool test(E element), {E orElse()}) {
    E result;
    var found = false;
    for (var e in this) {
      if (test(e)) {
        if (found) throw StateError('too many elements matched.');
        result = e;
        found = true;
      }
    }
    if (found) return result;
    if (orElse != null) return orElse();
    return null;
  }

  Iterable<E> skip(int count) sync* {
    var iter = iterator;
    while (count-- > 0 && iter.moveNext());
    while (iter.moveNext()) yield iter.current;
  }

  Iterable<E> skipWhile(bool test(E element)) sync* {
    var iter = iterator;
    while (iter.moveNext() && test(iter.current));
    if (iter.current != null) {
      do {
        yield iter.current;
      } while (iter.moveNext());
    }
  }

  Iterable<E> take(int count) sync* {
    var iter = iterator;
    while (iter.moveNext() && count-- > 0) yield iter.current;
  }

  Iterable<E> takeWhile(bool test(E element)) sync* {
    var iter = iterator;
    while (iter.moveNext() && test(iter.current)) yield iter.current;
  }

  Iterable<E> where(bool test(E element)) sync* {
    for (var e in this) {
      if (test(e)) yield e;
    }
  }

  Iterable<T> whereType<T>() sync* {
    for (var e in this) {
      if (e is T) yield e;
    }
  }

  List<E> toList({bool growable: true}) {
    return List<E>.from(this, growable: growable);
  }

  Set<E> toSet() => Set<E>.from(this);

  E operator [](int index) => elementAt(index);

  void operator []=(int index, E value) {
    if (index < 0 || index > length - 1) throw RangeError('out of range.');
    var count = 0, ptr = head;
    while (count++ < index) ptr = ptr.next;
    ptr.value = value;
  }

  E _remove(LinkedListEntry<E> removed) {
    if (removed == null) return null;
    if (removed == head) {
      super.removeFirst();
    } else if (removed == tail) {
      super.removeLast();
    } else {
      var prev = removed.prev, next = removed.next;
      if (prev != null) {
        prev.next = next;
        removed.prev = null;
      }
      if (next != null) {
        next.prev = prev;
        removed.next = null;
      }
    }
    _length--;
    return removed.value;
  }

  void _sort(
      int compare(E a, E b), LinkedListEntry<E> start, LinkedListEntry<E> end) {
    var lp = start, rp = end, key = lp.value;
    while (lp != rp) {
      while (compare(rp.value, key) >= 0 && rp != lp) rp = rp.prev;
      if (rp != lp) {
        lp.value = rp.value;
        lp = lp.next;
      }
      while (compare(lp.value, key) <= 0 && lp != rp) lp = lp.next;
      if (lp != rp) {
        rp.value = lp.value;
        rp = rp.prev;
      }
    }
    if (lp.value != key) lp.value = key;

    if (lp != start) _sort(compare, start, lp.prev);
    if (rp != end) _sort(compare, rp.next, end);
  }
}

class _LinkedListIterator<E> implements Iterator<E> {
  LinkedListEntry<E> _iter;
  E _current;
  bool _moved;

  _LinkedListIterator(LinkedList<E> list)
      : _iter = LinkedListEntry<E>(null),
        _moved = false {
    _iter.next = list.head;
  }

  E get current {
    if (!_moved) throw StateError('moveNext() should be called at first.');
    return _current;
  }

  bool moveNext() {
    if (!_moved) _moved = true;

    if (_iter.next == null) {
      _current = null;
      return false;
    }
    _iter = _iter.next;
    _current = _iter.value;
    return true;
  }
}
