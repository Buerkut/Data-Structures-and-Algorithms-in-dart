import 'linked_list_base.dart';

class ComparableList<E extends Comparable<E>> extends LinkedListBase<E> {
  void sort() {
    if (isNotEmpty) _sort(head!, tail!);
  }

  void _sort(LinkedListEntry<E> start, LinkedListEntry<E> end) {
    var lp = start, rp = end, key = lp.value;
    while (lp != rp) {
      while (rp.value.compareTo(key) >= 0 && rp != lp) rp = rp.prev!;
      if (rp != lp) {
        lp.value = rp.value;
        lp = lp.next!;
      }
      while (lp.value.compareTo(key) <= 0 && lp != rp) lp = lp.next!;
      if (lp != rp) {
        rp.value = lp.value;
        rp = rp.prev!;
      }
    }
    if (lp.value != key) lp.value = key;

    if (lp != start) _sort(start, lp.prev!);
    if (rp != end) _sort(rp.next!, end);
  }
}
