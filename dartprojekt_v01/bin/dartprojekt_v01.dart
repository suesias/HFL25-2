import 'dart:io';

void main() {
  
  int num1 = readInt('Skriv första talet:');

  var operator;


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

  int num2 = readInt('Skriv andra talet:');
  

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

int readInt(String prompt) {
  while (true) {
    print(prompt);
    String? input = stdin.readLineSync();

    try {
      return int.parse(input!); // Skicka tillbaka vid success
    } catch (e) {
      print('Du måste skriva ett heltal. Försök igen.');
    }
  }
}