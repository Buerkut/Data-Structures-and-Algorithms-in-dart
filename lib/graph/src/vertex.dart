class Vertex {
  String label;
  bool wasVisited = false;

  Vertex(this.label);

  @override
  String toString() => label;
}
