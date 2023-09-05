// 生成一段 dart 语言 猜数字小游戏
import 'dart:math';
import 'dart:io';

void main() {
  var rd = Random();
  var number = rd.nextInt(100);
  print('请输入一个数字，从 1 到 100 之间');
  var input = stdin.readLineSync();
  var guess = int.parse(input!);
  while (guess != number) {
    if (guess < number) {
      print('猜小了');
    } else {
      print('猜大了');
    }
    input = stdin.readLineSync();
    guess = int.parse(input!);
  }
  print('猜对了');
}
