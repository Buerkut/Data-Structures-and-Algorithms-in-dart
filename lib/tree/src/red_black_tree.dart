import 'tree_node.dart';
import 'tree_exception.dart';
import 'traverse_order.dart';

class RBTree<E extends Comparable<E>> {
  RBTNode<E> _root;
  int _nodeNumbers;

  RBTree() : _nodeNumbers = 0;

  factory RBTree.of(Iterable<Comparable<E>> elements) {
    var tree = RBTree<E>();
    for (var e in elements) tree.insert(e);
    return tree;
  }

  bool get isEmpty => _root == null;
  int get nodeNumbers => _nodeNumbers;
  RBTNode<E> get root => _root;

  void clear() {
    _root = null;
    _nodeNumbers = 0;
  }

  bool contains(E value) => find(value) != null;

  bool delete(E value) => _delete(value, _fixAfterDelete);

  // the implement in Linux core.
  bool quickDelete(E value) => _delete(value, _fixAfterDelete2);

  RBTNode<E> find(E value) {
    var current = _root;
    while (current != null) {
      var c = value.compareTo(current.value);
      if (c == 0) break;
      current = c < 0 ? current.left : current.right;
    }
    return current;
  }

  void insert(E value) {
    var inserted = RBTNode<E>(value);
    _insert(inserted);
    _fixAfterInsert(inserted);
  }

  E get max {
    if (isEmpty) throw TreeEmptyException();
    var maxNode = _root;
    while (maxNode.right != null) maxNode = maxNode.right;
    return maxNode.value;
  }

  E get min {
    if (isEmpty) throw TreeEmptyException();
    return _minNode(_root).value;
  }

  void traverse(void f(E e), [TraverseOrder order = TraverseOrder.inOrder]) =>
      _traverse(_root, order, f);

  void _insert(RBTNode<E> inserted) {
    RBTNode<E> p, c = _root;
    while (c != null) {
      p = c;
      c = inserted.value.compareTo(c.value) <= 0 ? c.left : c.right;
    }

    if (p == null) {
      _root = inserted;
    } else if (inserted.value.compareTo(p.value) <= 0) {
      p.left = inserted;
    } else {
      p.right = inserted;
    }
    inserted.parent = p;
    _nodeNumbers++;
  }

  void _fixAfterInsert(RBTNode<E> node) {
    while (_hasRedFather(node) && _hasRedUncle(node)) {
      var g = _gparent(node);
      g.left.paintBlack();
      g.right.paintBlack();
      g.paintRed();
      node = g;
    }

    if (_hasRedFather(node)) {
      var g = _gparent(node);
      if (node.parent == g.left) {
        if (node == node.parent.right) {
          _rotateLeft(node.parent);
          node = node.left;
        }
        _rotateRight(g);
      } else {
        if (node == node.parent.left) {
          _rotateRight(node.parent);
          node = node.right;
        }
        _rotateLeft(g);
      }
      node.parent.paintBlack();
      g.paintRed();
    }
    _root.paintBlack();
  }

  bool _hasRedFather(RBTNode<E> node) =>
      node.parent != null && node.parent.isRed;

  bool _hasRedUncle(RBTNode<E> node) {
    var gparent = _gparent(node);
    var uncle = node.parent == gparent.left ? gparent.right : gparent.left;
    return uncle != null && uncle.isRed;
  }

  RBTNode _gparent(RBTNode<E> node) => node.parent.parent;

  bool _delete(E value, void _fix(RBTNode<E> p, bool isLeft)) {
    var d = find(value);
    if (d == null) return false;

    if (d.left != null && d.right != null) {
      var s = _successor(d);
      d.value = s.value;
      d = s;
    }
    var rp = d.left ?? d.right;
    rp?.parent = d.parent;
    if (d.parent == null)
      _root = rp;
    else if (d == d.parent.left)
      d.parent.left = rp;
    else
      d.parent.right = rp;

    if (rp != null)
      rp.paintBlack();
    else if (d.isBlack && d.parent != null)
      _fix(d.parent, d.parent.left == null);

    _nodeNumbers--;
    return true;
  }

