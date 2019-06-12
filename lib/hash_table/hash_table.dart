import 'dart:math';
import 'hash_func.dart';

class HashTable<K, V> {
  static final _meaningless =
      r"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ`-=~!@#$%^&*()_+[]{}\|;:',./<>?¡™¢∞§¶•ªº–≠œ∑´®†¥¨øπ“‘«åß∂ƒ©©˙∆˚¬…æ≈ç√∫˜µµ≤≥÷";

  List<_TableEntry> _table;
  int _itemCount;
  _TableEntry _nilPlaceholder;
  final _initalSize = 32, _prime = 17, loadFactor = 0.75;

  factory HashTable.fromIterables(Iterable<K> keys, Iterable<V> values) {
    if (keys.length != values.length)
      throw StateError('number of keys does not equal to the number of values');
    var htb = HashTable<K, V>();
    for (var i = 0; i < keys.length; i++)
      htb[keys.elementAt(i)] = values.elementAt(i);
    return htb;
  }

  HashTable() : _itemCount = 0 {
    _table = List(_initalSize);

    var arr = _meaningless.split('');
    arr.shuffle();
    _nilPlaceholder =
        _TableEntry('_nilPlaceholder-${arr.join()}-_nilPlaceholder-_', null);
  }

  int get length => _itemCount;
  bool get isEmpty => _itemCount == 0;
  int get _bench => _table.length - 1;

  Iterable<K> get keys sync* {
    for (var e in _table) if (_isValid(e)) yield e.key;
  }

  Iterable<V> get values sync* {
    for (var e in _table) if (_isValid(e)) yield e.value;
  }

  bool contains(K key) => _find(key) != -1;

  void clear() {
    _table = List(_initalSize);
    _itemCount = 0;
  }

  void insert(K key, V value) {
    if (key == null) throw StateError('key can not be null!');

    _insert(_TableEntry(key, value));
    if (_itemCount > _table.length * loadFactor) _dilate();
  }

  V remove(K key) {
    V value;
    var i = _find(key);
    if (i != -1) {
      value = _table[i].value;
      _table[i] = _nilPlaceholder;
      _itemCount--;
    }
    return value;
  }

  V operator [](K key) {
    var i = _find(key);
    return i == -1 ? null : _table[i].value;
  }

  void operator []=(K key, V value) => insert(key, value);

  String toString() =>
      '{${_table.where((e) => _isValid(e)).toList().join(', ')}}';

  void _insert(_TableEntry<K, V> entry) {
    var hscode = _hashCode(entry.key), fi = _hash(hscode);
    var i = fi, j = 1, step = _rehashStep(hscode);
    while (_table[i] != null &&
        _table[i] != _nilPlaceholder &&
        _table[i].key != entry.key) i = _rehash(fi, j++, step);

    if (_table[i] == null || _table[i] == _nilPlaceholder) _itemCount++;
    _table[i] = entry;
  }

  void _dilate() {
    var oldTable = _table;
    _table = List(oldTable.length << 1);
    _itemCount = 0;

    for (var e in oldTable) if (_isValid(e)) _insert(e);
  }

  int _find(K key) {
    if (key == null) return -1;

    var hscode = _hashCode(key), fi = _hash(hscode);
    var i = fi, j = 1, step = _rehashStep(hscode);
    while (_table[i] != null && _table[i].key != key)
      i = _rehash(fi, j++, step);

    return _table[i] == null ? -1 : i;
  }

  bool _isValid(_TableEntry e) => e != null && e != _nilPlaceholder;

  int _hash(int hscode) => hscode % _bench;

  int _rehash(int fi, int j, int step) => (fi + j * step) % _bench;

  int _rehashStep(int hscode) => _prime - hscode % _prime;

  static int _hashCode<K>(K key) {
    var str = key is num
        ? key < 0 ? '-${sqrt(-key * pi) / 0.618}' : '${sqrt(key * pi) / 0.618}'
        : key.toString();

    return DJBHash(str);
  }
}

class _TableEntry<K, V> {
  K key;
  V value;
  _TableEntry(this.key, this.value);

  String toString() => '$key: $value';
}
