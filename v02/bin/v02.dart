import 'package:v02/v02.dart' as v02;
import 'dart:io';

// List för att lagra hjältar
List<Map<String, dynamic>> hjaltar = [];

void main() {
  bool runProgram = true;

  while (runProgram) {
    print("HeroDex 3000 - välj ett alternativ:");
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

void addHero() {
 
  print("add hero");
}

void showHero() {

    print("show hero");

}

void searchHero() {

    print("search hero");

}

