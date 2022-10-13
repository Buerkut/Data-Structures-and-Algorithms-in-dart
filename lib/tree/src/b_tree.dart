class BTree<E extends Comparable<E>> {
  final int order;
  BTreeNode<E>? _root;
  int _elemCount;

  factory BTree.of(Iterable<E> elements, int order) {
    var tree = BTree<E>(order);
    for (var e in elements) tree.insert(e);
    return tree;
  }

  BTree(this.order) : _elemCount = 0 {
    if (order < 3) throw StateError('too little order!');
  }

  int get elemCount => _elemCount;
  BTreeNode<E>? get root => _root;

  int get height {
    var h = 0, c = root;
    while (c != null) {
      h++;
      c = c.isNotLeaf ? c.branches[0] : null;
    }
    return h;
  }

  bool get isEmpty => root == null;

  bool contains(E value) => find(value) != null;

  BTreeNode<E>? find(E value) {
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
      while (i < c.size && c.items[i].compareTo(value) < 0) i++;
      if (i < c.size && c.items[i] == value) return;
      if (c.isLeaf) break;
      c = c.branches[i];
      i = 0;
    }
    if (c != null) {
      c.items.insert(i, value);
      if (_isOverflow(c)) _fixAfterIns(c);
    } else {
      _root = BTreeNode(value);
    }
    _elemCount++;
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
    _elemCount--;
    _fixAfterDel(d);
    return true;
  }

  void traverse(void func(List<E> items)) {
    if (!isEmpty) _traverse(_root!, func);
  }

  void _fixAfterIns(BTreeNode<E>? c) {
    while (c != null && _isOverflow(c)) {
      var t = _split(c);
      c = t.parent != null ? _absorb(t) : null;
    }
  }

  bool _isOverflow(BTreeNode<E> c) => c.size > order - 1;

  BTreeNode<E> _split(BTreeNode<E> c) {
    var mid = c.size ~/ 2,
        l = BTreeNode._internal(c.items.sublist(0, mid)),
        nc = BTreeNode._internal(c.items.sublist(mid, mid + 1)),
        r = BTreeNode._internal(c.items.sublist(mid + 1));
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

  BTreeNode<E> _absorb(BTreeNode<E> c) {
    var i = 0, p = c.parent;
    while (p!.branches[i] != c) i++;
    p.items.insertAll(i, c.items);
    p.branches.replaceRange(i, i + 1, c.branches);
    c.branches.forEach((b) => b.parent = p);
    return p;
  }

  BTreeNode<E> _successor(BTreeNode<E> p) {
    while (p.isNotLeaf) p = p.branches[0];
    return p;
  }

  void _fixAfterDel(BTreeNode<E> d) {
    if (d.size >= (order / 2).ceil() - 1) return;
    if (d == root) {
      if (root!.items.isEmpty) {
        if (root!.isLeaf) {
          _root = null;
        } else {
          _root = root!.branches[0];
          _root!.parent = null;
        }
      }
    } else {
      var i = 0;
      while (d.parent!.branches[i] != d) i++;
      if (i > 0) {
        if (_isRich(d.parent!.branches[i - 1])) {
          _rotateRight(d.parent!, i);
        } else if (i < d.parent!.branches.length - 1 &&
            _isRich(d.parent!.branches[i + 1])) {
          _rotateLeft(d.parent!, i);
        } else {
          _mergeIntoLeft(d, i);
          _fixAfterDel(d.parent!);
        }
      } else if (_isRich(d.parent!.branches[i + 1])) {
        _rotateLeft(d.parent!, i);
      } else {
        _mergeIntoLeft(d.parent!.branches[i + 1], i + 1);
        _fixAfterDel(d.parent!);
      }
    }
  }

  bool _isRich(BTreeNode<E> c) => c.size > (order / 2).ceil() - 1;

  void _rotateLeft(BTreeNode<E> p, int i) {
    var lb = p.branches[i], rb = p.branches[i + 1];
    lb.items.add(p.items[i]);
    p.items[i] = rb.items.removeAt(0);
    if (lb.isNotLeaf) {
      lb.branches.add(rb.branches.removeAt(0));
      lb.branches.last.parent = lb;
    }
  }

  void _rotateRight(BTreeNode<E> p, int i) {
    var lb = p.branches[i - 1], rb = p.branches[i];
    rb.items.insert(0, p.items[i - 1]);
    p.items[i - 1] = lb.items.removeLast();
    if (rb.isNotLeaf) {
      rb.branches.insert(0, lb.branches.removeLast());
      rb.branches.first.parent = rb;
    }
  }

  void _mergeIntoLeft(BTreeNode<E> c, int i) {
    var leftSib = c.parent!.branches[i - 1];
    leftSib.items
      ..add(c.parent!.items.removeAt(i - 1))
      ..addAll(c.items);
    leftSib.branches.addAll(c.branches);
    c.branches.forEach((b) => b.parent = leftSib);
    c.parent!.branches.removeAt(i);
  }

  void _traverse(BTreeNode<E> r, void f(List<E> items)) {
    f(r.items);
    for (var b in r.branches) _traverse(b, f);
  }
}

class BTreeNode<E extends Comparable<E>> {
  static final int capacity = 2;
  List<E> items;
  List<BTreeNode<E>> branches;
  BTreeNode<E>? parent;

  BTreeNode(E value)
      : items = [],
        branches = [] {
    items.add(value);
  }

  BTreeNode._internal(List<E> elements)
      : items = [],
        branches = [] {
    items.addAll(elements);
  }

  int get size => items.length;
  bool get isLeaf => branches.isEmpty;
  bool get isNotLeaf => !isLeaf;

  bool contains(E value) => items.contains(value);
  int find(E value) => items.indexOf(value);

  String toString() => items.toString();
}
