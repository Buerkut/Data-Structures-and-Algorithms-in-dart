import 'dart:math' as math;

void main() {
  // var a = [3, 1, 2, 8, 9, 5, 6, 12, 4];
  // var a = [9, 16, 8, 2];
  var a = <int>[5, 8, 6, 7, 6];
  print(recursiveRob(a));
  // print(recursiveRob2(a));
  print(recursiveRob3(a));
  // print(memoizedRob(a));
  print(memoizedRob3(a));
  print(dpRob(a));
  // print(dpRobRaw(a));
  print(dpRob2(a));
  print(dpRob3(a));
  print(dpRob4(a));
  print(dpRob5(a));
}

int recursiveRob(List<int> a) {
  int _rob(int i) {
    if (i >= a.length) return 0;
    return a[i] + math.max(_rob(i + 2), _rob(i + 3));
  }

  return math.max(_rob(0), _rob(1));
}

int recursiveRob2(List<int> a) {
  int _rob(int i) {
    if (i >= a.length) return 0;
    if (i == a.length - 1) return a[i];

    int x = a[i] + math.max(_rob(i + 2), _rob(i + 3)),
        y = a[i + 1] + math.max(_rob(i + 3), _rob(i + 4));

    return math.max(x, y);
  }

  return _rob(0);
}

int recursiveRob3(List<int> a) {
  int _rob(int i) {
    if (i >= a.length) return 0;
    return math.max(a[i] + _rob(i + 2), _rob(i + 1));
  }

  return _rob(0);
}

// memoized recursive
int memoizedRob(List<int> a) {
  var r = List.filled(a.length, 0);

  int _rob(int i) {
    if (i >= a.length) return 0;
    if (r[i] > 0) return r[i];

    r[i] = a[i] + math.max(_rob(i + 2), _rob(i + 3));
    return r[i];
  }

  return math.max(_rob(0), _rob(1));
}

int memoizedRob3(List<int> a) {
  var r = List.filled(a.length, 0);

  int _rob(int i) {
    if (i >= a.length) return 0;
    if (r[i] > 0) return r[i];

    r[i] = math.max(a[i] + _rob(i + 2), _rob(i + 1));
    return r[i];
  }

  return _rob(0);
}

// dp. refer to max_triangle_sum.dart::int maxSumDP(List<List<int>> a)
int dpRob(List<int> a) {
  if (a.isEmpty) return 0;

  var dp = List.filled(a.length + 1, 0);
  for (var i = 1; i <= a.length; i++) {
    // dp[i] = switch (i) {
    //   1 || 2 => a[i - 1],
    //   _ => a[i - 1] + math.max(dp[i - 3], dp[i - 2])
    // };
    dp[i] = a[i - 1] +
        switch (i) { <= 2 => 0, _ => math.max(dp[i - 3], dp[i - 2]) };
  }

  return math.max(dp[a.length - 1], dp[a.length]);
}

int dpRobRaw(List<int> a) {
  if (a.isEmpty) return 0;
  if (a.length == 1) return a[0];

  var dp = List.filled(a.length, 0)
    ..[0] = a[0]
    ..[1] = a[1];

  if (a.length > 2) dp[2] = a[2] + dp[0];

  for (var i = 3; i < a.length; i++) {
    dp[i] = a[i] + math.max(dp[i - 3], dp[i - 2]);
  }

  return math.max(dp[a.length - 2], dp[a.length - 1]);
}

int dpRob2(List<int> a) {
  if (a.isEmpty) return 0;

  var dp = List.filled(a.length + 1, 0)..[1] = a[0];
  for (var i = 2; i < dp.length; i++) {
    dp[i] = math.max(dp[i - 1], a[i - 1] + dp[i - 2]);
  }

  return dp[a.length];
}

// spatial optimization
int dpRob3(List<int> a) {
  if (a.isEmpty) return 0;

  var m = a[0], t = 0;
  for (var i = 1; i < a.length; i++) {
    (m, t) = (t, m);
    m = math.max(a[i] + m, t);
  }

  return m;
}

int dpRob4(List<int> a) {
  var m = 0, t = 0;
  for (var i = 0; i < a.length; i++) {
    (m, t) = (t, m);
    m = math.max(a[i] + m, t);
  }
  return m;
}

int dpRob5(List<int> a) {
  var t = 0, m = 0;
  for (var e in a) {
    t = math.max(e + t, m);
    (t, m) = (m, t);
  }
  return m;
}
