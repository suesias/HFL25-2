import 'package:v04/logic.dart';
import 'package:v04/managers/hero_data_manager.dart';
import 'dart:io';
import 'package:v04/config/env.dart';

Future<void> main() async {
  Env.load(); // laddar .env
  print(Env.superheroApiKey);

  final manager = HeroDataManager();
  await manager.init(); // Ladda data async

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
        await addHero();
        break;
      case "2":
        await showHero();
        break;
      case "3":
        await searchHero();
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