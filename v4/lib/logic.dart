import 'package:v4/managers/hero_data_manager.dart';
import 'package:v4/models/hero_model.dart';
import 'package:v4/services/superhero_api_service.dart';
import 'dart:io';
import 'dart:convert';

final manager = HeroDataManager();
final apiService = SuperheroApiService();

// 1. SÖK OCH LÄGG TILL VIA API
Future<void> searchAndAddHero() async {
  stdout.write("\nSök efter en hjälte (t.ex. Spider-Man): ");
  final input = stdin.readLineSync()?.trim();

  if (input == null || input.isEmpty) {
    print("Du måste skriva ett namn!");
    return;
  }

  print("Söker på Superhero API...");
  try {
    final heroes = await apiService.searchHeroes(input);

    if (heroes.isEmpty) {
      print("Ingen hjälte hittades med namnet '$input'.");
      return;
    }

    print("\nHittade ${heroes.length} hjältar:");
    for (int i = 0; i < heroes.length; i++) {
      final h = heroes[i];
      print("${i + 1}. ${h.name} | Styrka: ${h.powerstats?.strength ?? 'Okänd'} | Kraft: ${h.powerstats?.power ?? 'Okänd'}");
    }

    stdout.write("\nVälj nummer att spara (eller 0 för att avbryta): ");
    final choice = stdin.readLineSync();
    final index = int.tryParse(choice ?? '') ?? -1;
    if (index <= 0 || index > heroes.length) {
      print("Ogiltigt val – ingen hjälte sparades.");
      return;
    }

    final selectedHero = heroes[index - 1];
    final existing = await manager.searchHero(selectedHero.name!);
    if (existing.isNotEmpty) {
      print("'${selectedHero.name}' finns redan!");
      return;
    }

    await manager.saveHero(selectedHero);
    print("\nHJÄLTE SPARAD: ${selectedHero.name}!");
    print("   Styrka: ${selectedHero.powerstats?.strength}");
    print("   Specialkraft: ${selectedHero.powerstats?.power}");
    if (selectedHero.image?.url != null) {
      print("   Bild: ${selectedHero.image!.url}");
    }

  } catch (e) {
    print("Fel: $e");
  }
}

// 2. LÄGG TILL EGEN HJÄLTE (MANUELLT)
Future<void> addCustomHero() async {
  stdout.write("\nHjältens namn: ");
  final nameInput = stdin.readLineSync()?.trim();
  if (nameInput == null || nameInput.isEmpty) {
    print("Namnet får inte vara tomt!");
    return;
  }

  final existing = await manager.searchHero(nameInput);
  if (existing.isNotEmpty) {
    print("En hjälte med namnet '$nameInput' finns redan!");
    return;
  }

  // STYRKA
  String strength = "0";
  while (true) {
    stdout.write("Styrka (0–100, t.ex. 85): ");
    final s = stdin.readLineSync()?.trim();
    final num = int.tryParse(s ?? '');
    if (num != null && num >= 0 && num <= 100) {
      strength = num.toString();
      break;
    }
    print("Ogiltigt! Ange ett nummer mellan 0 och 100.");
  }

  // SPECIALKRAFT
  String power = "0";
  while (true) {
    stdout.write("Specialkraft (0–100, t.ex. 47): ");
    final p = stdin.readLineSync()?.trim();
    final num = int.tryParse(p ?? '');
    if (num != null && num >= 0 && num <= 100) {
      power = num.toString();
      break;
    }
    print("Ogiltigt! Ange ett nummer mellan 0 och 100.");
  }

  // ALIGNMENT (NYTT!)
  String alignment = "good";
  print("\nAlignment (god/ond):");
  print("1. good (god)");
  print("2. bad (ond)");
  print("3. neutral");
  while (true) {
    stdout.write("Välj (1-3): ");
    final choice = stdin.readLineSync()?.trim();
    switch (choice) {
      case "1":
        alignment = "good";
        break;
      case "2":
        alignment = "bad";
        break;
      case "3":
        alignment = "neutral";
        break;
      default:
        print("Välj 1, 2 eller 3!");
        continue;
    }
    break;
  }

  // Skapa hjälte
  final hero = HeroModel(
    response: 'success',
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    name: nameInput,
    powerstats: Powerstats(
      intelligence: '50',
      strength: strength,
      speed: '50',
      durability: '50',
      power: power,
      combat: '50',
    ),
    biography: Biography(
      fullName: 'Okänd',
      alterEgos: 'Inga',
      aliases: ['Egen hjälte'],
      placeOfBirth: 'Okänd',
      firstAppearance: 'HeroDex 3000',
      publisher: 'Användare',
      alignment: alignment,  // NYTT!
    ),
    appearance: Appearance(
      gender: 'Okänd',
      race: 'Anpassad',
      height: ['?', '?'],
      weight: ['?', '?'],
      eyeColor: 'Okänd',
      hairColor: 'Okänd',
    ),
    work: Work(occupation: 'Hjälte', base: 'Hemliga basen'),
    connections: Connections(groupAffiliation: 'Egen', relatives: 'Okänd'),
    image: HeroImage(url: null),
  );

  await manager.saveHero(hero);
  print("\nEgen hjälte skapad: $nameInput!");
  print("   Styrka: $strength | Kraft: $power | Alignment: $alignment");
}

