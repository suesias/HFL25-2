import 'package:v03/managers/hero_data_manager.dart';
import 'package:v03/models/hero_model.dart';
import 'dart:io';

final manager = HeroDataManager(); // Singleton

Future<void> addHero() async {
  // Prompt för grundläggande fält (inte alla, för att hålla enkelt – resten defaults)
  String name;
  while (true) {
    stdout.write("\nHjältens namn: ");
    final input = stdin.readLineSync();
    if (input != null && input.trim().isNotEmpty) {
      name = input.trim();
      break;
    }
    print("\nOgiltigt namn, försök igen!");
  }

  String strength;
  while (true) {
    stdout.write("\nHjältens styrka (text, t.ex. '26'): ");
    final input = stdin.readLineSync();
    if (input != null && input.trim().isNotEmpty) {
      strength = input.trim();
      break;
    }
    print("\nOgiltig styrka!");
  }

  String power; // Ditt gamla "specialpower" -> power
  while (true) {
    stdout.write("\nHjältens specialkraft (t.ex. '47'): ");
    final input = stdin.readLineSync();
    if (input != null && input.trim().isNotEmpty) {
      power = input.trim();
      break;
    }
    print("\nSpecialkraft får inte vara tom!");
  }

  // Skapa HeroModel med defaults för resten
  final hero = HeroModel(
    response: 'success', // Default
    id: DateTime.now().millisecondsSinceEpoch.toString(), // Unik ID
    name: name,
    powerstats: Powerstats(
      strength: strength,
      power: power,
      // Övriga defaults till '0' eller null
      intelligence: '0',
      speed: '0',
      durability: '0',
      combat: '0',
    ),
    // Övriga sektioner: null eller tomma
    biography: Biography(aliases: []),
    appearance: Appearance(height: [], weight: []),
    work: Work(),
    connections: Connections(),
    image: HeroImage(),
  );

  await manager.saveHero(hero);
  print("Hjälten $name lades till!");
}

Future<void> showHero() async {
  final heroes = await manager.getHeroList();
  if (heroes.isEmpty) {
    print("\nInga hjältar tillagda än.");
    return;
  }
  print("\nLista över hjältar (starkast först):");
  for (var h in heroes) {
    print("${h.name} | Styrka: ${h.powerstats?.strength ?? 'Okänd'} | Kraft: ${h.powerstats?.power ?? 'Okänd'}");
  }
}

Future<void> searchHero() async {
  stdout.write("\nSök efter hjälte (namn eller del av namn): ");
  final input = stdin.readLineSync();
  if (input == null || input.trim().isEmpty) {
    print("Du måste skriva något!");
    return;
  }
  final searchfor = input.trim();
  final results = await manager.searchHero(searchfor);
  if (results.isEmpty) {
    print("Ingen hjälte hittades på '$searchfor'.");
  } else {
    print("\nSökträffar på '$searchfor':");
    for (var h in results) {
      print("${h.name} | Styrka: ${h.powerstats?.strength ?? 'Okänd'} | Kraft: ${h.powerstats?.power ?? 'Okänd'}");
    }
  }
}