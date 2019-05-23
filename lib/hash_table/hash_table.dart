class TableEntry<K, V> {
  K _key;
  V _value;
  TableEntry(this._key, this._value);

  K get key => _key;
  V get value => _value;
}

class HashTable<K, V> {
  List<TableEntry<K, V>> _table;
  int _itemCount;

  HashTable()
      : _table = []..length = 64,
        _itemCount = 0;

  int _hashCode(K key) {
    int result;
    if (key is int) {
      result = key;
    } else if (key is double) {
      result = key.floor();
    } else if (key is String) {
      result = 17;
      for (var i = 0; i < key.length; i++)
        result = 37 * result + key[i].codeUnitAt(0) - 96;
    } else {}
  }
}
