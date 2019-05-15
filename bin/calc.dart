import 'dart:io';
import 'package:data_struct/stack/samples/calculator.dart' as calc1;
import 'package:data_struct/stack/samples/calculator2.dart' as calc2;

void main() {
  var exp = stdin.readLineSync();
  while (exp != 'exit') {
    try {
      var r1 = calc1.calc(exp);
      var r2 = calc2.calc(exp);
      print('calc1 result: ${r1 is int ? r1 : r1.toStringAsFixed(4)}');
      print('calc2 result: ${r2 is int ? r2 : r2.toStringAsFixed(4)}\n');
    } on FormatException {
      print('Format error!');
    } on Exception catch (e) {
      print('Unknown error: $e!');
    }

    print('please input the expression:');
    exp = stdin.readLineSync();
  }
}
