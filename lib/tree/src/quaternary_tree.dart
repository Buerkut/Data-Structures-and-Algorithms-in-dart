class QuaternaryTree<E extends Comparable<E>> {
  QuaterNode<E>? _root;
  int _elementsCount;

  factory QuaternaryTree.of(Iterable<E> elements) {
    var tree = QuaternaryTree<E>();
    for (var e in elements) tree.insert(e);
    return tree;
  }

  QuaternaryTree() : _elementsCount = 0;

  int get elementsCount => _elementsCount;
  QuaterNode<E>? get root => _root;

  int get height {
    var h = 0, c = root;
    while (c != null) {
      h++;
      c = c.isNotLeaf ? c.branches[0] : null;
    }
    return h;
  }

  bool get isEmpty => _root == null;

  bool contains(E value) => find(value) != null;

  QuaterNode<E>? find(E value) {
    var c = root;
    while (c != null) {
      var i = 0;
      while (i < c.size && c.items[i].compareTo(value) < 0) i++;
      if (i < c.size && c.items[i] == value) break;
      c = c.isNotLeaf ? c.branches[i] : null;
    }
    return c;
  }

  void insert(E value) {
    var c = root, i = 0;
    while (c != null) {
      i = 0;
      while (i < c.size && c.items[i].compareTo(value) < 0) i++;
      if (i < c.size && c.items[i] == value) return;
      if (c.isLeaf) break;
      c = c.branches[i];
    }
    if (c != null) {
      c.items.insert(i, value);
      if (c.isOverflow) _fixAfterIns(c);
    } else {
      _root = QuaterNode([value]);
    }
    _elementsCount++;
  }

  bool delete(E value) {
    var d = find(value);
    if (d == null) return false;
    var i = d.find(value);
    if (d.isNotLeaf) {
      var s = _successor(d.branches[i + 1]);
      d.items[i] = s.items[0];
      d = s;
      i = 0;
    }
    d.items.removeAt(i);
    _elementsCount--;
    if (d.items.isEmpty) _fixAfterDel(d);
    return true;
  }

  void traverse(void func(List<E> items)) {
    if (!isEmpty) _traverse(_root!, func);
  }

  void _fixAfterIns(QuaterNode<E>? c) {
    while (c != null && c.isOverflow) {
      var t = _split(c);
      c = t.parent != null ? _absorb(t) : null;
    }
  }

  QuaterNode<E> _split(QuaterNode<E> c) {
    var mid = c.size ~/ 2,
        l = QuaterNode._internal(c.items.sublist(0, mid)),
        nc = QuaterNode._internal(c.items.sublist(mid, mid + 1)),
        r = QuaterNode._internal(c.items.sublist(mid + 1));
    nc.branches.addAll([l, r]);
    l.parent = r.parent = nc;

    nc.parent = c.parent;
    if (c.parent != null) {
      var i = 0;
      while (c.parent!.branches[i] != c) i++;
      c.parent!.branches[i] = nc;
    } else {
      _root = nc;
    }
    if (c.isNotLeaf) {
      l.branches
        ..addAll(c.branches.getRange(0, mid + 1))
        ..forEach((b) => b.parent = l);
      r.branches
        ..addAll(c.branches.getRange(mid + 1, c.branches.length))
        ..forEach((b) => b.parent = r);
    }
    return nc;
  }

  QuaterNode<E> _absorb(QuaterNode<E> c) {
    var i = 0, p = c.parent;
    while (p!.branches[i] != c) i++;
    p.items.insertAll(i, c.items);
    p.branches.replaceRange(i, i + 1, c.branches);
    c.branches.forEach((b) => b.parent = p);
    return p;
  }

  QuaterNode<E> _successor(QuaterNode<E> p) {
    while (p.isNotLeaf) p = p.branches[0];
    return p;
  }

  void _fixAfterDel(QuaterNode<E> d) {
    if (d == root) {
      _root = null;
    } else {
      var ct = 0;
      while (d.size < (1 << ct + 1) - 1 && d.parent != null) {
        _collapse(d.parent!);
        d = d.parent!;
        ct++;
      }
      // if (d.size < (1 << ct + 1) - 1) ct--;
      if (d == root) ct--;
      var rest = _prune(d, (1 << ct + 1) - 1);
      _expand(d, ct);
      for (var e in rest) insert(e);
    }
  }

  void _collapse(QuaterNode<E> p) {
    if (p.isLeaf) return;
    for (var i = p.branches.length - 1; i >= 0; i--) {
      _collapse(p.branches[i]);
      p.items.insertAll(i, p.branches[i].items);
    }
    p.branches.clear();
  }

  List<E> _prune(QuaterNode<E> d, int least) {
    var t = d.size ~/ least, rest = <E>[];
    if (t < 2) {
      rest.addAll(d.items.getRange(least, d.size));
      d.items.removeRange(least, d.size);
    } else {
      var list = <E>[];
      for (var i = 0; i < d.size; i++) {
        if (i % t == 0 && list.length < least)
          list.add(d.items[i]);
        else
          rest.add(d.items[i]);
      }
      d.items = list;
    }
    _elementsCount -= rest.length;
    return rest;
  }

  void _expand(QuaterNode<E> p, int ct) {
    if (ct == 0) return;
    p = _split(p);
    for (var b in p.branches) _expand(b, ct - 1);
  }

  void _traverse(QuaterNode<E> r, void f(List<E> items)) {
    f(r.items);
    for (var b in r.branches) _traverse(b, f);
  }
}

class QuaterNode<E extends Comparable<E>> {
  static final int capacity = 3;
  List<E> items;
  List<QuaterNode<E>> branches;
  QuaterNode<E>? parent;

  factory QuaterNode(List<E> elements) {
    if (elements.length > capacity) throw StateError('too many elements.');
    return QuaterNode._internal(elements);
  }

  QuaterNode._internal(List<E> elements)
      : items = [],
        branches = [] {
    items.addAll(elements);
  }

  int get size => items.length;
  bool get isOverflow => size > capacity;
  bool get isLeaf => branches.isEmpty;
  bool get isNotLeaf => !isLeaf;

  bool contains(E value) => items.contains(value);
  int find(E value) => items.indexOf(value);

  String toString() => items.toString();
}
