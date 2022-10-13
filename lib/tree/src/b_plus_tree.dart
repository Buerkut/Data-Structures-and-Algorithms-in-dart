class BPlusTree<K extends Comparable<K>, V> {
  final int order, _half;
  BPNode<K>? _root, data;
  int _elemCount;

  factory BPlusTree.of(Iterable<K> keys, Iterable<V> values, int order) {
    if (keys.length != values.length)
      throw StateError('number of keys does not equal to the number of values');
    var bpTree = BPlusTree<K, V>(order);
    for (var i = 0; i < keys.length; i++)
      bpTree.insert(keys.elementAt(i), values.elementAt(i));
    return bpTree;
  }

  BPlusTree(this.order)
      : _elemCount = 0,
        _half = order >> 1 {
    if (order < 4) throw StateError('order needs >= 4!');
  }

  BPNode<K>? get root => _root;
  int get elemCount => _elemCount;
  bool get isEmpty => root == null;

  int get height {
    var h = 0, c = root;
    while (c != null) {
      h++;
      c = c.isLeaf ? null : c._branches[0];
    }
    return h;
  }

  bool contains(K key) => find(key) != null;

  Map<int, BPLeaf<K, V>>? find(K key) {
    var c = root, i = 0;
    while (c != null) {
      while (i < c.size && c._keys[i].compareTo(key) <= 0) i++;
      if (i == 0) {
        c = null;
      } else if (!c.isLeaf) {
        c = c._branches[i - 1];
        i = 0;
      } else if (c._keys[i - 1].compareTo(key) != 0) {
        c = null;
      } else {
        break;
      }
    }
    return c == null ? null : {i - 1: c as BPLeaf<K, V>};
  }

  void insert(K key, V value) {
    var c = root, i = 0;
    while (c != null) {
      while (i < c.size && c._keys[i].compareTo(key) < 0) i++;
      if (i < c.size && c._keys[i].compareTo(key) == 0) return;
      if (c.isLeaf) break;
      c = c._branches[i > 0 ? i - 1 : 0];
      i = 0;
    }
    if (c != null) {
      (c as BPLeaf)._insert(i, key, value);
      _fixAfterIns(c, i);
    } else {
      _root = data = BPLeaf(key, value);
    }
    _elemCount++;
  }

  Map<K, V>? delete(K key) {
    var map = find(key);
    if (map == null) return null;
    var i = map.keys.first, d = map.values.first;
    var result = d._removeAt(i);
    _fixAfterDel(d, i);
    _elemCount--;
    return result;
  }

  bool update(K key, V value) {
    var map = find(key);
    if (map == null) return false;
    var i = map.keys.first, c = map.values.first;
    c._updateValue(i, value);
    return true;
  }

  void traverse(void func(BPNode<K> r)) => _traverse(root, func);

  void _fixAfterIns(BPNode<K> c, int i) {
    _updateParentBoundKey(c, i);

    while (c.size > order) {
      if (c._parent != null) {
        var j = 0, p = c._parent;
        while (p!._branches[j] != c) j++;
        if (j > 0 && _isNotFull(p._branches[j - 1])) {
          _rotateLeft(p, j);
          break;
        } else if (j < p.size - 1 && _isNotFull(p._branches[j + 1])) {
          _rotateRight(p, j);
          break;
        }
      }

      _split(c);
      c = c._parent!;
    }
  }

  void _updateParentBoundKey(BPNode<K> c, int i) {
    while (i == 0 && c._parent != null) {
      while (c._parent!._branches[i] != c) i++;
      c._parent!._keys[i] = c._keys[0];
      c = c._parent!;
    }
  }

  bool _isNotFull(BPNode<K> c) => c.size < order;

  void _rotateLeft(BPNode<K> p, int i) {
    var left = p._branches[i - 1], right = p._branches[i];
    left._addKey(right._removeKeyAt(0));
    p._keys[i] = right._keys[0];
    if (left.isLeaf)
      (left as BPLeaf<K, V>)
          ._addValue((right as BPLeaf<K, V>)._removeValueAt(0));
    else
      left._addBranch(right._removeBranchAt(0));
  }

  void _rotateRight(BPNode<K> p, int i) {
    var left = p._branches[i], right = p._branches[i + 1];
    p._keys[i + 1] = left._removeLastKey();
    right._insertKey(0, p._keys[i + 1]);
    if (left.isLeaf)
      (right as BPLeaf<K, V>)
          ._insertValue(0, (left as BPLeaf<K, V>)._removeLastValue());
    else
      right._insertBranch(0, left._removeLastBranch());
  }

  void _split(BPNode<K> c) {
    BPNode<K> novNode;
    if (c.isLeaf) {
      novNode = BPLeaf._internal(c._keys.getRange(_half, c.size),
          (c as BPLeaf<K, V>)._values.getRange(_half, c.size));
      c._values.removeRange(_half, c.size);
      c._link(novNode as BPLeaf<K, V>);
    } else {
      novNode = BPNode._internal(c._keys.getRange(_half, c.size));
      novNode._addBranches(c._branches.getRange(_half, c.size));
      c._branches.removeRange(_half, c.size);
    }
    c._keys.removeRange(_half, c.size);

    if (c._parent != null) {
      var i = 0;
      while (c._parent!._branches[i++] != c);
      c._parent!._insertKey(i, novNode._keys[0]);
      c._parent!._insertBranch(i, novNode);
    } else {
      _root = BPNode._internal([c._keys[0], novNode._keys[0]]);
      _root!._addBranches([c, novNode]);
    }
  }

  void _fixAfterDel(BPNode<K> d, int i) {
    _updateParentBoundKey(d, i);

    while (d.size < _half) {
      if (d == root) {
        if (d.isLeaf && d.isEmpty) {
          _root = null;
        } else if (!d.isLeaf && d.size == 1) {
          _root = root!._branches[0];
          _root!._parent = null;
        }
        break;
      } else {
        i = 0;
        while (d._parent!._branches[i] != d) i++;
        if (i > 0) {
          if (_isRich(d._parent!._branches[i - 1])) {
            _rotateRight(d._parent!, i - 1);
            break;
          } else if (i < d._parent!.size - 1 &&
              _isRich(d._parent!._branches[i + 1])) {
            _rotateLeft(d._parent!, i + 1);
            break;
          } else {
            _mergeIntoLeft(d, i);
            d = d._parent!;
          }
        } else if (_isRich(d._parent!._branches[i + 1])) {
          _rotateLeft(d._parent!, i + 1);
          break;
        } else {
          _mergeIntoLeft(d._parent!._branches[i + 1], i + 1);
          d = d._parent!;
        }
      }
    }
  }

  bool _isRich(BPNode<K> c) => c.size > _half;

  void _mergeIntoLeft(BPNode<K> c, int i) {
    var leftSib = c._parent!._branches[i - 1];
    leftSib._addKeys(c._keys);
    c._parent!._removeKeyAt(i);
    c._parent!._removeBranchAt(i);
    if (c.isLeaf) {
      (leftSib as BPLeaf<K, V>)._addValues((c as BPLeaf<K, V>)._values);
      leftSib.next = c.next;
      c.next!.prev = leftSib;
    } else {
      leftSib._addBranches(c._branches);
    }
  }

  void _traverse(BPNode<K>? r, void f(BPNode<K> r)) {
    if (r == null) return;
    f(r);
    if (!r.isLeaf) for (var b in r._branches) _traverse(b, f);
  }
}

