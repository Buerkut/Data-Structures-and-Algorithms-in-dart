// the longest increasing subsequence
// Refer & thanks to: https://blog.csdn.net/u012505432/article/details/52228945

void main() {
  // var a = [8, 6, 7, 5, 1, 2, 3, 8, 9, 2];
  // var a = [8, 3, 4, 7, 5, 2, 6, 1];
  var a = [10, 20, 30, 40, 1, 2, 3];
  // var a = [9];
  // var a = [1, 2, 3, 4];
  // var a = [8, 6, 7];
  // var a = <int>[];
  print(lis(a));
  print(lis2(a));
  print(lis3(a));
  print(lis4(a));
  var sq = lis5(a);
  print(sq);
  print(sq.length);
}

// consecutive in greedy algorithm. O(n).
// Return: [start, end]: start: inclusive, end: exclusive.
List<int> lis(List<int> a) {
  if (a.isEmpty) return [-1, 0];

  var p = 0, ml = 1;
  for (var i = 1; i < a.length; i++) {
    var l = 1;
    for (; i < a.length && a[i] > a[i - 1]; i++) l++;
    if (l > ml) {
      ml = l;
      p = i - l;
    }
  }

  return [p, p + ml];
}

// consecutive, O(n)
// Return: [start, end]: start: inclusive, end: exclusive.
List<int> lis2(List<int> a) {
  if (a.isEmpty) return [-1, 0];

  var q = 0, ml = 1, ll = List.filled(a.length, 1);
  for (var i = 1; i < a.length; i++) {
    if (a[i] > a[i - 1]) {
      ll[i] = ll[i - 1] + 1;
      if (ml < ll[i]) {
        ml = ll[i];
        q = i;
      }
    }
  }

  return [q - ml + 1, q + 1];
}

// consecutive, O(n*n)
// Return: [start, end]: start: inclusive, end: exclusive.
List<int> lis3(List<int> a) {
  if (a.isEmpty) return [-1, 0];

  var p = 0, ml = 1;
  for (var i = 0; i < a.length; i++) {
    var j = i + 1;
    while (j < a.length && a[j] > a[j - 1]) j++;
    if (j - i > ml) {
      ml = j - i;
      p = i;
    }
  }

  return [p, p + ml];
}

// inconsecutive, O(nlgn)
// Return: the length of lis.
int lis4(List<int> a) {
  var tails = List.filled(a.length, 0), len = 0;
  for (var x in a) {
    var i = 0, j = len;
    while (i != j) {
      var m = (i + j) >> 1;
      if (tails[m] < x) {
        i = m + 1;
      } else {
        j = m;
      }
    }
    tails[i] = x;
    if (len == i) len++;
  }

  return len;
}

// inconsecutive, O(nlgn)
// Return: the lis itself.
List<int> lis5(List<int> a) {
  var t = List.filled(a.length, 0), len = 0;
  for (var x in a) {
    var i = 0, j = len;
    while (i != j) {
      var m = (i + j) >> 1;
      if (t[m] < x) {
        i = m + 1;
      } else {
        j = m;
      }
    }
    t[i] = x;
    if (len == i) len++;
  }

  var p = len - 1, lis = List.filled(len, 0);
  for (var i = a.length - 1; i >= 0 && p >= 0; i--) {
    if (a[i] == t[p] || (a[i] > t[p] && a[i] < lis[p + 1])) lis[p--] = a[i];

    // get the index of each element in LIS.
    // if (a[i] == t[p] || (a[i] > t[p] && a[i] < lis[p + 1])) lis[p--] = i;
  }
  return lis;
}

// inconsecutive, O(nlgn)
// Return: the lis itself.
// Too many implements for getting lis itself.
// List<int> lis8(List<int> a) {
//   var t = List.filled(a.length, 0), len = 0;
//   for (var x in a) {
//     var i = 0, j = len;
//     while (i != j) {
//       var m = (i + j) >> 1;
//       if (t[m] < x) {
//         i = m + 1;
//       } else {
//         j = m;
//       }
//     }
//     t[i] = x;
//     if (i == len) len++;
//   }

//   // print('tails: $t');

//   // var t = len - 1, lis = <int>[];
//   // for (var i = a.length - 1; i >= 0 && t >= 0; i--) {
//   //   if (a[i] == tails[t]) {
//   //     lis.add(tails[t--]);
//   //   } else if (a[i] > tails[t] && a[i] < tails[t + 1]) {
//   //     lis.add(a[i]);
//   //   }
//   // }

//   var p = len - 1, lis = List.filled(len, 0);
//   for (var i = a.length - 1; i >= 0 && p >= 0; i--) {
//     // if (a[i] == t[t]) {
//     //   lis[p] = a[i];
//     //   p--;
//     // } else if (a[i] > t[t] && a[i] < t[t + 1]) {
//     //   lis[p] = a[i];
//     //   p--;
//     // }

//   if (a[i] == t[p]) {
    //   lis[c--] = a[i];
    //   p--;
    // } else if (a[i] > t[p] && a[i] < t[p + 1]) {
    //   lis[c--] = a[i];
    // }
//   }
//   return lis;
// }

// inconsecutive, O(n*n)
// in inconsecutive increasing subsequence, the start and end position will be
// nonsense. so it returns the subsequence itself.
// There is a bug when a is : [8, 3, 4, 7, 5, 2, 6, 1];
// List<int> lis9(List<int> a) {
//   var ml = 0, lis = <int>[];
//   for (var i = 0; i < a.length; i++) {
//     var t = a[i], l = 1, clis = [t];
//     for (var j = i + 1; j < a.length; j++) {
//       if (a[j] > t) {
//         t = a[j];
//         clis.add(t);
//         l++;
//       }
//     }

//     if (l > ml) {
//       ml = l;
//       lis = clis;
//     }
//   }

//   return lis;
// }
