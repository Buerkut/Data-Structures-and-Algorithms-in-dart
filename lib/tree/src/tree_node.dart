class TNode<E> {
  E value;
  TNode<E>? left, right, parent;

  TNode(this.value);
}

class RBTNode<E extends Comparable<E>> {
  E value;
  RBTNode<E>? left, right, parent;
  _RBTNodeColor _color;

  RBTNode(this.value) : _color = _RBTNodeColor.red;

  _RBTNodeColor get color => _color;
  bool get isRed => _color == _RBTNodeColor.red;
  bool get isBlack => _color == _RBTNodeColor.black;
  void paint(_RBTNodeColor color) => _color = color;
  void paintRed() => paint(_RBTNodeColor.red);
  void paintBlack() => paint(_RBTNodeColor.black);
}

enum _RBTNodeColor { red, black }
