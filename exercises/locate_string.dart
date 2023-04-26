void main() {
  var ss = 'art';
  var src = 'bacarito';
  var src2 = 'aferot';
  var l = locate(ss, src);
  print('location 1: $l');
  l = locate2(ss, src);
  print('location 2: $l');
  l = locate3(ss, src);
  print('location 3: $l');
  l = locate4(ss, src);
  print('location 4: $l');
  l = locate5(ss, src);
  print('location 5: $l');
  l = locate6(ss, src);
  print('location 6: $l');

  l = locate(ss, src2);
  print('ss in src 2: $l');
  var ll = locate7(ss, src, src2);
  print(ll);
  var lll = locate8(ss, src, src2);
  print(lll);
}

List<int> locate(String ss, String src) {
  var l = List.filled(ss.length, -1);
  for (var c = 0, i = 0; c < ss.length && i < src.length; i++) {
    if (src[i] == ss[c]) l[c++] = i;
  }
  return l;
}

List<int> locate2(String ss, String src) {
  var c = 0, l = <int>[];
  outerloop:
  for (var i = 0; i < ss.length; i++) {
    for (var j = c; j < src.length; j++) {
      if (ss[i] == src[j]) {
        l.add(j);
        c = j + 1;
        continue outerloop;
      }
    }
  }
  return l;
}

List<int> locate3(String ss, String src) {
  var l = <int>[];
  for (var c = 0, i = 0; c < ss.length && i < src.length; i++) {
    if (src[i] == ss[c]) {
      l.add(i);
      c++;
    }
  }
  return l;
}

List<int> locate4(String ss, String src) {
  var c = 0, i = 0, l = List.filled(ss.length, -1);
  while (c < ss.length && i < src.length) {
    if (src[i++] == ss[c]) l[c++] = i - 1;
  }
  return l;
}

List<int> locate5(String ss, String src) {
  var l = <int>[];
  for (var c = 0, i = 0; c < ss.length; c++) {
    while (i < src.length && src[i] != ss[c]) i++;
    l.add(i++);
  }
  return l;
}

List<int> locate6(String ss, String src) {
  var l = List.filled(ss.length, -1);
  for (var c = 0, i = 0; c < ss.length; c++) {
    while (i < src.length && src[i] != ss[c]) i++;
    l[c] = i++;
  }
  return l;
}

List<List<int>> locate7(String ss, String a, String b) {
  var ll = <List<int>>[];
  for (var c = 0, i = 0, j = 0; c < ss.length; c++) {
    while (i < a.length && a[i] != ss[c]) i++;
    while (j < b.length && b[j] != ss[c]) j++;
    ll.add([i++, j++]);
  }
  return ll;
}

List<List<int>?> locate8(String ss, String a, String b) {
  var ll = List<List<int>?>.filled(ss.length, null);
  for (var c = 0, i = 0, j = 0; c < ss.length; c++) {
    while (i < a.length && a[i] != ss[c]) i++;
    while (j < b.length && b[j] != ss[c]) j++;
    ll[c] = [i++, j++];
  }
  return ll;
}
