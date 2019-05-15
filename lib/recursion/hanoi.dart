int _count = 0;

void hanoi(int n) {
  _hanoi(n, 'A', 'B', 'C');
  print('---------------------------');
  print('total moved: $_count times.\n');
}

void _hanoi(int n, String origin, String assist, String destination) {
  if (n == 1) {
    _move(origin, destination);
  } else {
    _hanoi(n - 1, origin, destination, assist);
    _move(origin, destination);
    _hanoi(n - 1, assist, origin, destination);
  }
}

void _move(String from, String to) {
  _count++;
  print('move $_count times:\tfrom $from to $to');
}
