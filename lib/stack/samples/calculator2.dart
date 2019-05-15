/// postfix
import 'package:data_struct/stack/stack.dart';

num calc(String exp) {
  try {
    var postfix = _convert(_eliminateSpace(exp));
    return _calc(postfix);
  } on StackEmptyException {
    throw FormatException();
  }
}

String _eliminateSpace(String exp) => exp.replaceAll(RegExp(r'\s+'), '');

List<String> _convert(String exp) {
  var ops = Stack<String>();
  var list = <String>[];
  for (var i = 0; i < exp.length; i++) {
    if (_isDigit(exp[i]) || _isNegative(exp, i)) {
      var j = i++;
      while (i < exp.length && _isDigit(exp[i])) i++;
      list.add(exp.substring(j, i--));
    } else if (exp[i] == '(') {
      ops.push(exp[i]);
    } else if (exp[i] == ')') {
      while (ops.top != '(') list.add(ops.pop());
      ops.pop();
    } else {
      if (ops.isEmpty || ops.top == '(') {
        ops.push(exp[i]);
      } else {
        while (ops.isNotEmpty &&
            ops.top != '(' &&
            _comparePrior(exp[i], ops.top) < 0) list.add(ops.pop());
        ops.push(exp[i]);
      }
    }
  }
  while (ops.isNotEmpty) list.add(ops.pop());
  return list;
}

num _calc(List<String> list) {
  var cs = Stack<num>();
  for (var op in list) {
    if (_isOperator(op)) {
      var b = cs.pop();
      var a = cs.pop();
      switch (op) {
        case '+':
          cs.push(a + b);
          break;
        case '-':
          cs.push(a - b);
          break;
        case '*':
          cs.push(a * b);
          break;
        case '/':
          cs.push(a / b);
          break;
        default:
          break;
      }
    } else {
      cs.push(num.parse(op));
    }
  }
  if (cs.size != 1) throw FormatException();
  return cs.pop();
}

int _comparePrior(String opCurrent, String opLast) =>
    (opCurrent == '*' || opCurrent == '/') && (opLast == '+' || opLast == '-')
        ? 1
        : -1;

bool _isDigit(String c) =>
    (c.codeUnitAt(0) >= 48 && c.codeUnitAt(0) <= 57) || c.codeUnitAt(0) == 46;

bool _isNegative(String exp, int i) =>
    exp[i] == '-' && (i == 0 || exp[i - 1] == '(');

bool _isOperator(String c) => c == '+' || c == '-' || c == '*' || c == '/';
