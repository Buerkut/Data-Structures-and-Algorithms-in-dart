// This is a thinking question(16.1-4) at chapter 16 "Greedy Algorithm"
// in the book "Introduction to Algorithms".

// Question:
// Suppose that we have a set of activities to schedule among a large number
// of lecture halls, where any activity can take place in any lecture hall. We
// wish to schedule all the activities using as few lecture halls as possible.
// Give an efficient greedy algorithm to determine which activity should use
// which lecture hall.
// This problem is also known as the interval-graph coloring problem. We can
// create an interval graph whose vertices are the given activities and whose
// edges connect incompatible activities. The smallest number of colors
// required to color every vertex so that no two adjacent vertices have the
// same color corresponds to finding the fewest lecture halls needed to
// schedule all of the given activities.

import 'package:data_struct/heap/min_heap.dart';

void main() {
  final s = [1, 3, 0, 5, 4, 6, 7, 9, 8, 2, 12];
  final f = [4, 5, 6, 7, 9, 9, 10, 11, 12, 8, 16];
  // final s = [1, 2, 6, 4];
  // final f = [4, 5, 7, 8];

  final activities = <Activity>[];
  for (var i = 0; i < s.length; i++) activities.add(Activity(i, s[i], f[i]));

  print('Detailed arrangement:');
  var n = 0;
  for (var room in arrange(activities)) {
    print('Room ${room.number}: ${room.activities}');
    n++;
  }
  print('Total of $n rooms needed.');
}

Iterable<Room> arrange(List<Activity> activities) {
  activities.sort((a, b) => a.startTime - b.startTime);

  var roomNumber = 0, heap = MinHeap<Room>();
  for (var activity in activities) {
    var room = switch (
        !heap.isEmpty && activity.startTime >= heap.top.availableTime) {
      true => heap.popTop(),
      _ => Room(roomNumber++)
    };
    room.addActivity(activity);
    heap.push(room);
  }

  return heap.pop(heap.size);
}

final class Activity {
  final int number;
  final int startTime;
  final int endTime;

  Activity(this.number, this.startTime, this.endTime);

  @override
  String toString() => '$number: ($startTime - $endTime)';
}

final class Room implements Comparable<Room> {
  final int number;
  int _availableTime;
  final List<Activity> activities;

  Room(this.number)
      : _availableTime = 0,
        activities = [];

  int get availableTime => _availableTime;

  void addActivity(Activity a) {
    activities.add(a);
    _availableTime = a.endTime;
  }

  @override
  int compareTo(Room other) => _availableTime - other._availableTime;
}
