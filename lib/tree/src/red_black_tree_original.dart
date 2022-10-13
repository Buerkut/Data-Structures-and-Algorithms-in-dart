import 'tree_node.dart';
import 'tree_exception.dart';
import 'traverse_order.dart';

class RBTree<E extends Comparable<E>> {
  RBTNode<E>? _root;
  int _nodeNumbers;

  RBTree() : _nodeNumbers = 0;

  factory RBTree.from(Iterable<E> elements) {
    var tree = RBTree<E>();
    for (var e in elements) tree.insert(e);
    return tree;
  }

  bool get isEmpty => _root == null;
  int get nodeNumbers => _nodeNumbers;
  RBTNode<E>? get root => _root;

  void clear() {
    _root = null;
    _nodeNumbers = 0;
  }

  bool contains(E value) => find(value) != null;

  bool delete(E value) {
    var node = find(value);
    if (node == null) return false;
    _delete(node);
    _nodeNumbers--;
    return true;
  }

  void _delete(RBTNode<E> d) {
    // RBTNode<E>? d = dd;
    if (d.left != null && d.right != null) {
      var s = _successor(d);
      d.value = s.value;
      d = s;
    }
    var rp = d.left ?? d.right;
    rp?.parent = d.parent;
    if (d.parent == null)
      _root = rp;
    else if (d == d.parent!.left)
      d.parent!.left = rp;
    else
      d.parent!.right = rp;

    if (rp != null)
      rp.paintBlack();
    else if (d.isBlack && d.parent != null)
      // _fixAfterDelete(d.parent, _d(d.parent, null));
      // _fixAfterDelete2(d.parent, _d(d.parent, null));
      fixAfterDelete3(d.parent!, d.parent!.left == null);
  }

  RBTNode<E> _successor(RBTNode<E> d) =>
      d.right != null ? _minNode(d.right!) : d.left!;

  // 最初最原始的算法
  void fixAfterDelete1(RBTNode<E> p, _Direction direction) {
    if (direction == _Direction.left) {
      var sib = p.right;
      if (sib!.isRed) {
        var l = sib.left;
        sib.paintBlack();
        if (l!.right != null) {
          l.paintRed();
          l.right!.paintBlack();
          _rotateLeft(p);
        } else if (l.left != null) {
          _rotateRight(l);
          _rotateLeft(p);
        } else {
          l.paintRed();
        }
        _rotateLeft(p);
      } else {
        if (p.isRed) {
          if (sib.right != null) {
            p.paintBlack();
            sib.paintRed();
            sib.right!.paintBlack();
          } else if (sib.left != null) {
            p.paintBlack();
            _rotateRight(sib);
          }
          _rotateLeft(p);
        } else {
          if (sib.right != null && sib.right!.isRed) {
            sib.right!.paintBlack();
            _rotateLeft(p);
          } else if (sib.left != null && sib.left!.isRed) {
            sib.left!.paintBlack();
            _rotateRight(sib);
            _rotateLeft(p);
          } else {
            p.paintRed();
            _rotateLeft(p);
            p = p.parent!;
            if (p.parent != null) {
              var dr = p == p.parent!.left ? _Direction.left : _Direction.right;
              fixAfterDelete1(p.parent!, dr);
            }
          }
        }
      }
    } else {
      // symmetric
      var sib = p.left;
      if (sib!.isRed) {
        var r = sib.right;
        sib.paintBlack();
        if (r!.left != null) {
          r.paintRed();
          r.left!.paintBlack();
          _rotateRight(p);
        } else if (r.right != null) {
          _rotateLeft(r);
          _rotateRight(p);
        } else {
          r.paintRed();
        }
        _rotateRight(p);
      } else {
        if (p.isRed) {
          if (sib.left != null) {
            p.paintBlack();
            sib.paintRed();
            sib.left!.paintBlack();
          } else if (sib.right != null) {
            p.paintBlack();
            _rotateLeft(sib);
          }
          _rotateRight(p);
        } else {
          if (sib.left != null && sib.left!.isRed) {
            sib.left!.paintBlack();
            _rotateRight(p);
          } else if (sib.right != null && sib.right!.isRed) {
            sib.right!.paintBlack();
            _rotateLeft(sib);
            _rotateRight(p);
          } else {
            p.paintRed();
            _rotateRight(p);
            p = p.parent!;
            if (p.parent != null) {
              var dr = p == p.parent!.left ? _Direction.left : _Direction.right;
              fixAfterDelete1(p.parent!, dr);
            }
          }
        }
      }
    }
  }

