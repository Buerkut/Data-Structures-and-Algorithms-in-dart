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
  print(lis6(a));
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

// inconsecutive, O(n*n)
int lis6(List<int> a) {
  var dp = List.filled(a.length, 1), len = 0;

  for (int i = 1; i < a.length; i++) {
    for (int j = 0; j < i; j++) {
      if (a[j] < a[i] && dp[i] < dp[j] + 1) dp[i] = dp[j] + 1;
    }

    if (len < dp[i]) len = dp[i];
  }

  return len;
}
