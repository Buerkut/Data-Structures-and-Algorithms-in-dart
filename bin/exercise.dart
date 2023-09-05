void main() {
  var a = [0, 0, 2, 1];
  var s = 0, t = a.length;
  for (var i = 0; i < a.length; i++) {
    if (a[i] > 0) {
      s = i;
      break;
    }
  }
  for (var i = a.length - 1; i >= 0; i--) {
    if (a[i] >= 0) {
      t = i + 1;
      break;
    }
  }
  print((s, t));
  s = a.indexWhere((_) => _ > 0);
  t = a.indexWhere((_) => _ < 0);
  if (t == -1) t = a.length;
  print((s, t));
}
