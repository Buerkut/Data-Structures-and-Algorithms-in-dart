/// based on fixed-length list.

class OrderedArray<E extends Comparable> {
  final List<E?> _array;
  int _nElements;

  OrderedArray(int length)
      : _array = List.filled(length, null),
        _nElements = 0;

  String get content {
    var sb = StringBuffer();
    sb.write('[');
    if (_nElements > 0) {
      for (var i = 0; i < _nElements - 1; i++) sb.write('${_array[i]}, ');
      sb.write('${_array[_nElements - 1]}');
    }
    sb.write(']');
    return sb.toString();
  }

  int get length => _array.length;
  int get nElements => _nElements;

  bool delete(E value) {
    var pos = find(value);
    if (pos >= 0) {
      for (var i = pos; i < _nElements - 1; i++) {
        _array[i] = _array[i + 1];
      }
      _nElements--;
      return true;
    }
    return false;
  }

  int find(E value) {
    int lower = 0, upper = _nElements - 1, mid;
    while (lower <= upper) {
      mid = (lower + upper) ~/ 2;
      if (_array[mid]?.compareTo(value) == 0) {
        return mid;
      } else if ((_array[mid]?.compareTo(value))! > 0) {
        upper = mid - 1;
      } else {
        lower = mid + 1;
      }
    }
    return -1;
  }

  void insert(E value) {
    if (_nElements == _array.length) throw ArrayFullException();

    int i = 0;
    while (i < _nElements && (_array[i]?.compareTo(value))! < 0) i++;
    for (var j = _nElements; j > i; j--) _array[j] = _array[j - 1];
    _array[i] = value;
    _nElements++;
  }

  E? operator [](int index) {
    if (index < 0 || index > length - 1) throw RangeError('out of range');
    return _array[index];
  }
}

class ArrayFullException implements Exception {
  const ArrayFullException();
  String toString() => 'ArrayFullException';
}
