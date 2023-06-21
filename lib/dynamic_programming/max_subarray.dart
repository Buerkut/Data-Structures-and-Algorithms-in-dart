// （int begin, int end, double maxSum):
// begin: the begin of max subarray, inclusive;
// end: the end of max subarray, exclusive;
// maxSum: the max sum of subarray.
(int, int, double) findMaxSubarrayDP(List<double> arr) {
  var n = arr.length, maxSum = double.negativeInfinity;
  var a = 0, b = 0, s = List.generate(n, (_) => List.filled(n, 0.0));

  for (var l = 1; l <= n; l++) {
    for (var i = 0; i <= n - l; i++) {
      var j = i + l - 1;
      for (var k = i; k <= j; k++) s[i][j] += arr[k];
      if (maxSum < s[i][j]) {
        a = i;
        b = j;
        maxSum = s[i][j];
      }
    }
  }

  return (a, b + 1, maxSum);
}

(int, int, double) findMaxSubarrayDP2(List<double> arr) {
  var n = arr.length, maxSum = double.negativeInfinity;
  var a = 0, b = 0, s = List.generate(n, (_) => List.filled(n, 0.0));

  for (var l = 1; l <= n; l++) {
    for (var i = 0; i <= n - l; i++) {
      var j = i + l - 1;
      s[i][j] = j == i ? arr[j] : s[i][j - 1] + arr[j];
      if (maxSum < s[i][j]) {
        a = i;
        b = j;
        maxSum = s[i][j];
      }
    }
  }

  return (a, b + 1, maxSum);
}

(int, int, double) findMaxSubarrayDP3(List<double> arr) {
  var n = arr.length, maxSum = double.negativeInfinity;
  var a = 0, b = 0, s = List.generate(n + 1, (_) => List.filled(n + 1, 0.0));

  for (var l = 1; l <= n; l++) {
    for (var i = 1; i <= n - l + 1; i++) {
      var j = i + l - 1;
      s[i][j] = s[i][j - 1] + arr[j - 1];
      if (maxSum < s[i][j]) {
        a = i;
        b = j;
        maxSum = s[i][j];
      }
    }
  }

  return (a - 1, b, maxSum);
}
