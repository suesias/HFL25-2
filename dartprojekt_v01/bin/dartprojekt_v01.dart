import 'dart:io';

void main() {
  print('Skriv första talet:');
  int num1 = int.parse(stdin.readLineSync()!);

  print('Vilken operation + eller -');
  var oper = stdin.readLineSync();

  print('Skriv andra talet:');
  int num2 = int.parse(stdin.readLineSync()!);
  
  if (oper == '-') {
    var sum = num1 - num2;
    print('Differensen av talen = $sum');
  }else if (oper == '+') {
    var sum = num1 + num2;
    print('Summan av talen = $sum');
  } else {
    print('Ogiltig operation');
  }
}