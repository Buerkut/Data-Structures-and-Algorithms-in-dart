import 'dart:io';
import '../low_level_stack.dart';

void run() {
  var ins = stdin.readLineSync();
  while (ins != 'exit') {
    print(check(ins));
    ins = stdin.readLineSync();
  }
}

bool check(String ins) {
  var stack = Stack<String>(ins.length);
  for (var i = 0; i < ins.length; i++) {
    switch (ins[i]) {
      case '{':
      case '[':
      case '(':
        stack.push(ins[i]);
        break;
      case ')':
        if (stack.isEmpty || stack.pop() != '(') return false;
        break;
      case ']':
        if (stack.isEmpty || stack.pop() != '[') return false;
        break;
      case '}':
        if (stack.isEmpty || stack.pop() != '{') return false;
        break;
      default:
        break;
    }
  }
  return stack.isEmpty;
}
