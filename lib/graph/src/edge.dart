class Edge extends Comparable<Edge> {
  int from;
  int to;
  double weight;
  Edge(this.from, this.to, [this.weight = 0]);

  int compareTo(Edge other) {
    if (this.weight < other.weight)
      return -1;
    else if (this.weight > other.weight)
      return 1;
    else
      return 0;
  }
}
