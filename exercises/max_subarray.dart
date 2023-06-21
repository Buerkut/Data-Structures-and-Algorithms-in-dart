import 'package:data_struct/dynamic_programming/max_subarray.dart';

void main() {
  var arr = <double>[-9, -4, 5, -1, 8, -3, 2];

  print(findMaxSubarrayBrute(arr));
  print(findMaxSubarrayGreedy(arr));
  print(findMaxSubarrayDivideAndConquer(arr));
  print(findMaxSubarrayDP(arr));
  print(findMaxSubarrayDP2(arr));
  print(findMaxSubarrayDP3(arr));
}

// （int begin, int end, double maxSum):
// begin: the begin of max subarray, inclusive;
// end: the end of max subarray, exclusive;
// maxSum: the max sum of subarray.
(int, int, double) findMaxSubarrayBrute(List<double> arr) {
  var maxSum = double.negativeInfinity;
  late (int, int, double) outcome;

  for (var i = 0; i < arr.length; i++) {
    var sum = 0.0;
    for (var j = i; j < arr.length; j++) {
      sum += arr[j];
      if (sum > maxSum) {
        maxSum = sum;
        outcome = (i, j + 1, maxSum);
      }
    }
  }

  return outcome;
}

(int, int, double) findMaxSubarrayGreedy(List<double> arr) {
  var b = 0, l = 0, len = 0, sum = 0.0, maxSum = double.negativeInfinity;
  for (var i = 0; i < arr.length; i++) {
    sum += arr[i];
    l++;
    if (maxSum < sum) {
      maxSum = sum;
      b = i;
      len = l;
    }

    //如果结果已经为负数
    if (sum < 0) {
      sum = 0;
      l = 0;
    }
  }

  return (b - len + 1, b + 1, maxSum);
}

List<num> findMaxSubarrayDivideAndConquer(List<double> arr) {
  List<num> findMaxCrossingSubarray(
      List<double> arr, int low, int mid, int high) {
    var maxSumLeft = double.negativeInfinity;
    late int leftIndex, rightIndex;

    var sum = 0.0;
    for (var i = mid; i >= low; i--) {
      sum += arr[i];
      if (sum > maxSumLeft) {
        maxSumLeft = sum;
        leftIndex = i;
      }
    }

    sum = 0.0;
    var maxSumRight = double.negativeInfinity;
    for (var i = mid + 1; i <= high; i++) {
      sum += arr[i];
      if (sum > maxSumRight) {
        maxSumRight = sum;
        rightIndex = i;
      }
    }

    return [leftIndex, rightIndex + 1, maxSumLeft + maxSumRight];
  }

  List<num> findMaxSubarrayDC(List<double> arr, int low, int high) {
    if (high == low) return [low, high, arr[low]];

    var mid = (low + high) >> 1;
    var leftOut = findMaxSubarrayDC(arr, low, mid);
    var rightOut = findMaxSubarrayDC(arr, mid + 1, high);
    var crossOut = findMaxCrossingSubarray(arr, low, mid, high);
    var maxSumLeft = leftOut.last;
    var maxSumRight = rightOut.last;
    var maxSumCrossing = crossOut.last;

    //合并
    if (maxSumLeft >= maxSumRight && maxSumLeft >= maxSumCrossing) {
      return leftOut;
    } else if (maxSumRight >= maxSumLeft && maxSumRight >= maxSumCrossing) {
      return rightOut;
    } else {
      return crossOut;
    }
  }

  return findMaxSubarrayDC(arr, 0, arr.length - 1);
}
