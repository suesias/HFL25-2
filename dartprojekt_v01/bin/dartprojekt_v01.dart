import 'dart:io';

void main() {
  print('Skriv första talet:');
  int num1 = int.parse(stdin.readLineSync()!);

  print('Skriv andra talet:');
  int num2 = int.parse(stdin.readLineSync()!);

  var sum = num1 + num2;
  print('Summan av talen = $sum');
}