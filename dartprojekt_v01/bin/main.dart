import 'dart:io';

void main() {
  
  int num1 = readInt('Skriv första talet:');
  String operator = getOperator('Vilken operation +, -, * eller /');
  int num2 = readInt('Skriv andra talet:');
  

  if (operator == '-') {
    var sum = num1 - num2;
    print('Resultat: $num1 $operator $num2 = $sum');
  }else if (operator == '+') {
    var sum = num1 + num2;
    print('Resultat: $num1 $operator $num2 = $sum');
  }else if (operator == '*') {
    var sum = num1 * num2;
    print('Resultat: $num1 $operator $num2 = $sum');
  }else if (operator == '/') {
    var sum = num1 / num2;
    print('Resultat: $num1 $operator $num2 = $sum');
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

String getOperator(String prompt) {
  while (true) {
    print(prompt);
    String? input = stdin.readLineSync();

    if (input != null && (input == '+' || input == '-' || input == '*' || input == '/')) {
      return input; //Returnera värde som är kontrollerat
    } else {
      print('Du måste skriva +, -, * eller /. Försök igen.');
    }
  }
}