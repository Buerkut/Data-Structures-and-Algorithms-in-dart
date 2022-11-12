class DirectedEdge implements Comparable<DirectedEdge> {
  final int from;
  final int to;
  final double weight;
  DirectedEdge(this.from, this.to, [this.weight = 0]);

  @override
  int compareTo(DirectedEdge other) {
    if (this.weight < other.weight)
      return -1;
    else if (this.weight > other.weight)
      return 1;
    else
      return 0;
  }

  @override
  String toString() => '$from->$to, wt = $weight';
}
