import 'dart:math';
import 'package:data_struct/linked_list/linked_list.dart';
import './hash_func.dart' show DJBHash;

class LinkedHashTable<K, V> {
  List<LinkedList<_TableEntry<K, V>>?> _table;
  int _itemCount, _filledCells;
  static final _initalSize = 64, loadFactor = 0.8;

  int get length => _itemCount;
  bool get isEmpty => _itemCount == 0;
  bool get _isOverloaded => _filledCells > _table.length * loadFactor;

  factory LinkedHashTable.fromIterables(Iterable<K> keys, Iterable<V> values) {
    if (keys.length != values.length)
      throw StateError('number of keys does not equal to the number of values');
    var lhtb = LinkedHashTable<K, V>();
    for (var i = 0; i < keys.length; i++)
      lhtb[keys.elementAt(i)] = values.elementAt(i);
    return lhtb;
  }

  LinkedHashTable()
      : _itemCount = 0,
        _filledCells = 0,
        _table = List.filled(_initalSize, null);

  Iterable<K> get keys sync* {
    for (var bucket in _table)
      if (bucket != null) for (var e in bucket) yield e.key;
  }

  Iterable<V> get values sync* {
    for (var bucket in _table)
      if (bucket != null) for (var e in bucket) yield e.value;
  }

  bool contains(K key) =>
      key != null && _findInBucket(_table[_hash(key)], key) != null;

  void clear() {
    _table = List.filled(_initalSize, null);
    _itemCount = _filledCells = 0;
  }

  void insert(K key, V value) {
    if (key == null) throw StateError('key can not be null!');
    _insert(_TableEntry(key, value));

    if (_isOverloaded) _dilate();
  }

  V? remove(K key) {
    var i = _hash(key), e = _findInBucket(_table[i], key);
    if (e != null && _table[i]!.remove(e)) {
      _itemCount--;
      if (_table[i]!.isEmpty) {
        _table[i] = null;
        _filledCells--;
      }
    }
    return e?.value;
  }

  V? operator [](K key) =>
      key == null ? null : _findInBucket(_table[_hash(key)], key)?.value;

  void operator []=(K key, V value) => insert(key, value);

  String toString() {
    var sb = StringBuffer();
    for (var bucket in _table)
      if (bucket != null) sb.write('${bucket.join(', ')}, ');

    return '{${sb.isEmpty ? '' : sb.toString().substring(0, sb.length - 2)}}';
  }

  void _insert(_TableEntry<K, V> entry) {
    var i = _hash(entry.key), e = _findInBucket(_table[i], entry.key);
    if (e != null) {
      e.value = entry.value;
    } else {
      if (_table[i] == null) {
        _table[i] = LinkedList();
        _filledCells++;
      }
      _table[i]!.add(entry);
      _itemCount++;
    }
  }

  void _dilate() {
    var oldTable = _table;
    _table = List.filled(oldTable.length << 1, null);
    _itemCount = _filledCells = 0;
    for (var bucket in oldTable)
      if (bucket != null) for (var e in bucket) _insert(e);
  }

  _TableEntry<K, V>? _findInBucket(
      LinkedList<_TableEntry<K, V>>? bucket, K key) {
    var ptr = bucket?.head;
    while (ptr != null && ptr.value.key != key) ptr = ptr.next;
    return ptr?.value;
  }

  int _hash(K key) {
    var str = key is num
        ? key < 0
            ? '-${sqrt(-key * pi * e) / 0.618}'
            : '${sqrt(key * pi * e) / 0.618}'
        : key.toString();

    return DJBHash(str) % (_table.length - 1);
  }
}

class _TableEntry<K, V> {
  K key;
  V value;
  _TableEntry(this.key, this.value);

  String toString() => '$key: $value';
}
