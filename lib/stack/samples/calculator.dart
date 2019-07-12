import '../src/stack.dart';

num calc(String ins) {
  try {
    var es = _preCalc(_eliminateSpace(ins));
    return _calc(es);
  } on StackEmptyException {
    throw FormatException();
  }
}

String _eliminateSpace(String ins) => ins.replaceAll(RegExp(r'\s+'), '');

Stack<String> _preCalc(String ins) {
  var es = Stack<String>();
  for (var i = ins.length - 1; i >= 0; i--) {
    if (_isDigit(ins[i])) {
      var j = i--;
      while (i >= 0 && _isDigit(ins[i])) i--;
      if ((i == 0 && ins[i] == '-') ||
          (i > 0 && ins[i] == '-' && ins[i - 1] == '(')) {
        es.push(ins.substring(i, j + 1));
      } else {
        es.push(ins.substring(++i, j + 1));
      }
    } else if (ins[i] == '(') {
      var a = _calc(es);
      es
        ..pop()
        ..push(a.toString());
    } else {
      es.push(ins[i]);
    }
  }
  return es;
}

num _calc(Stack<String> es) {
  num a = _d(es.pop());
  while (es.isNotEmpty && es.top != ')') {
    var op = es.pop();
    var b = _d(es.pop());
    if ((op == '+' || op == '-') &&
        es.isNotEmpty &&
        (es.top == '*' || es.top == '/')) {
      while (es.isNotEmpty && (es.top == '*' || es.top == '/')) {
        var prop = es.pop();
        var c = _d(es.pop());
        b = prop == '*' ? b * c : b / c;
      }
    }
    switch (op) {
      case '+':
        a += b;
        break;
      case '-':
        a -= b;
        break;
      case '*':
        a *= b;
        break;
      case '/':
        a /= b;
        break;
      default:
        break;
    }
  }
  return a;
}

num _d(String s) => num.parse(s);

bool _isDigit(String c) =>
    (c.codeUnitAt(0) >= 48 && c.codeUnitAt(0) <= 57) || c.codeUnitAt(0) == 46;
