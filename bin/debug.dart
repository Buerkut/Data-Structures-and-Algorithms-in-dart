import 'dart:io';

void main() {
  print([].length);
}

bool isOdd(int d) => d & 1 == 1;

bool isTwoPower(int d) => d & (d - 1) == 0;

void input() {
  print('please input the number:');
  var s = stdin.readLineSync();
  while (s != 'exit') {
    // var n = int.parse(s);
    // print('triangle n: ${factorial(n)}');

    print('please input the number:');
    s = stdin.readLineSync();
  }
}