  // 更精简的算法1
  void fixAfterDelete2(RBTNode<E> p, _Direction di) {
    var child = di == _Direction.left ? p.right : p.left;
    if (di == _Direction.left) {
      if (p.isRed) {
        if (child!.left != null) {
          p.paintBlack();
          _rotateRight(child);
        }
        _rotateLeft(p);
      } else if (child!.isRed) {
        child.paintBlack();
        _rotateLeft(p);
        _rotateLeft(p);
        if (p.right != null) {
          _rotateLeft(p);
          _rotateRight(p.parent!.parent!);
        } else
          p.paintRed();
      } else if (child.right != null && child.right!.isRed) {
        child.right!.paintBlack();
        _rotateLeft(p);
      } else if (child.left != null && child.left!.isRed) {
        child.left!.paintBlack();
        _rotateRight(child);
        _rotateLeft(p);
      } else {
        child.paintRed();
        if (p.parent != null) fixAfterDelete2(p.parent!, _d(p.parent!, p));
      }
    } else {
      // symmetric
      if (p.isRed) {
        if (child!.right != null) {
          p.paintBlack();
          _rotateLeft(child);
        }
        _rotateRight(p);
      } else if (child!.isRed) {
        child.paintBlack();
        _rotateRight(p);
        _rotateRight(p);
        if (p.left != null) {
          _rotateRight(p);
          _rotateLeft(p.parent!.parent!);
        } else
          p.paintRed();
      } else if (child.left != null && child.left!.isRed) {
        child.left!.paintBlack();
        _rotateRight(p);
      } else if (child.right != null && child.right!.isRed) {
        child.right!.paintBlack();
        _rotateLeft(child);
        _rotateRight(p);
      } else {
        child.paintRed();
        if (p.parent != null) fixAfterDelete2(p.parent!, _d(p.parent!, p));
      }
    }
  }

  // 更精简的算法2
  void fixAfterDelete3(RBTNode<E> p, bool isLeft) {
    var ch = isLeft ? p.right : p.left;
    if (isLeft) {
      if (p.isRed) {
        if (ch!.left != null && ch.left!.isRed) {
          p.paintBlack();
          _rotateRight(ch);
        }
        _rotateLeft(p);
      } else if (ch!.isRed) {
        p.paintRed();
        ch.paintBlack();
        _rotateLeft(p);
        fixAfterDelete3(p, true);
      } else if (ch.left != null && ch.left!.isRed) {
        ch.left!.paintBlack();
        _rotateRight(ch);
        _rotateLeft(p);
      } else {
        p.paintRed();
        _rotateLeft(p);
        if (ch.parent != null)
          fixAfterDelete3(ch.parent!, ch == ch.parent!.left);
      }
    } else {
      // symmetric
      if (p.isRed) {
        if (ch!.right != null && ch.right!.isRed) {
          p.paintBlack();
          _rotateLeft(ch);
        }
        _rotateRight(p);
      } else if (ch!.isRed) {
        p.paintRed();
        ch.paintBlack();
        _rotateRight(p);
        fixAfterDelete3(p, false);
      } else if (ch.right != null && ch.right!.isRed) {
        ch.right!.paintBlack();
        _rotateLeft(ch);
        _rotateRight(p);
      } else {
        p.paintRed();
        _rotateRight(p);
        if (ch.parent != null)
          fixAfterDelete3(ch.parent!, ch == ch.parent!.left);
      }
    }
  }

  _Direction _d(RBTNode<E> p, RBTNode<E> c) =>
      p.left == c ? _Direction.left : _Direction.right;

  RBTNode<E>? find(E value) {
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
    while (maxNode!.right != null) maxNode = maxNode.right;
    return maxNode.value;
  }

