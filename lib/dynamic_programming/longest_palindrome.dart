// Refer to: https://blog.csdn.net/weixin_44471490/article/details/109095496

import 'dart:math' as math;

void main() {
  var s = 'character';
  print(findLongestPalindrome(s));
  print(findLongestPalindrome2(s));
  // var l = longestPalindromeLen(s);
  // print(l);
  // print(longestPalindromeLen2(s));
  print(longestPalindromeLen3(s));
  print(findLongestPalindromeSeq(s));
  print(findLongestPalindromeSeq2(s));
  print(findLongestPalindromeSeq3(s));
}

// dynamic programming. 斜着遍历.
int findLongestPalindrome(String s) {
  var n = s.length, dp = List.generate(n, (_) => List.filled(n, 0));
  for (var i = 0; i < n; i++) dp[i][i] = 1;

  for (var j = 1; j < n; j++) {
    for (var i = 0; i < n - j; i++) {
      var k = i + j;
      dp[i][k] = switch (s[i] == s[k]) {
        true => dp[i + 1][k - 1] + 2,
        _ => math.max(dp[i + 1][k], dp[i][k - 1])
      };
    }
  }

  return dp[0][n - 1];
}

// dynamic programming. 反向向上遍历.
int findLongestPalindrome2(String s) {
  var dp = List.generate(s.length, (_) => List.filled(s.length, 0));

  for (var i = s.length - 1; i >= 0; i--) {
    dp[i][i] = 1;
    for (var j = i + 1; j < s.length; j++) {
      dp[i][j] = switch (s[i] == s[j]) {
        true => dp[i + 1][j - 1] + 2,
        _ => math.max(dp[i + 1][j], dp[i][j - 1])
      };
    }
  }

  return dp[0][s.length - 1];
}

// recursive
int longestPalindromeLen(String s) {
  int _f(int i, int j) {
    if (i > j) return 0;
    if (i == j) return 1;
    if (s[i] == s[j]) {
      return _f(i + 1, j - 1) + 2;
    } else {
      return math.max(_f(i + 1, j), _f(i, j - 1));
    }
  }

  return _f(0, s.length - 1);
}

int longestPalindromeLen2(String s) {
  var dp = List.generate(s.length, (_) => List.filled(s.length, -1));

  int _f(int i, int j) {
    if (i > j) return 0;
    if (dp[i][j] > 0) return dp[i][j];

    if (i == j) {
      dp[i][j] = 1;
    } else if (s[i] == s[j]) {
      dp[i][j] = _f(i + 1, j - 1) + 2;
    } else {
      dp[i][j] = math.max(_f(i + 1, j), _f(i, j - 1));
    }

    return dp[i][j];
  }

  return _f(0, s.length - 1);
}

int longestPalindromeLen3(String s) {
  var dp = List.generate(s.length, (_) => List.filled(s.length, -1));

  int _f(int i, int j) {
    if (i > j) return 0;
    if (dp[i][j] > 0) return dp[i][j];

    dp[i][j] = switch (j - i) {
      == 0 => 1,
      _ => switch (s[i] == s[j]) {
          true => _f(i + 1, j - 1) + 2,
          _ => math.max(_f(i + 1, j), _f(i, j - 1))
        }
    };

    return dp[i][j];
  }

  return _f(0, s.length - 1);
}

// recursive
String findLongestPalindromeSeq(String s) {
  var dp = List.generate(s.length, (_) => List.filled(s.length, ''));

  String _f(int i, int j) {
    if (i > j) return '';
    if (dp[i][j].isNotEmpty) return dp[i][j];

    String _ls(int i, int j) {
      var s1 = _f(i + 1, j), s2 = _f(i, j - 1);
      return switch (s1.length - s2.length) { > 0 => s1, _ => s2 };
      // return s1.length > s2.length ? s1 : s2;
    }

    // can use if-else as longestPalindromeLen2.
    dp[i][j] = switch (j - i) {
      == 0 => s[i],
      _ => switch (s[i] == s[j]) {
          true => '${s[i]}${_f(i + 1, j - 1)}${s[j]}',
          _ => _ls(i, j)
        }
    };

    return dp[i][j];
  }

  return _f(0, s.length - 1);
}

// dynamic programming. 斜着遍历.
String findLongestPalindromeSeq2(String s) {
  var n = s.length, dp = List.generate(n, (_) => List.filled(n, ''));
  for (var i = 0; i < n; i++) dp[i][i] = s[i];

  String _slp(int i, int j) {
    var s1 = dp[i + 1][j], s2 = dp[i][j - 1];
    return s1.length > s2.length ? s1 : s2;
  }

  for (var j = 1; j < n; j++) {
    for (var i = 0; i < n - j; i++) {
      var k = i + j;
      dp[i][k] = switch (s[i] == s[k]) {
        true => '${s[i]}${dp[i + 1][k - 1]}${s[k]}',
        _ => _slp(i, k)
      };
    }
  }

  return dp[0][n - 1];
}

// dynamic programming. 反向向上遍历.
String findLongestPalindromeSeq3(String s) {
  var dp = List.generate(s.length, (_) => List.filled(s.length, ''));

  String _slp(int i, int j) {
    var s1 = dp[i + 1][j], s2 = dp[i][j - 1];
    return switch (s1.length - s2.length) { > 0 => s1, _ => s2 };
  }

  for (var i = s.length - 1; i >= 0; i--) {
    dp[i][i] = s[i];
    for (var j = i + 1; j < s.length; j++)
      dp[i][j] = switch (s[i] == s[j]) {
        true => '${s[i]}${dp[i + 1][j - 1]}${s[j]}',
        _ => _slp(i, j)
      };
  }

  return dp[0][s.length - 1];
}
