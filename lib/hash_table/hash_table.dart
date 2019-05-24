class HashTable<K, V> {
  List<_TableEntry<K, V>> _table;
  int _itemCount;

  factory HashTable.fromIterables(Iterable<K> keys, Iterable<V> values) {
    if (keys.length != values.length)
      throw StateError('number of keys does not equal to the number of values');
    var htb = HashTable<K, V>(keys.length << 1);
    for (var i = 0; i < keys.length; i++)
      htb.insert(keys.elementAt(i), values.elementAt(i));
    return htb;
  }

  HashTable([initalSize])
      : _itemCount = 0,
        _table = List(initalSize ?? 256);

  int get size => _itemCount;
  bool get isEmpty => size == 0;

  bool contains(K key) => _table[_address(key)] != null;

  void clear() {
    _table = null;
    _itemCount = 0;
  }

  void insert(K key, V value) {
    if (key == null) throw StateError('key and value can not be null!');
    _insert(_TableEntry(key, value));
    if (_itemCount++ == _table.length - 1) _dilate();
  }

  V remove(K key) {
    var i = _address(key), entry = _table[i];
    if (entry != null) {
      _table[i] = null;
      _itemCount--;
    }
    return entry?.value;
  }

  V operator [](K key) => _table[_address(key)]?.value;

  void operator []=(K key, V value) => insert(key, value);

  String toString() => _table.toString();

  void _insert(_TableEntry<K, V> entry) => _table[_address(entry.key)] = entry;

  int _address(K key) {
    var hashValue = _hash(key, _table.length);
    while (_table[hashValue] != null && _table[hashValue].key != key)
      hashValue = _rehash(hashValue, _table.length);
    return hashValue;
  }

  void _dilate() {
    var oldTable = _table;
    _table = List(oldTable.length << 1);
    for (var entry in oldTable) _insert(entry);
  }

  static int _hash<K>(K key, int modelSize) {
    int result;
    if (key is int) {
      result = key;
    } else if (key is double) {
      result = key.floor();
    } else {
      result = 17;
      var s = key is String ? key : key.toString();
      for (var i = 0; i < s.length; i++)
        result = 37 * result + s[i].codeUnitAt(0);
    }
    return result % modelSize;
  }

  static int _rehash(int hashValue, int modelSize) {
    // linear probing;
    // hashValue++;

    // quadratic probing;
    // var i = 1;
    // hashValue += i * i;
    // i++;

    // double hashing;
    hashValue += 7 - hashValue % 7;
    return hashValue % modelSize;
  }
}

class _TableEntry<K, V> {
  K key;
  V value;
  _TableEntry(this.key, this.value);

  String toString() => '{$key: $value}';
}
