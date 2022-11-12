class UnionFind {
  List<int> _eleAndGroup;
  int _groupCount;

  UnionFind(this._groupCount)
      : _eleAndGroup = List.generate(_groupCount, (i) => i);

  int get groupCount => _groupCount;

  int find(int p) => _eleAndGroup[p];

  bool connected(int p, int q) => _eleAndGroup[p] == _eleAndGroup[q];

  void union(int p, int q) {
    if (connected(p, q)) return;

    var pg = find(p);
    var qg = find(q);
    for (var i = 0; i < _eleAndGroup.length; i++) {
      if (_eleAndGroup[i] == pg) _eleAndGroup[i] = qg;
    }
    _groupCount--;
  }
}

class UnionFindTree {
  List<int> _eleAndGroup;
  int _groupCount;
  List<int> _sz;

  UnionFindTree(this._groupCount)
      : _eleAndGroup = List.generate(_groupCount, (i) => i),
        _sz = List.generate(_groupCount, (_) => 1);

  int get groupCount => _groupCount;

  bool connected(int p, int q) => find(p) == find(q);

  int find(int p) {
    while (true) {
      if (p == _eleAndGroup[p]) return p;

      p = _eleAndGroup[p];
    }
  }

  void union(int p, int q) {
    var pRoot = find(p);
    var qRoot = find(q);
    if (pRoot == qRoot) return;

    if (_sz[pRoot] < _sz[qRoot]) {
      _eleAndGroup[pRoot] = qRoot;
      _sz[qRoot] += _sz[pRoot];
    } else {
      _eleAndGroup[qRoot] = pRoot;
      _sz[pRoot] += _sz[qRoot];
    }

    _groupCount--;
  }
}
