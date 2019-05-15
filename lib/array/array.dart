/// A simple array based on fixed-length list.

class Array<E> {
  final List<E> _array;

  Array(int length) : _array = List<E>(length);

  int get length => _array.length;

  // another much simpler implements is:
  // int find(E value) => _array.indexOf(value);
  int find(E value) {
    for (var i = 0; i < _array.length; i++) {
      if (_array[i] == value) return i;
    }
    return -1;
  }

  String toString() => _array.toString();

  E operator [](int index) => _array[index];

  void operator []=(int index, E value) => _array[index] = value;
}
