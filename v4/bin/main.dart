import 'package:v4/logic.dart';
import 'package:v4/managers/hero_data_manager.dart';
import 'package:v4/services/superhero_api_service.dart';
import 'dart:io';


Future<void> main() async {
  final manager = HeroDataManager();
  await manager.init();

  final apiService = SuperheroApiService();

  stdout.write("Sök efter en hjälte (t.ex. Batman): ");
  final name = stdin.readLineSync()?.trim();

  if (name == null || name.isEmpty) {
    print("Inget namn angivet.");
    return;
  }

  try {
    final heroes = await apiService.searchHeroes(name);
    
    if (heroes.isEmpty) {
      print("Ingen hjälte hittades.");
    } else {
      print("\nHittade ${heroes.length} hjältar:");
      for (var hero in heroes) {
        print("${hero.name} (ID: ${hero.id}) - Styrka: ${hero.powerstats?.strength}");
      }

      // Spara första träffen till vår lokala lista
      await manager.saveHero(heroes[0]);
      print("\n'${heroes[0].name}' har sparats lokalt!");
    }
  } catch (e) {
    print("Fel: $e");
  }
}

/*Future<void> main() async {
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
}*/