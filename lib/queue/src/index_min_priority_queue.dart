class IndexMinPriorityQueue<E extends Comparable<E>> {
  late List<E?> _items;
  late List<int> _pq, _qp;
  int _size = 0;

  IndexMinPriorityQueue(int capacity) {
    _items = List.filled(capacity + 1, null);
    _pq = List.filled(capacity + 1, -1);
    _qp = List.filled(capacity + 1, -1);
  }

  int get size => _size;

  bool get isEmpty => _size == 0;

  int get minIndex => _pq[1];

  bool contains(int k) => _qp[k] != -1;

  void insert(int k, E e) {
    if (contains(k)) throw StateError('index already exist.');
    // _size++;
    _items[k] = e;
    _pq[++_size] = k;
    _qp[k] = _size;
    _swim(_size);
  }

  int delMin() {
    var mi = _pq[1];
    _exch(1, _size);
    _qp[_pq[_size]] = -1;
    _pq[_size--] = -1;
    _items[mi] = null;
    // _size--;
    _sink(1);
    return mi;
  }

  void delete(int i) {
    var k = _qp[i];
    _exch(k, _size);
    // _qp[_pq[_size]] = -1;
    _qp[i] = -1;
    _pq[_size--] = -1;
    _items[i] = null;
    // _size--;
    _sink(k);
    _swim(k);
  }

  void changeItem(int i, E e) {
    _items[i] = e;
    var k = _qp[i];
    _sink(k);
    _swim(k);
  }

  bool _less(int i, int j) => _items[_pq[i]]!.compareTo(_items[_pq[j]]!) < 0;

  void _exch(int i, int j) {
    int t = _pq[i];
    _pq[i] = _pq[j];
    _pq[j] = t;

    _qp[_pq[i]] = i;
    _qp[_pq[j]] = j;
  }

  void _swim(int k) {
    while (k > 1) {
      if (_less(k, k >> 1)) {
        _exch(k, k >> 1);
      } else {
        break;
      }
      k = k >> 1;
    }
  }

  void _sink(int k) {
    while (k << 1 <= _size) {
      var mi;
      if ((k << 1) + 1 <= _size && _less((k << 1) + 1, k << 1)) {
        mi = (k << 1) + 1;
      } else {
        mi = k << 1;
      }
      if (_less(k, mi)) break;
      _exch(k, mi);
      k = mi;
    }
  }
}
