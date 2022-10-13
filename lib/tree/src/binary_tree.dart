import 'traverse_order.dart';
import 'tree_node.dart' show TNode;
import 'tree_exception.dart';

class BinaryTree<E extends Comparable<E>> {
  TNode<E>? _root;
  int _nodeNumbers;

  BinaryTree() : _nodeNumbers = 0;

  factory BinaryTree.fromIterables(Iterable<E> elements) {
    var tree = BinaryTree<E>();
    for (var e in elements) tree.insert(e);
    return tree;
  }

  bool get isEmpty => _root == null;
  int get nodeNumbers => _nodeNumbers;

  void clear() {
    _root = null;
    _nodeNumbers = 0;
  }

  bool contains(E value) => find(value) != null;

  bool delete(E value) {
    var deleted = find(value);
    if (deleted == null) return false;
    _delete(deleted);
    _nodeNumbers--;
    return true;
  }

  TNode<E>? find(E value) {
    var current = _root;
    while (current != null) {
      var c = value.compareTo(current.value);
      if (c == 0) break;
      current = c < 0 ? current.left : current.right;
    }
    return current;
  }

  void insert(E value) {
    TNode<E>? p, c = _root;
    while (c != null) {
      p = c;
      c = value.compareTo(c.value) <= 0 ? c.left : c.right;
    }
    var inserted = TNode(value);
    if (p != null) {
      if (value.compareTo(p.value) <= 0) {
        p.left = inserted;
      } else {
        p.right = inserted;
      }
      inserted.parent = p;
    } else {
      _root = inserted;
    }
    _nodeNumbers++;
  }

  void traverse(void func(E value), [TraverseOrder? order]) {
    _traverse(_root, order, func);
  }

  E get max {
    if (isEmpty) throw TreeEmptyException();
    var maxNode = _root;
    while (maxNode!.right != null) maxNode = maxNode.right;
    return maxNode.value;
  }

  E get min {
    if (isEmpty) throw TreeEmptyException();
    return _minNode(_root).value;
  }

  TNode<E> _minNode(TNode<E>? r) {
    while (r!.left != null) r = r.left;
    return r;
  }

  void _delete(TNode<E> deleted) {
    var successor = _successor(deleted);
    if (successor != null) _delete(successor);
    if (deleted == _root) _root = successor;
    _replace(deleted, successor);
  }

  static void _replace<E>(TNode<E> deleted, TNode<E>? successor) {
    if (deleted.parent != null) {
      if (deleted.parent!.left == deleted)
        deleted.parent!.left = successor;
      else
        deleted.parent!.right = successor;
    }

    if (successor != null) {
      successor.parent = deleted.parent;
      successor.left = deleted.left;
      successor.right = deleted.right;
      deleted.left?.parent = successor;
      deleted.right?.parent = successor;
    }
  }

  TNode<E>? _successor(TNode<E> node) =>
      node.right != null ? _minNode(node.right) : node.left;

  static void _traverse<E>(
      TNode<E>? root, TraverseOrder? order, void func(E e)) {
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
}
