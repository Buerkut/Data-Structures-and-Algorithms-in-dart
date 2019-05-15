import 'dart:io';
import 'dart:convert';
import '../low_level_stack.dart';

void run() {
  // var s = stdin.readLineSync();
  var a = <int>[];
  var i = stdin.readByteSync();
  while (i != 10) {
    a.add(i);
    i = stdin.readByteSync();
  }

  print(reverseString(utf8.decode(a)));
  print('--------------');
  print(utf8.decode(a));
  reverseArray(a);
  print(utf8.decode(a));
  // print(reverse(s));
}

void reverseArray(List<int> a) {
  var stk = Stack<int>(a.length);
  a.forEach(stk.push);
  a.clear();
  while (!stk.isEmpty) a.add(stk.pop());
}

String reverseString(String s) {
  var stack = Stack<String>(s.length);
  for (var i = 0; i < s.length; i++) stack.push(s[i]);
  var sb = StringBuffer();
  while (!stack.isEmpty) sb.write(stack.pop());
  return sb.toString();
}
