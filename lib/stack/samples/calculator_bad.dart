import '../stack.dart';

void run() {
  var ins = '(1*0.5+1)+2*(1+2*(7-1*2*3)-1)-1.5';
  var es = parse(ins);
  print(es.content);
  var rst = calculate(es);
  print(rst);
}

Stack<String> parse(String ins) {
  var es = Stack<String>();
  for (var i = ins.length - 1; i >= 0; i--) {
    if (isDigit(ins[i])) {
      var j = i--;
      while (i >= 0 && isDigit(ins[i])) i--;
      es.push(ins.substring(++i, j + 1));
    } else {
      es.push(ins[i]);
    }
  }
  return es;
}

num calculate(Stack<String> es) {
  var cs = Stack<String>();
  while (es.isNotEmpty) {
    if (es.top != ')') {
      cs.push(es.pop());
    } else {
      es.pop();
      var bs = Stack<String>();
      while (cs.isNotEmpty && cs.top != '(') bs.push(cs.pop());
      cs
        ..pop()
        ..push(_calc(bs).toString());
    }
  }
  var cs2 = Stack<String>();
  while (cs.isNotEmpty) cs2.push(cs.pop());
  return _calc(cs2);
}

num _calc(Stack<String> bs) {
  num a = d(bs.pop());
  while (bs.isNotEmpty) {
    var op = bs.pop();
    var b = d(bs.pop());
    if ((op == '+' || op == '-') &&
        bs.isNotEmpty &&
        (bs.top == '*' || bs.top == '/')) {
      while (bs.isNotEmpty && (bs.top == '*' || bs.top == '/')) {
        var prop = bs.pop();
        var c = d(bs.pop());
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

num d(String s) => num.parse(s);

bool isDigit(String c) =>
    (c.codeUnitAt(0) >= 48 && c.codeUnitAt(0) <= 57) || c.codeUnitAt(0) == 46;
