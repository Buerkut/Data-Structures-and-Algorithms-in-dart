Iterable<List<int>> pair(List<int> redPots, List<int> bluePots) {
  if (redPots.length != bluePots.length) {
    throw StateError('the number of red pots and blue pots is not equal.');
  }

  var map = <int, List<int>>{};
  for (var i = 0; i < redPots.length; i++) {
    map[redPots[i]] = [i];
  }

  for (var j = 0; j < bluePots.length; j++) {
    map[bluePots[j]]!.add(j);
  }

  return map.values;
}
