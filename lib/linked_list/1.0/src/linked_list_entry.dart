class SingleLinkedListEntry<E> {
  E _value;
  SingleLinkedListEntry<E> next;

  SingleLinkedListEntry(this._value);

  E get value => _value;

  String toString() => _value.toString();
}

class DoubleLinkedListEntry<E> {
  E _value;
  DoubleLinkedListEntry<E> prev;
  DoubleLinkedListEntry<E> next;

  DoubleLinkedListEntry(this._value);

  E get value => _value;

  String toString() => _value.toString();
}
