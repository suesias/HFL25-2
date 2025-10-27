import 'package:v04/logic.dart';
import 'package:v04/managers/hero_data_manager.dart';
import 'package:v04/config/env.dart';
import 'dart:io';

Future<void> main() async {
  Env.load();
  print('API-nyckel i main: ${Env.superheroApiKey}');
  if (Env.superheroApiKey.isEmpty) {
    print('Fel: Ingen API-nyckel hittades. Kontrollera .env-filen.');
    return;
  }

  final manager = HeroDataManager();
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
        await addHero(manager);
        break;
      case "2":
        await showHeroes(manager);
        break;
      case "3":
        await searchHero(manager);
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