  E get min {
    if (isEmpty) throw TreeEmptyException();
    return _minNode(_root!).value;
  }

  void traverse(void func(E value), [TraverseOrder? order]) {
    _traverse(_root, order, func);
  }

  void _insert(RBTNode<E> inserted) {
    RBTNode<E>? p, c = _root;
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

  // 我自己的写法 // Buerkut
  void _fixAfterInsert(RBTNode<E> node) {
    while (_hasRedFather(node) && _hasRedUncle(node)) {
      var g = _gparent(node);
      g.left!.paintBlack();
      g.right!.paintBlack();
      g.paintRed();
      node = g;
    }

    if (_hasRedFather(node)) {
      var g = _gparent(node);
      if (node.parent == g.left) {
        if (node == node.parent!.right) {
          _rotateLeft(node.parent!);
          node = node.left!;
        }
        _rotateRight(g);
      } else {
        if (node == node.parent!.left) {
          _rotateRight(node.parent!);
          node = node.right!;
        }
        _rotateLeft(g);
      }
      node.parent!.paintBlack();
      g.paintRed();
    }
    _root!.paintBlack();
  }

  bool _hasRedFather(RBTNode<E> node) =>
      node.parent != null && node.parent!.isRed;

  bool _hasRedUncle(RBTNode<E> node) {
    var gparent = _gparent(node);
    var uncle = node.parent == gparent.left ? gparent.right : gparent.left;
    return uncle != null && uncle.isRed;
  }

  RBTNode<E> _gparent(RBTNode<E> node) => node.parent!.parent!;

  // 这是教科书及Linux/Java等开源软件标准的写法；
  void fixAfterInsertStandard(RBTNode<E> node) {
    while (node.parent != null && node.parent!.isRed) {
      var gparent = node.parent!.parent;
      if (node.parent == gparent!.left) {
        if (gparent.right != null && gparent.right!.isRed) {
          node.parent!.paintBlack();
          gparent.right!.paintBlack();
          gparent.paintRed();
          node = gparent;
        } else {
          if (node == node.parent!.right) {
            node = node.parent!;
            _rotateLeft(node);
          }
          node.parent!.paintBlack();
          gparent.paintRed();
          _rotateRight(gparent);
        }
      } else {
        if (gparent.left != null && gparent.left!.isRed) {
          node.parent!.paintBlack();
          gparent.left!.paintBlack();
          gparent.paintRed();
          node = gparent;
        } else {
          if (node == node.parent!.left) {
            node = node.parent!;
            _rotateRight(node);
          }
          node.parent!.paintBlack();
          gparent.paintRed();
          _rotateLeft(gparent);
        }
      }
    }
    _root!.paintBlack();
  }

  void _rotateLeft(RBTNode<E> node) {
    var rg = node.right, p = node.parent;
    rg!.parent = p;
    if (p == null) {
      _root = rg;
    } else if (p.left == node) {
      p.left = rg;
    } else {
      p.right = rg;
    }

    node.right = rg.left;
    if (rg.left != null) rg.left!.parent = node;
    rg.left = node;
    node.parent = rg;
  }

  void _rotateRight(RBTNode<E> node) {
    var lf = node.left, p = node.parent;
    lf!.parent = p;
    if (p == null) {
      _root = lf;
    } else if (p.left == node) {
      p.left = lf;
    } else {
      p.right = lf;
    }

    node.left = lf.right;
    if (lf.right != null) lf.right!.parent = node;
    lf.right = node;
    node.parent = lf;
  }

  void _traverse(RBTNode<E>? root, TraverseOrder? order, void func(E e)) {
    if (root == null) return;
    switch (order) {
      case TraverseOrder.preOrder:
        func(root.value);
        _traverse(root.left, order, func);
        _traverse(root.right, order, func);
        break;
      case TraverseOrder.postOrder:
        _traverse(root.left, order, func);
        _traverse(root.right, order, func);
        func(root.value);
        break;
      default:
        _traverse(root.left, order, func);
        func(root.value);
        _traverse(root.right, order, func);
    }
  }

  RBTNode<E> _minNode(RBTNode<E> r) => r.left == null ? r : _minNode(r.left!);
}

enum _Direction { left, right }
