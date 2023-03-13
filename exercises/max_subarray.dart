void main() {
  var arr = <double>[-7, -2, 3, -4];
  // var arr = [13, -3, -25, 20, -3, -16, -23, 18, 20, -7, 12, -5, -22, 15, -4, 7];
  print(findMaxSubarrayBrute(arr));
  print(findMaxSubarrayGreedy(arr));
  print(findMaxSubarrayDivideAndConquer(arr));
}

List<num> findMaxSubarrayBrute(List<double> arr) {
  var maxSum = double.negativeInfinity;
  late List<num> outcome;

  for (var i = 0; i < arr.length; i++) {
    var sum = 0.0;
    for (var j = i; j < arr.length; j++) {
      sum += arr[j];
      if (sum > maxSum) {
        maxSum = sum;
        outcome = [i, j, maxSum];
      }
    }
  }

  return outcome;
}

List<num> findMaxSubarrayGreedy(List<double> arr) {
  var maxSum = double.negativeInfinity;
  var leftIndexes = <int>[];
  late int rightIndex;

  var sum = 0.0;
  for (var i = 0; i < arr.length; i++) {
    sum += arr[i];
    if (sum > maxSum) {
      maxSum = sum;
      rightIndex = i;
    }

    //如果结果已经为负数
    if (sum < 0) {
      sum = 0;
      leftIndexes.add(i + 1);
    }
  }

  print(leftIndexes);
  var leftIndex = leftIndexes.lastWhere((index) => index < rightIndex);
  return [leftIndex, rightIndex, maxSum];
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

    return [leftIndex, rightIndex, maxSumLeft + maxSumRight];
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