// 3. VISA ALLA
Future<void> showHero() async {
  final heroes = await manager.getHeroList();
  if (heroes.isEmpty) {
    print("\nInga hjältar i din lokala lista än.");
    return;
  }
  print("\nDINA HJÄLTAR (starkast först):");
  for (var h in heroes) {
    final strength = h.powerstats?.strength ?? 'Okänd';
    final power = h.powerstats?.power ?? 'Okänd';
    final alignment = h.biography?.alignment ?? 'Okänd';
    print("• ${h.name} | Styrka: $strength | Kraft: $power | ${alignment.toUpperCase()}");
  }
}

// 4. SÖK LOKALT
Future<void> searchLocalHero() async {
  stdout.write("\nSök i din lokala lista (namn): ");
  final input = stdin.readLineSync()?.trim();

  if (input == null || input.isEmpty) {
    print("Du måste skriva något!");
    return;
  }

  final results = await manager.searchHero(input);
  if (results.isEmpty) {
    print("Ingen lokal hjälte hittades med '$input'.");
  } else {
    print("\nLokala träffar:");
    for (var h in results) {
      final strength = h.powerstats?.strength ?? 'Okänd';
      final power = h.powerstats?.power ?? 'Okänd';
      final alignment = h.biography?.alignment ?? 'Okänd';
      print("• ${h.name} | Styrka: $strength | Kraft: $power | ${alignment.toUpperCase()}");
    }
  }
}
// 6. RADERA HJÄLTE
Future<void> deleteHero() async {
  final heroes = await manager.getHeroList();
  if (heroes.isEmpty) {
    print("\nInga hjältar att radera.");
    return;
  }

  print("\nVälj en hjälte att RADERA:");
  for (int i = 0; i < heroes.length; i++) {
    final h = heroes[i];
    print("${i + 1}. ${h.name} | Styrka: ${h.powerstats?.strength}");
  }

  stdout.write("\nNummer (eller 0 för att avbryta): ");
  final choice = stdin.readLineSync();
  final index = int.tryParse(choice ?? '') ?? -1;

  if (index <= 0 || index > heroes.length) {
    print("Ingen hjälte raderades.");
    return;
  }

  final heroToDelete = heroes[index - 1];

  // Bekräfta
  stdout.write("\nÄR DU SÄKER? Radera '${heroToDelete.name}'? (ja/nej): ");
  final confirm = stdin.readLineSync()?.trim().toLowerCase();

  if (confirm != 'ja' && confirm != 'j') {
    print("Radering avbruten.");
    return;
  }

  // Radera från _heroes-listan i HeroDataManager
  // Vi använder en "hack" – eftersom _heroes är privat
  // Istället: ladda om listan, ta bort, spara ny lista

  final currentList = await manager.getHeroList();
  currentList.removeWhere((h) => h.id == heroToDelete.id);
  
  // Spara den nya listan
  final file = File('heroes.json');
  final jsonList = currentList.map((h) => h.toJson()).toList();
  await file.writeAsString(json.encode(jsonList));

  // Uppdatera minnstans (valfritt – men viktigt!)
  await manager.init(); // Laddar om från fil

  print("\nHJÄLTE RADERAD: ${heroToDelete.name}");
}

// 7. VISA HJÄLTAR EFTER ALIGNMENT
Future<void> showHeroesByAlignment() async {
  final heroes = await manager.getHeroList();
  if (heroes.isEmpty) {
    print("\nInga hjältar att visa.");
    return;
  }

  print("\n" + "=" * 50);
  print("   VISA HJÄLTAR EFTER TILLHÖRIGHET");
  print("=" * 50);
  print("1. Goda (good)");
  print("2. Onda (bad)");
  print("3. Neutrala (neutral)");
  print("4. Alla hjältar");
  stdout.write("\nDitt val: ");
  final choice = stdin.readLineSync()?.trim();

  List<HeroModel> filtered = [];
  String title = "";

  switch (choice) {
  case "1":
      filtered = heroes.where((h) => ((h.biography?.alignment ?? 'neutral').toLowerCase()) == 'good').toList();
      title = "GODA HJÄLTAR";
      break;
    case "2":
      filtered = heroes.where((h) => ((h.biography?.alignment ?? 'neutral').toLowerCase()) == 'bad').toList();
      title = "ONDA HJÄLTAR";
      break;
    case "3":
      filtered = heroes.where((h) => ((h.biography?.alignment ?? 'neutral').toLowerCase()) == 'neutral').toList();
      title = "NEUTRALA HJÄLTAR";
      break;
    case "4":
      filtered = heroes;
      title = "ALLA HJÄLTAR";
    break;
    default:
      print("Ogiltigt val!");
      return;
  }

  if (filtered.isEmpty) {
    print("\nInga $title att visa.");
    return;
  }

  print("\n$title (${filtered.length} st):");
  for (var h in filtered) {
    final strength = h.powerstats?.strength ?? 'Okänd';
    final power = h.powerstats?.power ?? 'Okänd';
    final align = (h.biography?.alignment ?? 'neutral').toUpperCase();
    print("• ${h.name} | Styrka: $strength | Kraft: $power | $align");
  }
}