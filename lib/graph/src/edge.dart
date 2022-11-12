class Edge implements Comparable<Edge> {
  final int v;
  final int w;
  final double weight;
  Edge(this.v, this.w, [this.weight = 0]);

  int either() => v;

  int other(int vertex) => vertex == v ? w : v;

  @override
  int compareTo(Edge other) {
    if (this.weight < other.weight)
      return -1;
    else if (this.weight > other.weight)
      return 1;
    else
      return 0;
  }

  @override
  String toString() => '$v->$w, wt = $weight';
}
