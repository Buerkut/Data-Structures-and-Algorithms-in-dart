import 'dart:io';
// import 'dart:math';

void main() {
  // print([].length);
  // var rd = Random();
  // var arr = List.generate(16, (_) => rd.nextDouble());

  // stdout.write('[');
  // for (var i = 0; i < arr.length; i += 4) {
  //   if (i != 0 && i % 4 == 0) print('');
  //   stdout.write('[');
  //   for (var j = i; j < i + 4; j++) {
  //     if (j < i + 3)
  //       stdout.write('${arr[j].toStringAsFixed(4)}, ');
  //     else
  //       stdout.write('${arr[j].toStringAsFixed(4)}');
  //   }
  //   stdout.write('],');
  // }
  // stdout.writeln(']');
  var d = 2;
  switch (isEven(d)) {
    case true:
      print('$d is even');
    case false:
      print('$d is odd');
  }
}

bool isOdd(int d) => d & 1 == 1;

bool isEven(int d) => d & 1 == 0;

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