class BPNode<K extends Comparable<K>> {
  List<K> _keys;
  BPNode<K>? _parent;
  List<BPNode<K>> _branches = [];

  BPNode(K key) : _keys = [] {
    _keys.add(key);
  }

  BPNode._internal(Iterable<K> ks) : _keys = [] {
    _keys.addAll(ks);
  }

  bool get isEmpty => _keys.isEmpty;
  bool get isLeaf => false;
  int get size => _keys.length;

  bool contains(K key) => find(key) != -1;
  int find(K key) => _keys.indexOf(key);

  void _addKey(K key) => _keys.add(key);
  void _addKeys(Iterable<K> ks) => _keys.addAll(ks);

  void _insertKey(int j, K key) => _keys.insert(j, key);

  void _addBranch(BPNode<K> brch) {
    _branches.add(brch);
    brch._parent = this;
  }

  void _insertBranch(int j, BPNode<K> brch) {
    _branches.insert(j, brch);
    brch._parent = this;
  }

  void _addBranches(Iterable<BPNode<K>> children) {
    // _branches ??= [];
    _branches.addAll(children);
    for (var c in children) c._parent = this;
  }

  K _removeKeyAt(int i) => _keys.removeAt(i);
  K _removeLastKey() => _keys.removeLast();

  BPNode<K> _removeBranchAt(int i) => _branches.removeAt(i);
  BPNode<K> _removeLastBranch() => _branches.removeLast();

  String toString() => _keys.toString();
}

class BPLeaf<K extends Comparable<K>, V> extends BPNode<K> {
  List<V> _values;
  BPLeaf<K, V>? prev, next;

  BPLeaf(K key, V value)
      : _values = [],
        super(key) {
    _values.add(value);
  }

  BPLeaf._internal(Iterable<K> ks, Iterable<V> vs)
      : _values = [],
        super._internal(ks) {
    _values.addAll(vs);
  }

  bool get isLeaf => true;

  V? valueOf(K key) {
    var i = _keys.indexOf(key);
    return i != -1 ? _values[i] : null;
  }

  void _addValue(V value) => _values.add(value);

  void _addValues(Iterable<V> vs) => _values.addAll(vs);

  void _insertValue(int i, V value) => _values.insert(i, value);

  void _insert(int i, K key, V value) {
    _insertKey(i, key);
    _insertValue(i, value);
  }

  V _removeValueAt(int i) => _values.removeAt(i);
  V _removeLastValue() => _values.removeLast();

  Map<K, V> _removeAt(int i) => {_removeKeyAt(i): _removeValueAt(i)};

  void _updateValue(int i, V value) => _values[i] = value;

  void _link(BPLeaf<K, V> other) {
    if (next != null) {
      other.next = next;
      next!.prev = other;
    }
    next = other;
    other.prev = this;
  }

  String toString() {
    var sb = StringBuffer('[');
    if (size > 0) {
      for (var i = 0; i < size - 1; i++)
        sb.write('{${_keys[i]}: ${_values[i]}}, ');
      sb.write('{${_keys[size - 1]}: ${_values[size - 1]}}');
    }
    sb.write(']');
    return sb.toString();
  }
}
