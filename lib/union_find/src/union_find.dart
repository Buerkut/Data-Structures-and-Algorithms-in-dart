class UnionFind {
  List _eleAndGroup;

  final int groupCount;

  UnionFind(this.groupCount)
      : _eleAndGroup = List.generate(groupCount, (i) => i);
}
