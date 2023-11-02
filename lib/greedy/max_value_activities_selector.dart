void main() {
  final s = [1, 3, 0, 5, 3, 5, 6, 8, 8, 2];
  final f = [4, 5, 6, 7, 9, 9, 10, 11, 12, 14];
  final v = [6, 3, 8, 9, 1, 4, 1, 3, 10, 1];

  final activities = <Activity>[];
  for (var i = 0; i < s.length; i++) {
    activities.add(Activity(i, s[i], f[i], v[i]));
  }

  var act = select(activities);
  print(act);
  act = biselect(activities);
  print(act);
  var maxValueActivities = <Activity>[];
  var t = 0;
  for (var i in act) {
    print(activities[i]);
    t += activities[i].value;
    maxValueActivities.add(activities[i]);
  }
  var t2 = maxValueActivities.fold(0, (prev, a) => prev + a.value);
  assert(t == t2);
  print(t);
  print(t2);
}

List<int> biselect(List<Activity> activities) {
  final n = activities.length;
  final val = List.filled(n + 1, 0);
  final act = List.generate(n + 1, (_) => <int>[]);

  activities = [...activities]
    ..sort((a, b) => a.endTime - b.endTime)
    ..insert(0, Activity(-1, 0, 0, 0));
  // activities.forEach(print);

  for (var i = 1; i <= n; i++) {
    var l = 1, r = i - 1;
    while (l <= r) {
      var mid = (l + r) >> 1;
      if (activities[mid].endTime <= activities[i].startTime)
        l = mid + 1;
      else
        r = mid - 1;
    }

    if (val[r] + activities[i].value > val[i - 1]) {
      val[i] = val[r] + activities[i].value;
      act[i] = [...act[r], i - 1];
    } else {
      val[i] = val[i - 1];
      act[i] = [...act[i - 1]];
    }
  }

  return act[n];
}

List<int> select(List<Activity> activities) {
  final n = activities.length;
  final val = List.filled(n + 1, 0);
  final act = List.generate(n + 1, (_) => <int>[]);

  activities = [...activities]
    ..sort((a, b) => a.endTime - b.endTime)
    ..insert(0, Activity(-1, 0, 0, 0));
  // activities.forEach(print);

  for (var i = 1; i <= n; i++) {
    var k = i - 1;
    while (k > 0) {
      if (activities[k].endTime <= activities[i].startTime) break;
      k--;
    }

    if (val[k] + activities[i].value > val[i - 1]) {
      val[i] = val[k] + activities[i].value;
      act[i] = [...act[k], i - 1];
    } else {
      val[i] = val[i - 1];
      act[i] = [...act[i - 1]];
    }
  }

  return act[n];
}

final class Activity {
  final int number;
  final int startTime;
  final int endTime;
  final int value;

  Activity(this.number, this.startTime, this.endTime, this.value);

  @override
  String toString() => '$number: $value, ($startTime - $endTime)';
}
