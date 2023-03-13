bool checkSum(List<int> a, int s) {
  for (var i = 0; i < a.length - 1; i++) {
    for (var j = i + 1; j < a.length; j++) {
      if (a[i] + a[j] == s) return true;
    }
  }
  return false;
}

List<int>? twoSum(List<int> a, int s) {
  var map = <int, int>{};
  for (var i = 0; i < a.length; i++) {
    var r = s - a[i];
    if (map.containsKey(r)) {
      return [map[r]!, i];
    }

    map[a[i]] = i;
  }
  return null;
}
