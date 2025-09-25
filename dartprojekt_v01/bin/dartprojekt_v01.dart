import 'dart:io';

void main() {
  
  int num1;
  int num2;
  var operator;

  while (true) {
    print('Skriv första talet:');
    String? input = stdin.readLineSync(); //String? betyder att den kan vara null

    try {
      num1 = int.parse(input!); // Försök att konvertera till int
      break; // Success avsluta loopen
    } catch (e) {
      print('Du måste skriva ett heltal. Försök igen.');
    }
  }

  while (true) {
    print('Vilken operation + eller -');
    String? input = stdin.readLineSync();

    if (input == '+' || input == '-') {
      operator = input; 
      break; // Success avsluta loopen
    } else {
      print('Du måste skriva + eller - Försök igen.');
    }
  }


 while (true) {
    print('Skriv andra talet:');
    String? input = stdin.readLineSync();

    try {
      num2 = int.parse(input!); // Försök att konvertera till int
      break; // Success avsluta loopen
    } catch (e) {
      print('Du måste skriva ett heltal. Försök igen.');
    }
  }
  

  if (operator == '-') {
    var sum = num1 - num2;
    print('Differensen av talen = $sum');
  }else if (operator == '+') {
    var sum = num1 + num2;
    print('Summan av talen = $sum');
  } else {
    print('Ogiltig operation');
  }
}