  RBTNode<E> _successor(RBTNode<E> d) =>
      d.right != null ? _minNode(d.right) : d.left;

  void _fixAfterDelete(RBTNode<E> p, bool isLeft) {
    var c = isLeft ? p.right : p.left;
    if (isLeft) {
      if (c.isRed) {
        p.paintRed();
        c.paintBlack();
        _rotateLeft(p);
        c = p.right;
      }
      if (c.left != null && c.left.isRed) {
        c.left.paint(p.color);
        if (p.isRed) p.paintBlack();
        _rotateRight(c);
        _rotateLeft(p);
      } else {
        _rotateLeft(p);
        if (p.isBlack) {
          p.paintRed();
          if (c.parent != null) _fixAfterDelete(c.parent, c == c.parent.left);
        }
      }
    } else {
      if (c.isRed) {
        p.paintRed();
        c.paintBlack();
        _rotateRight(p);
        c = p.left;
      }
      if (c.right != null && c.right.isRed) {
        c.right.paint(p.color);
        if (p.isRed) p.paintBlack();
        _rotateLeft(c);
        _rotateRight(p);
      } else {
        _rotateRight(p);
        if (p.isBlack) {
          p.paintRed();
          if (c.parent != null) _fixAfterDelete(c.parent, c == c.parent.left);
        }
      }
    }
  }

  // the implement in Linux core.
  void _fixAfterDelete2(RBTNode<E> p, bool isLeft) {
    var c = isLeft ? p.right : p.left;
    if (isLeft) {
      if (c.isRed) {
        p.paintRed();
        c.paintBlack();
        _rotateLeft(p);
        c = p.right;
      }
      if ((c.left != null && c.left.isRed) ||
          (c.right != null && c.right.isRed)) {
        if (c.right == null || c.right.isBlack) {
          _rotateRight(c);
          c = p.right;
        }
        c.paint(p.color);
        p.paintBlack();
        c.right.paintBlack();
        _rotateLeft(p);
      } else {
        c.paintRed();
        if (p.isRed)
          p.paintBlack();
        else if (p.parent != null)
          _fixAfterDelete2(p.parent, p == p.parent.left);
      }
    } else {
      if (c.isRed) {
        p.paintRed();
        c.paintBlack();
        _rotateRight(p);
        c = p.left;
      }
      if ((c.left != null && c.left.isRed) ||
          (c.right != null && c.right.isRed)) {
        if (c.left == null || c.left.isBlack) {
          _rotateLeft(c);
          c = p.left;
        }
        c.paint(p.color);
        p.paintBlack();
        c.left.paintBlack();
        _rotateRight(p);
      } else {
        c.paintRed();
        if (p.isRed)
          p.paintBlack();
        else if (p.parent != null)
          _fixAfterDelete2(p.parent, p == p.parent.left);
      }
    }
  }

  void _rotateLeft(RBTNode<E> node) {
    var r = node.right, p = node.parent;
    r.parent = p;
    if (p == null)
      _root = r;
    else if (p.left == node)
      p.left = r;
    else
      p.right = r;

    node.right = r.left;
    r.left?.parent = node;
    r.left = node;
    node.parent = r;
  }

  void _rotateRight(RBTNode<E> node) {
    var l = node.left, p = node.parent;
    l.parent = p;
    if (p == null)
      _root = l;
    else if (p.left == node)
      p.left = l;
    else
      p.right = l;

    node.left = l.right;
    l.right?.parent = node;
    l.right = node;
    node.parent = l;
  }

  RBTNode<E> _minNode(RBTNode<E> r) => r.left == null ? r : _minNode(r.left);

  void _traverse(RBTNode<E> s, TraverseOrder order, void f(E e)) {
    if (s == null) return;
    switch (order) {
      case TraverseOrder.inOrder:
        _traverse(s.left, order, f);
        f(s.value);
        _traverse(s.right, order, f);
        break;
      case TraverseOrder.preOrder:
        f(s.value);
        _traverse(s.left, order, f);
        _traverse(s.right, order, f);
        break;
      case TraverseOrder.postOrder:
        _traverse(s.left, order, f);
        _traverse(s.right, order, f);
        f(s.value);
        break;
      default:
        break;
    }
  }
}
