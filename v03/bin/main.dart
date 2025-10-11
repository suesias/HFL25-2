import 'package:v03/logic.dart';
import 'dart:io';


void main() {
  bool runProgram = true;

  while (runProgram) {
    print("\n\nHeroDex 3000 - välj ett alternativ:");
    print("1. Lägg till hjälte");
    print("2. Visa hjältar");
    print("3. Sök hjälte");
    print("4. Avsluta");

    stdout.write("Ditt val: ");
    final input = stdin.readLineSync();

    switch (input) {
      case "1":
        addHero();
        break;
      case "2":
        showHero();
        break;
      case "3":
        searchHero();
        break;
      case "4":
        print("Avslutar programmet.");
        runProgram = false;
        break;
      default:
        print("Felaktigt val, försök igen!");
    }
  }
}



