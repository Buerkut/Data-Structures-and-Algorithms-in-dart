class SingleLinkedListEntry<E> {
  late E _value;
  SingleLinkedListEntry<E>? next = null;

  SingleLinkedListEntry(this._value);

  E get value => _value;

  String toString() => _value.toString();
}

class DoubleLinkedListEntry<E> {
  late E _value;
  DoubleLinkedListEntry<E>? prev = null;
  DoubleLinkedListEntry<E>? next = null;

  DoubleLinkedListEntry(this._value);

  E get value => _value;

  String toString() => _value.toString();
}
