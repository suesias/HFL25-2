import 'package:v4/logic.dart';
import 'package:v4/managers/hero_data_manager.dart';
import 'dart:io';

Future<void> main() async {
  final manager = HeroDataManager();
  await manager.init();

  bool runProgram = true;
  while (runProgram) {
    print("\n" + "=" * 50);
    print("   HERO DEX 3000 – SUPERHJÄLTEHANTERARE");
    print("=" * 50);
    print("1. Sök & lägg till via API");
    print("2. Lägg till egen hjälte (manuellt)");
    print("3. Visa mina hjältar");
    print("4. Sök i mina hjältar");
    print("5. Radera hjälte");  // NYTT!
    print("6. Avsluta");
    stdout.write("\nDitt val: ");
    final input = stdin.readLineSync();

    switch (input) {
      case "1":
        await searchAndAddHero();
        break;
      case "2":
        await addCustomHero();
        break;
      case "3":
        await showHero();
        break;
      case "4":
        await searchLocalHero();
        break;
      case "5":
        await deleteHero();
        break;
      case "6":
        print("Hej då! Dina ändringar är sparade.");
        runProgram = false;
        break;
      default:
        print("Ogiltigt val – försök med 1–5!");
    }
  }
}